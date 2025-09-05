import Foundation
import CoreML

enum MLRun {
    struct CLIError: Error, CustomStringConvertible {
        let description: String
    }

    static func run(args: [String]) -> String {
        do {
            let modelPath = try argValue(args, key: "--model")
            let inputPath = try argValue(args, key: "--input")
            let outPath   = try argValue(args, key: "--out")

            let config = MLModelConfiguration()
            // Default: allow GPU/ANE
            config.computeUnits = .all

            let url = URL(fileURLWithPath: modelPath)
            let model = try MLModel(contentsOf: url, configuration: config)

            // Read JSON input (very simple: one dict of string->double)
            let data = try Data(contentsOf: URL(fileURLWithPath: inputPath))
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]

            // Build MLDictionaryFeatureProvider
            let provider = try MLDictionaryFeatureProvider(dictionary: json)
            let out = try model.prediction(from: provider)
            let outDict = out.dictionaryRepresentation

            let outData = try JSONSerialization.data(withJSONObject: outDict, options: [.prettyPrinted])
            try outData.write(to: URL(fileURLWithPath: outPath))
            return "OK: wrote \(outPath)"
        } catch {
            return "ml_run error: \(error)\nUsage: ml_run --model <path> --input <json> --out <json>"
        }
    }

    private static func argValue(_ args: [String], key: String) throws -> String {
        guard let i = args.firstIndex(of: key), i+1 < args.count else {
            throw CLIError(description: "missing \(key)")
        }
        return args[i+1]
    }
}
