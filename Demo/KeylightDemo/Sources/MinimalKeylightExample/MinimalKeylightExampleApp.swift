import AppKit
import CryptoKit
import Foundation
import KeylightSDK
import SwiftUI

// ---------------------------------------------------------------------------
// Minimal Keylight consumer app
//
// Points at the LIVE Keylight Worker at licensing.anotheragence.com using the
// `testco/testapp` dry-run tenant. The trusted public key below is the real
// `k1` Ed25519 public key for testco — leases signed by the Worker's matching
// private key will verify at runtime.
//
// To try it end-to-end:
//
//   1. Seed a test license (prints the key):
//        cd worker && node scripts/seed-test-license.js testco testapp TEST 3
//
//   2. Run the app:
//        cd examples/minimal-macos-app && swift run
//
//   3. In the app window, click "Settings" to open the paywall, paste the
//      license key, click "Activate" → state becomes .licensed. Click
//      "Deactivate this device" to return to trial.
//
// On first launch the trial starts automatically (14 days).
// ---------------------------------------------------------------------------

@main
struct MinimalKeylightExampleApp: App {
    // Without this adaptor, `swift run` launches the process as a command-line
    // tool: the window opens but never becomes the foreground app, so the
    // TextField in LicensePromptView can't receive keyboard input. The
    // delegate promotes us to a regular GUI app and brings the window forward.
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate

    @StateObject private var manager = LicenseManager(provider: makeProvider())
    @Environment(\.scenePhase) private var scenePhase

    var body: some Scene {
        WindowGroup("Keylight Example") {
            RootView()
                .environmentObject(manager)
                .task {
                    await manager.checkOnLaunch()
                }
                .onChange(of: scenePhase) { phase in
                    if phase == .active {
                        Task { await manager.refreshIfNeeded() }
                    }
                }
        }
    }
}

// MARK: - App delegate (forces GUI activation for `swift run`)

final class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)
        NSApp.activate(ignoringOtherApps: true)
    }

    /// Quit the whole process when the last window closes, so Cmd-W is
    /// equivalent to Cmd-Q. This is what you want for a throwaway demo.
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        true
    }
}

// MARK: - Provider wiring

/// testco `k1` public key, raw 32-byte base64. Must match the private key
/// stored on the Worker as `ED25519_PRIVATE_KEY_TESTCO`.
private let TESTCO_K1_PUBKEY_B64 = "PH/VnSoj6nAq8el0a1Mcr/6AskAypW+0RKdZYubLfG0="

private func makeProvider() -> CloudflareProvider {
    guard let pubKeyData = Data(base64Encoded: TESTCO_K1_PUBKEY_B64),
          let pubKey = try? Curve25519.Signing.PublicKey(rawRepresentation: pubKeyData) else {
        fatalError("Invalid testco k1 public key — check TESTCO_K1_PUBKEY_B64")
    }

    let config = KeylightConfiguration(
        sdkKey: "sdk_live_test000000000000000000000000000000000000000000000000000000",
        tenantId: "testco",
        productId: "testapp",
        keyPrefix: "TEST",
        trialDurationDays: 14,
        trustedPublicKeys: ["k1": pubKey],
        keychainServicePrefix: "dev.keylight.example.testco",
        fileStoragePolicy: FileStoragePolicy.defaultPolicy(tenantId: "testco"),
        branding: BrandingConfig(
            appName: "Keylight Example",
            purchaseURL: URL(string: "https://example.com/buy")!,
            supportEmail: "hello@example.com",
            tintColor: .blue
        )
    )

    return CloudflareProvider(configuration: config)
}
