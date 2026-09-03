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
            url: "https://github.com/keylight-dev/keylight-binaries/releases/download/0.10.0/KeylightSDK.xcframework.zip",
            checksum: "27cc573630deb42743fa356a9acc0ab048aea081d72931cb285d6a69240ef3ca"
        ),
    ]
)
