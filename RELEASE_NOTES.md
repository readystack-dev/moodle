# Moodle v5.3.1 — ReadyStack release `v5.3.1-CE-ubuntu24.04-r1`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/moodle:v5.3.1-CE-ubuntu24.04-r1` (linux/amd64). Index digest `sha256:f652c6aa90a417d81f827fdbf7fbb865d830b0f58d7f600332a4b27646515268` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:879bc881fbbdf0fee6635ac8775f4beea031775790e7fe28487924a64aec023f` [`TARGET_DIGEST.txt`].
- **Upstream:** Moodle v5.3.1 built from source at `v5.3.1` of https://github.com/moodle/moodle — upstream notes: https://github.com/moodle/moodle/releases/tag/v5.3.1 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `www-data`.
- **Build:** `source-rebuild-php`, built offline with `--network=none`.
- **Supersedes:** ReadyStack release `v5.3.0-CE-ubuntu24.04-r9`.

## What changed in this release

- Upstream version v5.3.0 → v5.3.1.
- This release moves Moodle from 5.3.0 to 5.3.1, a newer release of upstream's 5.3.x line. Upstream's release notes list what changed: https://github.com/moodle/moodle/releases/tag/v5.3.1

## Security status at release (measured 2026-11-25)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `www-data` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.1-CE-ubuntu24.04-r1` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:879bc881fbbdf0fee6635ac8775f4beea031775790e7fe28487924a64aec023f`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (2 authored) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /login/index.php` (200), `GET /login/forgot_password.php` (200); the suite checks nothing else.

## Known issues

- None found (reviewed by held semantic review (Claude) on 2026-11-25).

## Defects fixed

- 1 problem found before release and fixed before it shipped (1 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.1-CE-ubuntu24.04-r1
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

