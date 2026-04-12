# #### #### #### #### #### #### #### #### #### #### #### #### ####
#  build LDMud 3.6.8 on Debian 12 (bookworm)
# #### #### #### #### #### #### #### #### #### #### #### #### ####

FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/maldorne/ldmud"

# install build deps + runtime deps for mysql/sqlite/pcre support
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential bison autoconf automake pkg-config \
      libmariadb-dev-compat libmariadb-dev libsqlite3-dev libpcre3-dev \
      git openssh-client ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# create group and user, same uids as the mudos images for consistency
RUN groupadd -g 4200 mud \
 && useradd  -u 4201 -g 4200 -ms /bin/bash mud

# clone the specific tagged version from the official LDMud repo
WORKDIR /tmp
RUN git clone --branch 3.6.8 --depth 1 https://github.com/ldmud/ldmud.git ldmud-src

WORKDIR /tmp/ldmud-src/src

RUN ./autogen.sh

RUN ./configure \
      --prefix=/opt/mud \
      --bindir=/opt/mud/bin \
      --libexecdir=/opt/mud/libexec \
      --enable-use-mysql \
      --enable-use-sqlite

RUN make install-driver
RUN make install-utils || true

# verify binaries were produced
RUN ls -la /opt/mud/bin/

# clean up build artifacts
WORKDIR /opt/mud
RUN rm -rf /tmp/ldmud-src

USER mud

EXPOSE 5000/tcp
