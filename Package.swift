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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.12.0/KeylightSDK.xcframework.zip",
            checksum: "181f5f99b2a559b21edfcfaa3977be8a5cfd7c016797ba10402d8db6fe75779f"
        ),
    ]
)
