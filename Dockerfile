# #### #### #### #### #### #### #### #### #### #### #### #### ####
#  build LDMud 3.6.8 on Debian 12 (bookworm)
# #### #### #### #### #### #### #### #### #### #### #### #### ####

FROM debian:bookworm-slim

LABEL org.opencontainers.image.source="https://github.com/maldorne/ldmud"

# install build deps + runtime deps for mysql/sqlite/pcre support.
# git+ssh are also added so the resulting image can later be reused
# as a base for runner images that clone game code at startup.
RUN apt-get update && apt-get install -y --no-install-recommends \
      build-essential bison autoconf automake pkg-config \
      libmariadb-dev-compat libmariadb-dev libsqlite3-dev libpcre3-dev \
      git openssh-client ca-certificates \
 && rm -rf /var/lib/apt/lists/*

# create group and user (same uids used across all maldorne driver images)
RUN groupadd -g 4200 mud \
 && useradd  -u 4201 -g 4200 -ms /bin/bash mud
USER mud

WORKDIR /opt/mud
COPY --chown=mud:mud src      /opt/mud/src/
COPY --chown=mud:mud autoconf /opt/mud/autoconf/
COPY --chown=mud:mud mudlib   /opt/mud/mudlib/
COPY --chown=mud:mud doc      /opt/mud/doc/

WORKDIR /opt/mud/src

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

EXPOSE 5000/tcp
