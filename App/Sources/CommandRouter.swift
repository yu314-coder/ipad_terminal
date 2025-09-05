import Foundation

final class CommandRouter {
    static let shared = CommandRouter()
    private init() {}

    func dispatch(line: String) -> String {
        let parts = line.split(separator: " ").map(String.init)
        guard let cmd = parts.first else { return "" }
        let args = Array(parts.drop(1))

        switch cmd {
        case "help":
            return help()
        case "gpu_info":
            return GPUInfo.run(args: args)
        case "ml_run":
            return MLRun.run(args: args)
        case "whisper":
            return Whisper.run(args: args)
        case "ffmpeg":
            return FFmpeg.run(args: args)
        case "pkg":
            return Pkg.run(args: args)
        default:
            return "Unknown command: \(cmd). Try 'help'."
        }
    }

    private func help() -> String {
        return [
            "Commands:",
            "  gpu_info                 - Show GPU/ANE info",
            "  ml_run --model <path>    - Run a Core ML model with JSON IO",
            "  whisper <wav/m4a> --model <ggml> --gpu",
            "  ffmpeg <args>            - Media tools (requires FFmpegKit wiring)",
            "  pkg <search|install|list|remove> ...",
            "  help                     - This help",
        ].joined(separator: "\n")
    }
}
