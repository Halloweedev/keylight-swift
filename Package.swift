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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.11.0/KeylightSDK.xcframework.zip",
            checksum: "d4b7e740b760a1f920454cf850bf58a8d55357258a39fe11e79ce38323b1fa55"
        ),
    ]
)
