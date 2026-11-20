#!/usr/bin/env bash
# TRAINER ONLY (local demo, optional): creates two branches that edit the SAME line,
# so you can show a merge conflict live. Run inside your own clone, then:
#   git switch main && git merge demo/conflict-a && git merge demo/conflict-b
set -e
git switch main
git switch -c demo/conflict-a
sed -i 's/country        VARCHAR(100),/country        VARCHAR(100) NOT NULL,/' sql/create_dim_customer.sql
git commit -am "Make country mandatory"
git switch main
git switch -c demo/conflict-b
sed -i 's/country        VARCHAR(100),/country        VARCHAR(50),/' sql/create_dim_customer.sql
git commit -am "Shorten country column"
git switch main
echo "Ready. Now: git merge demo/conflict-a  then  git merge demo/conflict-b  (conflict!)"
