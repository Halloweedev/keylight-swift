import KeylightSDK
import SwiftUI

struct RootView: View {
    @EnvironmentObject private var manager: LicenseManager
    @State private var showingPaywall = false

    var body: some View {
        VStack(spacing: 20) {
            header

            Divider()

            if manager.isEntitled {
                featuresSection
            } else {
                lockedSection
            }

            Spacer()

            footer
        }
        .padding(24)
        .frame(minWidth: 420, minHeight: 360)
        .onChange(of: manager.state) { newState in
            switch newState {
            case .expired, .invalid:
                showingPaywall = true
            case .trial, .licensed:
                showingPaywall = false
            }
        }
        .sheet(isPresented: $showingPaywall) {
            LicensePromptView(manager: manager)
                .frame(minWidth: 400, minHeight: 400)
        }
    }

    // MARK: - Sections

    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(manager.branding.appName)
                .font(.title2).bold()
            Text(statusDescription)
                .font(.callout)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var featuresSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Features")
                .font(.headline)
            Label("Gated feature A", systemImage: "sparkles")
            Label("Gated feature B", systemImage: "wand.and.stars")
            Label("Gated feature C", systemImage: "bolt.fill")

            if case .licensed = manager.state {
                Button("Deactivate this device") {
                    Task { await manager.deactivate() }
                }
                .buttonStyle(.bordered)
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var lockedSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Features locked")
                .font(.headline)
            Text("Your trial has ended. Activate a license to keep using the app.")
                .foregroundStyle(.secondary)
            Button("Open paywall") { showingPaywall = true }
                .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var footer: some View {
        HStack {
            Text("Keylight demo — state: \(stateLabel)")
                .font(.caption)
                .foregroundStyle(.tertiary)
            Spacer()
            Button("Settings") { showingPaywall = true }
                .buttonStyle(.bordered)
        }
    }

    // MARK: - Helpers

    private var stateLabel: String {
        switch manager.state {
        case .trial(let days): return "trial (\(days) days left)"
        case .licensed: return "licensed"
        case .expired: return "expired"
        case .invalid: return "invalid"
        }
    }

    private var statusDescription: String {
        switch manager.state {
        case .trial(let days):
            return "\(days) day\(days == 1 ? "" : "s") left in your trial"
        case .licensed:
            return "Thanks for purchasing!"
        case .expired:
            return "Your trial has ended."
        case .invalid:
            return "License could not be verified."
        }
    }
}
