# Moodle: ReadyStack build kit

The offline build kit for the Docker image `readystack/moodle:v5.3.1-CE-ubuntu24.04-r1`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [v5.3.1-CE-ubuntu24.04-r1](https://github.com/readystack-dev/moodle/releases/tag/v5.3.1-CE-ubuntu24.04-r1)
- Image: [`docker.io/readystack/moodle:v5.3.1-CE-ubuntu24.04-r1`](https://hub.docker.com/r/readystack/moodle/tags), manifest digest `sha256:879bc881fbbdf0fee6635ac8775f4beea031775790e7fe28487924a64aec023f`
- Product page: https://readystack.dev/products/moodle
- Source and build recipe: https://readystack.dev/products/moodle/recipe
- Build trail: https://readystack.dev/products/moodle/trail/v5.3.1-CE-ubuntu24.04-r1
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=moodle

## The image

Single container (Apache + mod_php, one foreground process) running the Moodle LMS. It REQUIRES an EXTERNAL MySQL 8.4+ / MariaDB 11.4+ database the operator provisions and points the container at via DB_HOST/DB_PORT/DB_NAME/DB_USER/DB_PASS — there is NO embedded/SQLite database. On first start Moodle runs `php admin/cli/install.php` to create config.php + all module schema (a multi-minute one-time install). NOT a multi-service cluster, but NOT self-contained: a MySQL/MariaDB server is a hard external dependency, and moodledata + the DB must persist.

## Who uses Moodle and why

Schools, universities, companies and other organisations that run online learning and training.

Moodle is an open-source learning management system that gives educators, administrators and learners one integrated system for courses, activities, assignments, grading and progress tracking.

A typical use: A company trains staff in several offices. In Moodle the training team builds self-paced courses with forums and assignments, enrols each group of staff in the courses for their role, and tracks who has completed which course.

From the upstream project's own description: https://github.com/moodle/moodle, https://docs.moodle.org/en/About_Moodle, https://docs.moodle.org/en/Features.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 134 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`www-data`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-25; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/moodle.

Moodle is distributed under its upstream licence (GPL-3.0-or-later); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [v5.3.1-CE-ubuntu24.04-r1 release](https://github.com/readystack-dev/moodle/releases/tag/v5.3.1-CE-ubuntu24.04-r1): `ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r1.tar.gz` (370.8 MB), SHA-256 `dc5a538213d2767ae9ffb002ff40d5b4343b9d33d370a7dcffd2ffed8fd9c74c`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r1.rebuild.json.sigstore ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r1.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r1.tar.gz
cd v5.3.1-CE-ubuntu24.04-r1
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-moodle-v5.3.1-CE-ubuntu24.04-r1.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/moodle/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
