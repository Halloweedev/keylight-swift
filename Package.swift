// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "Keylight",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .tvOS(.v16),
        .watchOS(.v9),
        .visionOS(.v1),
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
            url: "https://github.com/Halloweedev/keylight-binaries/releases/download/0.3.0/KeylightSDK.xcframework.zip",
            checksum: "c80d064ccdd8c74f30ee36cf25fdf9b530a5faf0c69cbd936ed46b9a30b5e709"
        ),
    ]
)
