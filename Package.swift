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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.11.1/KeylightSDK.xcframework.zip",
            checksum: "af774ac7362c1d9b427123df0deabeb076f3edbc195c74d2a7d939b688d2a40f"
        ),
    ]
)
