# Minimal Keylight Example (macOS)

A bare-bones SwiftUI app that shows how to integrate Keylight into a macOS
consumer app. It starts a 14-day trial on first launch, exposes a trial
countdown, gates a "Features" section on `manager.isEntitled`, and presents
`LicensePromptView` as a sheet when the trial expires.

## Run it

1. **Start the Worker locally**, from another terminal window:
   ```bash
   cd worker
   npx wrangler dev
   ```
   Leave it running. Wrangler will print `Ready on http://localhost:8787`.

2. **Seed a local `demoapp` tenant** (optional — only needed if you want to
   try activation, not just the trial):
   Add an entry to `worker/src/config/tenants.ts`:
   ```ts
   {
     tenantId: 'demoapp',
     displayName: 'Demo App',
     supportEmail: 'hello@example.com',
     keyPrefix: 'DEMO',
     primaryKid: 'k1',
     products: [{
       productId: 'demo',
       displayName: 'Keylight Example',
       purchaseURL: 'https://example.com/buy',
       brandColor: '#2563eb',
       maxActivations: 3,
       trialDurationDays: 14,
     }],
   }
   ```
   Restart `wrangler dev` to pick up the change.

3. **Run the example app**:
   ```bash
   cd examples/minimal-macos-app
   swift run
   ```

You should see a window with the app name, a trial countdown, and the
"Features" section visible because the trial is active on first launch.

## What this demonstrates

- Constructing a `KeylightConfiguration` with all the fields filled in
- Wiring `CloudflareProvider` to a local Worker via `baseURL`
- Using `@StateObject LicenseManager` in a SwiftUI `App`
- Calling `manager.checkOnLaunch()` in a `.task { }`
- Feature gating via `manager.isEntitled`
- Presenting `LicensePromptView` as a sheet on state transitions
- Deactivating from within the app when state is `.licensed`

## What it doesn't demonstrate

- Real license activation (requires a seeded tenant + Ed25519 secrets on the
  Worker — follow `docs/adding-a-tenant.md` to set one up)
- Stripe webhook flow (requires a real Stripe account + webhook forwarder)
