#!/usr/bin/env bash
set -u

echo "===== DOCKER / CONTAINER HEALTH ====="

if ! command -v docker >/dev/null 2>&1; then
  echo "ERROR: docker command not found."
  exit 1
fi

echo
echo "===== DOCKER VERSION ====="
docker version --format 'Client={{.Client.Version}} Server={{.Server.Version}}' 2>/dev/null || docker version 2>/dev/null || true

echo
echo "===== ENGINE INFO ====="
docker info --format 'Containers={{.Containers}} Running={{.ContainersRunning}} Stopped={{.ContainersStopped}} Images={{.Images}}' 2>/dev/null || true

echo
echo "===== CONTAINERS ====="
docker ps -a --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}' 2>/dev/null || true

echo
echo "===== UNHEALTHY / RESTARTING ====="
docker ps -a --format '{{.Names}}|{{.Status}}' 2>/dev/null | grep -Ei 'unhealthy|restarting|exited' || echo "No unhealthy/restarting/exited containers detected."

echo
echo "===== DISK USAGE ====="
docker system df 2>/dev/null || true
