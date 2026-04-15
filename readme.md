<p align="center">
  <img width="200" alt="LDMud logo" src="/ldmud-logo.svg">
</p>

# LDMud — `3.6.8-maldorne`

Maldorne fork of [LDMud](https://github.com/ldmud/ldmud) `3.6.8`, built on Debian 12 Bookworm with MySQL/MariaDB and SQLite support enabled, plus the following additions:

- **PROXY protocol v1 support** (`#define SUPPORT_PROXY_PROTOCOL`). The driver auto-detects incoming PROXY protocol headers (as sent by HAProxy, Traefik, etc.) and uses the real client IP instead of the proxy's IP. Connections without a PROXY header work normally. Supports both IPv4 and IPv6 (with IPv4-to-IPv6 mapping when compiled with `USE_IPV6`).

This branch publishes `ghcr.io/maldorne/ldmud:3.6.8-maldorne` on every push, via the workflow at `.github/workflows/publish-ghcr.yaml`.

## What this image provides

- The `ldmud` driver binary at `/opt/mud/bin/ldmud`
- The `erq` external request daemon at `/opt/mud/libexec/erq` (if the build produces it)
- MariaDB client libraries for `db_connect()` / `db_exec()` LPC efuns
- SQLite support for `sl_open()` / `sl_exec()` LPC efuns
- `git` and `openssh-client` for use as a base for runner images
- Unprivileged user `mud` (uid 4201, gid 4200)

The source is cloned from the official [ldmud/ldmud](https://github.com/ldmud/ldmud) repository at the `3.6.8` tag during the Docker build. No source code is stored in this repo.

> [!NOTE]
> LDMud 3.6+ enforces UTF-8 encoding for LPC source files. The master object must be pure 7-bit ASCII (use `\uXXXX` escapes for non-ASCII characters). Set the `H_FILE_ENCODING` hook to `"UTF-8"` in `inaugurate_master()` so all other files are loaded as UTF-8.

## Running standalone

```sh
docker run --rm -ti -p 5050:5050 \
  -v /path/to/your/mudlib:/mud/lib \
  ghcr.io/maldorne/ldmud:3.6.8-maldorne \
  /opt/mud/bin/ldmud -m /mud/lib -M secure/master.c 5050
```

## Other versions

The `master` branch only has the project overview.
