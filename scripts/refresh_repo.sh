#!/usr/bin/env bash
set -euo pipefail

REPO_URL="${1:?Uso: refresh_repo.sh <repo_url> <branch> [target_dir]}"
BRANCH="${2:?Uso: refresh_repo.sh <repo_url> <branch> [target_dir]}"
TARGET_DIR="${3:-repo}"

echo "Repo URL   : $REPO_URL"
echo "Branch     : $BRANCH"
echo "Target dir : $TARGET_DIR"

if [ ! -d "$TARGET_DIR/.git" ]; then
  echo "Clonando..."
  git clone "$REPO_URL" "$TARGET_DIR"
fi

cd "$TARGET_DIR"

# Asegurar remotos y fetch
git remote -v
git fetch --all --prune

# Checkout rama (si no existe local, se crea siguiendo origin)
if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
  git checkout "$BRANCH"
else
  git checkout -b "$BRANCH" "origin/$BRANCH" || git checkout "$BRANCH"
fi

# DESCARTAR cambios locales SIEMPRE (requisito del usuario)
echo "Descartando cambios locales (reset/clean)..."
git reset --hard "origin/$BRANCH"
git clean -fdx

echo "Estado final:"
git status
git log -1 --oneline
