# GPU-Terminal (iPad, no-Mac dev loop)

This repo is a **starter kit** for an iPad “terminal-ish” app you can edit on iPad (via Codespaces or a simple editor) and build/deploy with **GitHub Actions** to **TestFlight** (no local Mac required).

> Note: The Swift files here are **stubs** meant to drop into an Xcode iOS App project. Your CI (GitHub Actions) will build the app on a **macOS runner**. On iPad you can prototype UI/logic in **Swift Playgrounds**, but the full build needs Xcode on CI.

## Features (goal)
- Terminal UI via **SwiftTerm** (added as SPM dependency in Xcode).
- Unix-like commands via **ios_system** (add frameworks in Xcode).
- GPU/ML hooks: **Metal/MPS/Core ML** commands (`gpu_info`, `ml_run`, etc.).
- `pkg` **facade** that installs **pure-Python** packages and **models/data** (not native code).
- Optional: **FFmpegKit** and **whisper.cpp** for media + STT.

## Quick Start
1. **Create an iOS App** in Xcode (CI will do the building later). Use Bundle ID like `com.example.gputerminal` and scheme `GPU-Terminal`.
2. Add **SwiftTerm** via SPM: `https://github.com/migueldeicaza/SwiftTerm`.
3. Build **ios_system** (or reuse prebuilts) and add frameworks to “Embedded Binaries” (Embed & Sign).
4. (Optional) Add **FFmpegKit** via SPM, and add **whisper.cpp** (iOS/Metal) sources as a target.
5. Drop the Swift files from `App/Sources` into your Xcode project.
6. Commit & push. Configure **GitHub Secrets** (see `Scripts/prepare_secrets.md`), then your CI will Archive + upload to **TestFlight**.
7. Install on iPad via **TestFlight**.

## NOTE on packages
- At runtime, `pkg` installs **pure-Python** wheels (into sandbox) and **non-executable models/data** (e.g., `.coremlpackage`, `.gguf`, `.onnx`). No native code can be installed at runtime on iOS.
