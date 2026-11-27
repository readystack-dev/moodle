# Provenance — Moodle (`v5.3.1-CE-ubuntu24.04-r2`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/moodle/moodle
- Revision built: `v5.3.1` (commit `cfe123f26fc7071981fe949cb16cd5a08a8234f1`)
- Source tree: `5fd543d0965986bf74e04205485028788f52b71b03899f03f56511703c4f4c99` over 67643 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-php`; base image `ubuntu:24.04`
- Built with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795644309` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/moodle:v5.3.1-CE-ubuntu24.04-r2` — index digest `sha256:6d40d8e13e03c50d9ac88611f9ad2b3f93633807bd48883b1d3b1ba96d5c8341` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:e4eb38b4f393108f2e2f2dae5e08f827957d03f77ecde56da2ba254518d8d108` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.1-CE-ubuntu24.04-r2`

## Pinned inputs, and why

- 29 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 1, image digests 1, language runtimes and toolchains 1, dependency versions readystack sets 16, pins in the kit's dockerfiles 2, readystack's build engine 1, dependencies upstream chose 2, services the release checks run beside 3).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.trail.json`, published beside this archive and signed with the release key (`ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.trail.json.sigstore`), and readable at https://readystack.dev/products/moodle/trail/v5.3.1-CE-ubuntu24.04-r2.

