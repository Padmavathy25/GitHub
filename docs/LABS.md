# Session code: all lab commands

Replace `<ORG>` with your GitHub org and `<user>` with **your GitHub username**.
Run everything in **Git Bash** (Windows) or Terminal (Mac/Linux).

## Setup check
```bash
git --version
git config --global user.name  "Your Name"
git config --global user.email "you@company.com"   # same e-mail as your GitHub account
```

## Lab 1: Clone and explore
```bash
git clone https://github.com/<ORG>/dwh-bi-demo.git
cd dwh-bi-demo
git status                       # On branch main, nothing to commit
git log --oneline                # 4 commits
git tag                          # v0.1.0
```

## Lab 2: Branch, commit, push
```bash
git checkout -b <user>-sandbox
cp pentaho/transformations/load_customers.ktr sandbox/<user>.ktr
# edit the <description> line in sandbox/<user>.ktr, save, then:
git status
git diff --no-index pentaho/transformations/load_customers.ktr sandbox/<user>.ktr
git add sandbox/<user>.ktr
git diff --staged
git commit -m "Add sandbox copy of load_customers"
git push -u origin <user>-sandbox
```

## Lab 3: Pull request (on GitHub)
1. Click **Compare & pull request**.
2. Fill the title and tick the checklist in the template.
3. Reviewer: **Files changed**, click the blue **+**, comment, **Review changes**, **Approve**.
4. **Merge pull request**, then **Delete branch**.

### Lab 3b: Merge from the command line (alternative to the GitHub button)
```bash
git switch main
git pull
git merge <branch>               # e.g. <user>-sandbox
git push
git branch -d <branch>

# if Git reports a conflict:
# open the file, keep the right lines, delete the <<<<<<< ======= >>>>>>> markers
git add <file>
git commit
git merge --abort                # changed your mind? back out
```

## Lab 4: Pull, tag, go back in time
```bash
git switch main
git pull
git log --oneline --graph --decorate -10
git branch -d <user>-sandbox

# trainer only: label the release
git tag -a v1.0.0 -m "Release after DWH Git session"
git push origin v1.0.0

# everyone
git fetch --tags
git tag
git switch --detach v0.1.0       # look at the old version
git switch main                  # back to today

# bonus: bring back one old file, then undo the experiment
git restore --source v0.1.0 -- pentaho/transformations/load_customers.ktr
git diff
git restore pentaho/transformations/load_customers.ktr
```

## Lab 5: Keep secrets out
```bash
# Part A: ignored files
echo "DWH_PASSWORD=Secret123" > kettle.properties
git status                       # kettle.properties is NOT listed
git check-ignore -v kettle.properties
rm kettle.properties

# Part B: read before you commit
# in sandbox/<user>.ktr replace <password>${DWH_PASSWORD}</password>
# with <password>MyRealPass1</password>
git add sandbox/<user>.ktr
git diff --staged                # read it: can you spot the password?

# undo before committing
git restore --staged --worktree sandbox/<user>.ktr
```

## Part 2 (bonus): conflicts, reset and revert
Local only, nothing is pushed. Start with a clean `git status`.

### Lab 6: Resolve a conflict
```bash
bash scripts/setup-conflict-demo.sh      # creates demo/conflict-a and demo/conflict-b
git merge demo/conflict-a                # works
git merge demo/conflict-b                # CONFLICT in sql/create_dim_customer.sql
git status                               # both modified

# open sql/create_dim_customer.sql:
#   <<<<<<< HEAD          your version
#   =======
#   >>>>>>> demo/conflict-b   incoming version
# keep the line you want (e.g. country VARCHAR(50) NOT NULL,) and delete the 3 marker lines

git add sql/create_dim_customer.sql
git commit -m "Resolve conflict in dim_customer"
git log --oneline --graph -5

git merge --abort                        # only if you want to cancel a merge mid-way
```

### Lab 7: Reset a commit (local, unpushed only)
```bash
git switch -c lab7-undo
echo "-- oops 1" >> sql/create_dim_customer.sql
git commit -am "Oops 1"
echo "-- oops 2" >> sql/create_dim_customer.sql
git commit -am "Oops 2"
git log --oneline -3
git reset --hard HEAD~1                  # drops "Oops 2" and its changes
git log --oneline -3

# the three flavors (HEAD~1 = one commit back)
git reset --soft  HEAD~1                 # changes stay staged
git reset --mixed HEAD~1                 # changes stay in files, unstaged (default)
git reset --hard  HEAD~1                 # changes are deleted
git reflog                               # safety net: where HEAD used to be
```

### Lab 7b: Revert a commit (safe for pushed/shared commits)
```bash
git revert HEAD --no-edit                # new commit that undoes the last one
git log --oneline -3
git revert <id>                          # revert an older commit by its id
git revert -m 1 <merge-id>               # revert a merge commit

# clean up Labs 6 and 7
git switch main
git reset --hard origin/main
git branch -D lab7-undo demo/conflict-a demo/conflict-b
git status
```

**Golden rule:** not pushed yet, reset is fine. Already pushed or shared, use revert.

## Rescue commands
```bash
git commit --amend -m "new message"          # fix last message (before pushing)
git restore --staged <file>                  # unstage a file
git restore <file>                           # throw away local edits to a file
git switch -c feature/xyz                    # committed on main by mistake? branch first,
git switch main && git reset --hard origin/main   # then reset main (only if not pushed)
```

## Sourcetree equivalents (GUI users)
| Command line | Sourcetree |
|---|---|
| `git clone <url>` | Clone / New, then Clone |
| `git checkout -b <branch>` | Branch button, tick *Checkout New Branch* |
| `git add <file>` | File Status: stage the file |
| `git commit -m "msg"` | Type a message, click Commit |
| `git push -u origin <branch>` | Push button, tick your branch |
| `git pull` | Pull button |
| `git merge <branch>` | Right-click the branch, *Merge into current branch* |
| `git tag -a v1.0.0` + `git push origin v1.0.0` | Right-click a commit, *Tag...*; then Push with *Push all tags* ticked |
| `git switch --detach v0.1.0` | Double-click the tag under Tags (double-click `main` to return) |
| `git restore <file>` | File Status, right-click the file, *Discard* |
| `git reset --soft/--mixed/--hard` | Right-click the commit *before* the one to drop, *Reset current branch to this commit* |
| `git revert <id>` | Right-click the commit, *Reverse commit...*, then Push |
| conflict: fix file, `git add`, `git commit` | Edit the file, right-click it, *Resolve Conflicts > Mark Resolved*, then Commit |
| `git merge --abort`, scripts | Terminal button |

Pull requests are made on github.com in the browser. Menu names can differ slightly between Windows, Mac and Sourcetree versions.
