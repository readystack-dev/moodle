[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fmoodle-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/moodle) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/moodle)](https://hub.docker.com/r/readystack/moodle) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/moodle) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# Moodle: ReadyStack build kit

The offline build kit for the Docker image `readystack/moodle:v5.3.1-CE-ubuntu24.04-r2`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v5.3.1-CE-ubuntu24.04-r2](https://github.com/readystack-dev/moodle/releases/tag/v5.3.1-CE-ubuntu24.04-r2)
- Image: [`docker.io/readystack/moodle:v5.3.1-CE-ubuntu24.04-r2`](https://hub.docker.com/r/readystack/moodle/tags), manifest digest `sha256:e4eb38b4f393108f2e2f2dae5e08f827957d03f77ecde56da2ba254518d8d108`
- Product page: https://readystack.dev/products/moodle
- Source and build recipe: https://readystack.dev/products/moodle/recipe
- Build trail: https://readystack.dev/products/moodle/trail/v5.3.1-CE-ubuntu24.04-r2
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=moodle

## The image

Single container (Apache + mod_php, one foreground process) running the Moodle LMS. It REQUIRES an EXTERNAL MySQL 8.4+ / MariaDB 11.4+ database the operator provisions and points the container at via DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASS — there is NO embedded/SQLite database. On first start Moodle runs `php admin/cli/install.php` to create config.php + all module schema (a multi-minute one-time install). NOT a multi-service cluster, but NOT self-contained: a MySQL/MariaDB server is a hard external dependency, and moodledata + the DB must persist.

## Who uses Moodle and why

Schools, universities, companies and other organisations that run online learning and training.

Moodle is an open-source learning management system that gives educators, administrators and learners one integrated system for courses, activities, assignments, grading and progress tracking.

A typical use: A company trains staff in several offices. In Moodle the training team builds self-paced courses with forums and assignments, enrols each group of staff in the courses for their role, and tracks who has completed which course.

From the upstream project's own description: https://github.com/moodle/moodle, https://docs.moodle.org/en/About_Moodle, https://docs.moodle.org/en/Features.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-27 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 134 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`www-data`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-27; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/moodle.

Moodle is distributed under its upstream licence (GPL-3.0-or-later); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v5.3.1-CE-ubuntu24.04-r2 release](https://github.com/readystack-dev/moodle/releases/tag/v5.3.1-CE-ubuntu24.04-r2): `ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.tar.gz` (370.8 MB), SHA-256 `55d27b54e2905379f52b56eef7b45292981879a06d073759f0abafed8a50c9dc`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.rebuild.json.sigstore ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.tar.gz
cd v5.3.1-CE-ubuntu24.04-r2
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r2.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/moodle/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
