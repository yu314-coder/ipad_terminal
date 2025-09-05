import Foundation

enum Pkg {
    static func run(args: [String]) -> String {
        guard let sub = args.first else { return usage() }
        switch sub {
        case "search":
            let q = args.dropFirst().joined(separator: " ")
            return search(query: q)
        case "install":
            guard let name = args.dropFirst().first else { return "pkg install <name>" }
            return install(name: name)
        case "list":
            return list()
        case "remove":
            guard let name = args.dropFirst().first else { return "pkg remove <name>" }
            return remove(name: name)
        default:
            return usage()
        }
    }

    static func usage() -> String {
        return "pkg <search|install|list|remove> ..."
    }

    static let registryPath = FileManager.default.homeDirectoryForCurrentUser
        .appendingPathComponent("Assets/pkg_registry.json").path

    static func readRegistry() -> [[String: Any]] {
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: registryPath)),
              let arr = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] else { return [] }
        return arr
    }

    static func search(query: String) -> String {
        let items = readRegistry()
        let hits = items.filter { ($0["name"] as? String ?? "").localizedCaseInsensitiveContains(query) }
        if hits.isEmpty { return "No results." }
        return hits.map { i in
            let n = i["name"] as? String ?? "item"
            let d = i["desc"] as? String ?? ""
            return "- \(n): \(d)"
        }.joined(separator: "\n")
    }

    static func install(name: String) -> String {
        // Stub: implement pure-Python pip and model/data downloaders here.
        return "Installed (stub): \(name)"
    }

    static func list() -> String {
        // Stub: list installed items in ~/Packages and ~/Models
        return "Installed packages (stub)"
    }

    static func remove(name: String) -> String {
        // Stub: delete files and update manifests
        return "Removed (stub): \(name)"
    }
}
