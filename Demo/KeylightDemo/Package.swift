// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MinimalKeylightExample",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(path: "../..")
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
