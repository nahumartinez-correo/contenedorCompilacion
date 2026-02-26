# mosaic-ci-container/Dockerfile
#
# Base recomendado: Debian "stable" (actualmente Debian 13 / trixie)
# Imagen slim para minimizar peso, con apt para instalar toolchain.
FROM debian:13-slim

ARG DEBIAN_FRONTEND=noninteractive

# Paquetes mínimos para: git clone/pull, ejecutar Perl, y utilidades típicas de build.
# (Agregar dependencias adicionales cuando se conozcan los requisitos exactos de compilación de Mosaic)
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      git \
      perl \
      ca-certificates \
      openssh-client \
      bash \
      curl \
      make \
      build-essential \
      file \
      rsync \
      dos2unix \
 && rm -rf /var/lib/apt/lists/*

# Usuario no-root para trabajar más cómodo (evita archivos root en el volumen montado)
ARG UID=1000
ARG GID=1000
RUN groupadd -g ${GID} builder \
 && useradd -m -u ${UID} -g ${GID} -s /bin/bash builder

WORKDIR /work

# Scripts auxiliares (sin automatizar de más; ayudan a clonar/actualizar sin ensuciar)
COPY --chown=builder:builder scripts/ /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

USER builder

# Por defecto abrimos shell interactiva
ENTRYPOINT ["/bin/bash"]
