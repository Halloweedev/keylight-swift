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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.9.0/KeylightSDK.xcframework.zip",
            checksum: "b640a7e9fc413bfb7d0682fe2361528567fb676743a71a7bba5129635853cd32"
        ),
    ]
)
