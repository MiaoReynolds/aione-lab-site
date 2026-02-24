#!/bin/bash
set -euo pipefail

cd "$(dirname "$0")"

if [ ! -d ".venv" ]; then
  echo "Error: .venv not found in project root."
  exit 1
fi

source .venv/bin/activate

HOST="127.0.0.1"
PORT="8000"
URL="http://${HOST}:${PORT}/"

echo "Starting MkDocs on ${URL}"
mkdocs serve -a "${HOST}:${PORT}" &
SERVER_PID=$!

sleep 2
open "${URL}" >/dev/null 2>&1 || true

echo "Local site is running. Press Ctrl+C to stop."

cleanup() {
  kill "${SERVER_PID}" >/dev/null 2>&1 || true
}

trap cleanup INT TERM
wait "${SERVER_PID}"
