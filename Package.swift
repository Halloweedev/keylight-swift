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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.8.3/KeylightSDK.xcframework.zip",
            checksum: "0b59c7939c1bf3e81a6a7000daddca22c7d1e9553c9af5ac4ced91ec1e0596a8"
        ),
    ]
)
