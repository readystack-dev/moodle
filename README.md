# Moodle: ReadyStack build kit

The offline build kit for the Docker image `readystack/moodle:v5.3.0-CE-ubuntu24.04-r9`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v5.3.0-CE-ubuntu24.04-r9](https://github.com/readystack-dev/moodle/releases/tag/v5.3.0-CE-ubuntu24.04-r9)
- Image: [`docker.io/readystack/moodle:v5.3.0-CE-ubuntu24.04-r9`](https://hub.docker.com/r/readystack/moodle/tags), manifest digest `sha256:deb5fb50964cc048d1121b4562b98df1ed075bd4e7d25f953317a0c8f81fcb79`
- Product page: https://readystack.dev/products/moodle
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=moodle

Moodle is distributed under its upstream licence (GPL-3.0-or-later); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v5.3.0-CE-ubuntu24.04-r9 release](https://github.com/readystack-dev/moodle/releases/tag/v5.3.0-CE-ubuntu24.04-r9): `ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.tar.gz` (370.6 MB), SHA-256 `ee940ac2bed46dc094ff5aee332d4cef9c8d25886ac29d49b6e6f105d5435c0b`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.rebuild.json.sigstore ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.tar.gz
cd v5.3.0-CE-ubuntu24.04-r9
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-moodle-v5.3.0-CE-ubuntu24.04-r9.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/moodle/recipe. The complete kit is the release download. Each release is a tag here.
