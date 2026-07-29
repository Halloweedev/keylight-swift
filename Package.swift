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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.8.4/KeylightSDK.xcframework.zip",
            checksum: "8ac0d71dac45d3479142de477855054053d9c8602f64406dc451823d11888e4e"
        ),
    ]
)
