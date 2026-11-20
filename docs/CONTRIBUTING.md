# How we work in this repo

1. **Never commit to `main` directly.** Create a branch, open a pull request.
2. **Branch names:** `feature/<short-description>`, `fix/<short-description>`, e.g. `feature/add-country-filter`. Include the ticket number if you have one: `feature/DWH-42-add-region-dim`.
3. **Commit messages:** short imperative sentence, say *what and why*.
   Good: `Add country filter to Top Customers sheet`  Bad: `changes`, `final_v3`
4. **Small pull requests** (one job, one workbook, one idea). Easier to review, easier to undo.
5. **Open a PR early**, ask for a review from a teammate, merge when approved.
6. **Releases:** after a production deployment, tag `main` as `vMAJOR.MINOR.PATCH` (e.g. `v1.0.0`).
   - MAJOR = breaking change (column renamed or dropped), MINOR = new table / dimension / dashboard, PATCH = bug fix.
   - Use `-rc1` for what is on TEST (`v1.1.0-rc1`); the final tag (`v1.1.0`) is what is on PROD.
   - Never move or reuse a published tag. Roll back by deploying the previous tag.

## What goes in Git
| Yes | No |
|-----|----|
| `.ktr`, `.kjb` (Pentaho) | `kettle.properties`, `repositories.xml` |
| `.twb` (Tableau workbook, plain XML) | `.twbx`, `.hyper`, `.tde` (packaged/extract = data) |
| `.sql`, docs, `*.example` config | passwords, tokens, keys, `.env` |

## Secrets
- Use variables: `${DWH_PASSWORD}`. Real values live in `~/.kettle/kettle.properties` on your machine.
- Before every commit run `git status` and `git diff --staged` and read what you are about to save.
- If a secret is ever committed: **change the password first**, then tell the team lead. Deleting the file later does NOT remove it from history.

## Undoing mistakes
- Not committed yet: `git restore <file>`.
- Committed but **not pushed**: `git reset --hard HEAD~1` (drops the commit) or `git commit --amend` (fixes it).
- Already **pushed or merged**: `git revert <commit-id>` (adds a new commit that undoes it). Never reset shared history.
- Merge conflict: edit the file, delete the `<<<<<<<` `=======` `>>>>>>>` markers, then `git add` and `git commit`. Stuck? `git merge --abort`.

## Pentaho & Tableau tips
- Only **one person edits a given `.ktr` / `.twb` at a time** (they are XML but not merge-friendly). Agree in chat or via a PR draft.
- Pull the latest `main` before you start work: `git pull`.
- Use Spoon's / Tableau's "Save" and commit right after; avoid mixing several unrelated changes in one commit.
