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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.8.5/KeylightSDK.xcframework.zip",
            checksum: "2dcc68ec0743763e609c1903c881afd4d48beb144fbae99a5b02850038b2a5d9"
        ),
    ]
)
