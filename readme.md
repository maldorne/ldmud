<p align="center">
  <img width="200" alt="LDMud logo" src="/ldmud-logo.svg">
</p>

> [!IMPORTANT]  
> The `master` branch is empty, the code for different versions is located in other branches.

# LDMud driver — Docker images

Docker images for the [LDMud](https://github.com/ldmud/ldmud) driver, built on Debian 12 (Bookworm). Each branch includes the full LDMud source and compiles it during the Docker build.

## Branches

| Branch            | Notes                                            | Status              |
| ----------------- | ------------------------------------------------ | ------------------- |
| `3.6.8`           | Official LDMud 3.6.8, unmodified                 | Working with Docker |
| `3.6.8-maldorne`  | Fork of 3.6.8 with minor fixes and addons        | Working with Docker |

The `master` branch is empty, switch to any version branch to see its contents.

### Images on GHCR

If you want to test the images in your local machine, you can use them directly from the [Github Container Registry](https://github.com/maldorne/ldmud/pkgs/container/ldmud).

## Usage at Maldorne

| Version           | Used by                                        | Notes                                                           |
| ----------------- | ---------------------------------------------- | --------------------------------------------------------------- |
| `3.6.8`           | —                                              | Compiled and published, not used directly. Base for -maldorne.  |
| `3.6.8-maldorne`  | [Endor](https://maldorne.org/games/#endor-mud) | In production. PROXY protocol v1 support.                       |

## About our fork branches

Our `-maldorne` branches are **not** new versions of LDMud. They are minimal forks with only the additions strictly necessary to run pre-existing mudlibs behind reverse proxies in Docker, solely for preservation purposes. We publish the resulting Docker images for our own non-commercial use and for the benefit of the MUD community.

### Changes included in each fork branch

#### `3.6.8-maldorne` (based on `3.6.8`)

Maldorne additions:

| Change | Files | Description |
|--------|-------|-------------|
| PROXY protocol v1 | `src/comm.c`, `src/config.h.in`, `src/autoconf/configure.ac` | Reads a [PROXY protocol v1](https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt) header on new connections and uses the real client IP. Enabled via `--enable-use-proxy-protocol` at configure time. Backwards compatible. Supports IPv4 and IPv6. |
