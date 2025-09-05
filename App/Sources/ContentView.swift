import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("GPU-Terminal")
                .font(.largeTitle).bold()
            Text("Stub UI — wire SwiftTerm here")
                .foregroundColor(.secondary)
            Divider()
            ScrollView {
                Text(output).font(.system(.body, design: .monospaced))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            HStack {
                TextField("Type a command (e.g., gpu_info)", text: $command, axis: .horizontal)
                    .textFieldStyle(.roundedBorder)
                Button("Run") { runCommand() }
                    .buttonStyle(.borderedProminent)
            }.padding(.horizontal)
        }.padding()
    }

    @State private var command: String = ""
    @State private var output: String = ""

    func runCommand() {
        output += "$ " + command + "\n"
        output += CommandRouter.shared.dispatch(line: command) + "\n"
        command = ""
    }
}
