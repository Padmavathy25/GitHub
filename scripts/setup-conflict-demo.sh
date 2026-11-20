#!/usr/bin/env bash
# Lab 6 helper (everyone, local only): creates two branches that edit the SAME line
# of sql/create_dim_customer.sql so you can practise resolving a merge conflict.
# Run it inside your clone, with a clean working tree (git status = nothing to commit).
set -e
git switch main
# remove leftovers from an earlier run
git branch -D demo/conflict-a demo/conflict-b >/dev/null 2>&1 || true

git switch -c demo/conflict-a
sed -i.bak 's/VARCHAR(100),/VARCHAR(100) NOT NULL,/' sql/create_dim_customer.sql && rm -f sql/create_dim_customer.sql.bak
git commit -am "Make country mandatory"

git switch main
git switch -c demo/conflict-b
sed -i.bak 's/VARCHAR(100),/VARCHAR(50),/' sql/create_dim_customer.sql && rm -f sql/create_dim_customer.sql.bak
git commit -am "Shorten country column"

git switch main
echo ""
echo "Ready. Now run:"
echo "  git merge demo/conflict-a     (works)"
echo "  git merge demo/conflict-b     (CONFLICT - your turn to resolve it)"
