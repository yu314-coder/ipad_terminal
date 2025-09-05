import Foundation
import Metal

enum GPUInfo {
    static func run(args: [String]) -> String {
        if let device = MTLCreateSystemDefaultDevice() {
            var lines: [String] = []
            lines.append("GPU: \(device.name)")
            lines.append("Max threads per threadgroup: \(device.maxThreadsPerThreadgroup)")
            lines.append("Has unified memory: \(device.hasUnifiedMemory ? "yes" : "no")")
            lines.append("Recommended max working set size: \(device.recommendedMaxWorkingSetSize) bytes")
            return lines.joined(separator: "\n")
        } else {
            return "No Metal device available."
        }
    }
}
