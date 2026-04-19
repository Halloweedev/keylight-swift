// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MinimalKeylightExample",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/Halloweedev/keylight-swift.git", exact: "0.3.0"),
    ],
    targets: [
        .executableTarget(
            name: "MinimalKeylightExample",
            dependencies: [
                .product(name: "KeylightSDK", package: "keylight-swift"),
            ],
            path: "Sources/MinimalKeylightExample"
        ),
    ]
)
