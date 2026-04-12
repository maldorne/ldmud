# LDMud — `3.6.8`

Docker image for [LDMud](https://github.com/ldmud/ldmud) version `3.6.8` (latest stable, 2025), built on Debian 12 Bookworm with MySQL/MariaDB and SQLite support enabled.

This branch publishes `ghcr.io/maldorne/ldmud:3.6.8` on every push, via the workflow at `.github/workflows/publish-ghcr.yaml`.

## What this image provides

- The `ldmud` driver binary at `/opt/mud/bin/ldmud`
- The `erq` external request daemon at `/opt/mud/libexec/erq` (if the build produces it)
- MariaDB client libraries for `db_connect()` / `db_exec()` LPC efuns
- SQLite support for `sl_open()` / `sl_exec()` LPC efuns
- `git` and `openssh-client` for use as a base for runner images
- Unprivileged user `mud` (uid 4201, gid 4200) — same as the MudOS images

The source is cloned from the official [ldmud/ldmud](https://github.com/ldmud/ldmud) repository at the `3.6.8` tag during the Docker build. No source code is stored in this repo.

> [!NOTE]
> LDMud 3.6+ enforces UTF-8 encoding for LPC source files. Mudlibs with source files in ISO-8859-1 or other legacy encodings will fail to compile on this version. Use `3.3.720` for those.

## Running standalone

```sh
docker run --rm -ti -p 5050:5050 \
  -v /path/to/your/mudlib:/mud/lib \
  ghcr.io/maldorne/ldmud:3.6.8 \
  /opt/mud/bin/ldmud -m /mud/lib -M secure/master.c 5050
```

## Other versions

Switch branches to find images for other LDMud versions: `3.3.720`. The `master` branch only has the project overview.
