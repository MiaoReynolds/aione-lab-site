#!/bin/bash

cd "$(dirname "$0")"

source .venv/bin/activate

git add .
git commit -m "update"
git push origin main

mkdocs gh-deploy --clean

echo "Deployment complete."
