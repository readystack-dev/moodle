# Provenance — Moodle (`v5.3.0-CE-ubuntu24.04-r9`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/moodle/moodle
- Revision built: `v5.3.0` (commit `42622298fe06f9626d988d60b2bf589bd8f850e8`)
- Source tree: `096a48537238e07dd94531ff70477bcaca97e3f58f53ae8baf8ad50c8a5c708f` over 67589 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-php`; base image `ubuntu:24.04`
- Built with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795543305` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/moodle:v5.3.0-CE-ubuntu24.04-r9` — index digest `sha256:349a76aef0429b788cd8e26e38e13b9e9f40f1bb929a95b41f54177d0ffeeaec` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:deb5fb50964cc048d1121b4562b98df1ed075bd4e7d25f953317a0c8f81fcb79` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/moodle:v5.3.0-CE-ubuntu24.04-r9`

## Pinned inputs, and why

- 28 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 1, image digests 1, language runtimes and toolchains 1, dependency versions readystack sets 15, pins in the kit's dockerfiles 2, readystack's build engine 1, dependencies upstream chose 2, services the release checks run beside 3).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.trail.json`, published beside this archive and signed with the release key (`ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.trail.json.sigstore`), and readable at https://readystack.dev/products/moodle/trail/v5.3.0-CE-ubuntu24.04-r9.

