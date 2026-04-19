# Changelog

All notable changes to Keylight are documented in this file.

## 0.3.0 — Unreleased

### Breaking

- `CloudflareProvider.init(baseURL:configuration:session:)` is removed from the public API. The Worker origin is now hardcoded in the SDK. Migrate to `Keylight.manager(...)` or `CloudflareProvider(configuration:)`.
- `KeylightConfiguration` gains a required `sdkKey: String` parameter (first argument). Issue one from your Keylight dashboard and bundle it into your app.
- SwiftPM product renamed from `Keylight` to `KeylightSDK`. Consumers update `import Keylight` → `import KeylightSDK`. Factory call `Keylight.manager(...)` unchanged.

### Added

- `Keylight.manager(...)` one-call factory — build a ready `LicenseManager` without instantiating `KeylightConfiguration`, `CloudflareProvider`, or `LicenseManager` individually.
- `X-Keylight-SDK-Key` header is now attached to every Worker request and validated server-side.
- Dashboard: "SDK Key" section with rotate-and-reveal flow.

### Migration

Existing tenants are in **legacy mode** (`sdkKeyHash: null`) and continue to accept requests with no header. The dashboard shows a one-time "Generate your SDK key" banner; once generated, the gate becomes mandatory for that tenant. Your shipped apps on 0.2.x continue to work against legacy-mode tenants — upgrade at your own pace.

## [0.2.0] - 2026-04-12

### Added
- Self-service tenant signup at `/signup` with Turnstile CAPTCHA and email verification
- Operator admin portal at `/admin` with tenants list, detail, mutations, plans, metrics, and audit log
- Stripe Billing integration: paid plan checkout, subscription lifecycle webhooks
- KV-backed tenant storage (`KVTenantResolver`) with uniqueness enforcement on email, keyPrefix, tenantId
- AES-GCM master encryption key for Ed25519 private key storage at rest
- Argon2id password hashing via `@noble/hashes` with dual-verify PBKDF2 migration
- `TenantCounterDO` Durable Object for per-tenant usage metering (licenses, instances, API calls)
- Hard instance cap enforcement at `/activate` via atomic check-and-increment
- Soft license/API metering with 90% warning emails via Resend
- 6-state tenant lifecycle machine: `pending_verification → trial → active → past_due → canceled → suspended`
- Route authorization guards (`requireOperatorSession`, `requireTenantSession`, `requireTenantAndState`)
- Structured audit log in KV with 365-day TTL and inverted-timestamp ordering
- Resend email wrapper with 5 templates (verify, warning, mint confirmation, cancellation, operator notify)
- Turnstile server-side verification for signup anti-abuse
- Dashboard usage bars with yellow (75%) and red (90%) banners
- Manual license mint from tenant dashboard
- CSV license export (Enterprise-only feature gate)
- Product management with `maxProducts` plan cap
- Reconciliation CLI script for counter drift correction
- Grace period reaper (lazy: canceled → suspended after 7 days)
- Stripe Billing customer portal integration for plan self-service

### Changed
- `makeTenantResolver()` returns composite resolver (KV-first, bundled fallback)
- `makeSecretResolver()` returns composite resolver (encrypted KV-first, Wrangler fallback)
- Session cookies include `role` field (`tenant` or `operator`)
- `verifyPassword()` dispatches on prefix (`argon2id$` or `pbkdf2$`)
- Login handler silently rehashes PBKDF2 → Argon2id on success

### Deprecated
- Static `BUNDLED_TENANTS` list (retained as migration fallback only)
- `KEYLIGHT_DASHBOARD_PASSWORD_HASH_<TENANT_ID>` Wrangler secrets (new tenants store hash in KV)

## [0.1.0] - 2026-04-10

### Added
- Multi-tenant licensing foundation
- Swift SDK with SwiftUI paywall view
- Cloudflare Worker backend with Ed25519 lease signing
- Stripe webhook license issuance
- Per-tenant dashboard with PBKDF2 auth
- LicenseDO Durable Object for serialized mutations
