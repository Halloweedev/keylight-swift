# Keylight Swift SDK

Drop-in SwiftUI licensing for macOS and iOS apps. Backed by the Keylight licensing service.

## Install

Add the package in Xcode via **File → Add Package Dependencies** with URL:

`https://github.com/Halloweedev/keylight-swift.git`

Or in `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/Halloweedev/keylight-swift.git", from: "0.3.0"),
],
targets: [
    .target(
        name: "YourApp",
        dependencies: [
            .product(name: "KeylightSDK", package: "keylight-swift"),
        ]
    ),
],
```

## Quickstart

See the full integration guide at [keylight.dev/docs/integration-swift](https://keylight.dev/docs/integration-swift).

## Demo

A minimal SwiftUI macOS app is included under `Demo/KeylightDemo`. Open in Xcode and run — it connects to the Keylight live service with a dry-run test tenant.
