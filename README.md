# mosaic-ci-container

Contenedor base para **clonar** y **compilar** Mosaic dentro de un entorno Linux reproducible.

## Base elegida

- **Debian 13 (trixie) slim**: estable, apt simple, footprint bajo, y Perl/Git estándar.  
  Referencias:
  - Debian stable actual: Debian 13 / trixie.  
  - Docker Hub: tags `debian:13-slim` / `debian:trixie-slim`.

## Requisitos en la PC host

- Docker Engine + Docker Compose (plugin) instalados.

## Estructura

- `Dockerfile`: instala `git`, `perl` y utilidades típicas de build.
- `docker-compose.yml`: corre contenedor interactivo y monta `./work` como `/work`.
- `scripts/refresh_repo.sh`: clona o actualiza repo **descartando cambios locales** (reset/clean).
- `scripts/run_compile.sh`: wrapper mínimo para ejecutar `importa.pl`, `compila.pl` y `ddclr`.

## Uso (manual, sin automatizar CI todavía)

### 1) Construir imagen
```bash
cd mosaic-ci-container
docker compose build
```

### 2) Abrir shell dentro del contenedor
```bash
docker compose run --rm mosaic-builder
```

### 3) Clonar o actualizar repo descartando cambios locales
Dentro del contenedor:

```bash
refresh_repo.sh http://gitlab.correo.local/sucursales/mosaic-oa testAutomatizacion /work/mosaic-oa
```

- Si `/work/mosaic-oa` no existe: hace `git clone`.
- Si existe: hace `fetch`, `checkout`, `reset --hard`, `clean -fdx`, y deja la rama exactamente como `origin/<branch>`.

### 4) Ejecutar compilación (manual)
```bash
cd /work/mosaic-oa
run_compile.sh
```

> Nota: si `ddclr` no está en el PATH y vive en el repo, el script intenta `./ddclr` primero.

## Siguientes pasos (cuando validemos que compila)
- Definir dependencias reales del entorno Mosaic y agregarlas al Dockerfile.
- Definir salida “los 6 archivos base” y su ubicación.
- Luego recién pasar esto a un `.gitlab-ci.yml` con un runner Docker (sin requerir runner shell).
