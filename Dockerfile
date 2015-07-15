FROM justincormack/rumprunxen

# temp
RUN apt-get install -y cmake

MAINTAINER Justin Cormack <justin@specialbusservice.com>

WORKDIR /usr/src/rumprun-packages

RUN \
  cd /usr/src && \
  git clone https://github.com/rumpkernel/rumprun-packages.git && \
  cd rumprun-packages && \
  echo "RUMPRUN_TOOLCHAIN_TUPLE=x86_64-rumprun-netbsd" > config.mk && \
  make world

RUN \
  for f in */bin/*; do rumpbake xen_pv $f $f; done
