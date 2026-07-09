// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Keylight",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "KeylightSDK",
            targets: ["KeylightSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "KeylightSDK",
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.8.2/KeylightSDK.xcframework.zip",
            checksum: "21e9559ef566c2a8ca07aca940b0ec65536fe6e328c3587f8c52d14a0fa68eb3"
        ),
    ]
)
