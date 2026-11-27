# Moodle v5.3.1 — ReadyStack release `v5.3.1-CE-ubuntu24.04-r2`

Generated 2026-11-27 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/moodle:v5.3.1-CE-ubuntu24.04-r2` (linux/amd64). Index digest `sha256:6d40d8e13e03c50d9ac88611f9ad2b3f93633807bd48883b1d3b1ba96d5c8341` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:e4eb38b4f393108f2e2f2dae5e08f827957d03f77ecde56da2ba254518d8d108` [`TARGET_DIGEST.txt`].
- **Upstream:** Moodle v5.3.1 built from source at `v5.3.1` of https://github.com/moodle/moodle — upstream notes: https://github.com/moodle/moodle/releases/tag/v5.3.1 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `www-data`.
- **Build:** `source-rebuild-php`, built offline with `--network=none`.
- **Supersedes:** ReadyStack release `v5.3.1-CE-ubuntu24.04-r1`.

## What changed in this release

- Upstream version unchanged (v5.3.1); ReadyStack rebuild.
- Moodle v5.3.1 is unchanged from the release this supersedes (v5.3.1-CE-ubuntu24.04-r1); this release rebuilds it. Changes: libexpat1 moves from 2.6.1-2ubuntu0.6 to 2.6.1-2ubuntu0.7 (USN-9196-1). Settings, ports and data volumes are those of v5.3.1-CE-ubuntu24.04-r1: replace the container with this image on the same volumes.

## Security status at release (measured 2026-11-27)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `www-data` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.1-CE-ubuntu24.04-r2` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:e4eb38b4f393108f2e2f2dae5e08f827957d03f77ecde56da2ba254518d8d108`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (2 authored) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /login/index.php` (200), `GET /login/forgot_password.php` (200); the suite checks nothing else.

## Known issues

- **high** (ReadyStack package): Admin handbook: Stale superseded release tag left in the offline-rebuild text. [`RSD-moodle-b316dd4628`] (carried from `v5.3.1-CE-ubuntu24.04-r1`, recorded there as `RSD-moodle-01cb5a1b31`)

## Defects fixed

- 2 problems found before release and fixed before it shipped (2 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.1-CE-ubuntu24.04-r2
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

