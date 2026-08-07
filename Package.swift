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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.8.6/KeylightSDK.xcframework.zip",
            checksum: "5c5b0f2815d684a111553c503b5c78490f7cfb832b309b0bcdcea60de286f555"
        ),
    ]
)
