#!/usr/bin/env bash
set -euo pipefail

# Ejecuta el pipeline mínimo que describiste.
# Ajustar paths si los scripts viven en otra ruta.
echo "Ejecutando importa.pl..."
perl ./importa.pl

echo "Ejecutando compila.pl..."
perl ./compila.pl

echo "Ejecutando ddclr..."
if command -v ddclr >/dev/null 2>&1; then
  ddclr
elif [ -x ./ddclr ]; then
  ./ddclr
else
  echo "ERROR: no se encontró 'ddclr' ni en PATH ni como ./ddclr"
  exit 1
fi

echo "Compilación/verificación finalizada (según exit codes)."
