<p align="center">
  <img width="200" alt="LDMud logo" src="/ldmud-logo.svg">
</p>

> [!IMPORTANT]  
> The `master` branch is empty, the code for different versions is located in other branches.

# LDMud driver — Docker images

Docker images for the [LDMud](https://github.com/ldmud/ldmud) driver, built on Debian 12 (Bookworm). Each branch compiles a specific tagged version of LDMud from the [official repository](https://github.com/ldmud/ldmud) at build time.

## Branches

| Branch  | LDMud version           | Status              |
| ------- | ----------------------- | ------------------- |
| `3.6.8` | Latest stable (2025)    | Working with Docker |

The `master` branch is empty, switch to any version branch to see its contents.

### Images on GHCR

If you want to test the images in your local machine, you can use them directly from the [Github Container Registry](https://github.com/maldorne/ldmud/pkgs/container/ldmud).

## Usage at Maldorne

| Version | Used by                                        | Notes                                                                                                    |
| ------- | ---------------------------------------------- | -------------------------------------------------------------------------------------------------------- |
| `3.6.8` | [Endor](https://maldorne.org/games/#endor-mud) | Mudlib converted to UTF-8. Default file encoding patched from ASCII to UTF-8 so the master can compile. |
