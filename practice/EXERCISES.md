# Practice worksheet: which file to touch in which lab

All files are **demo files shaped like the real thing**. They are meant for practising Git (diffs, branches, reviews), not for running a load. Replace `<user>` with your GitHub username.

## What is in the repo

| Folder / file | What it is | Used in |
|---|---|---|
| `pentaho/transformations/load_customers.ktr` | Table input -> Insert/Update (`dwh.dim_customer`) | Labs 1, 2, 3, 5 |
| `pentaho/transformations/load_regions.ktr` | CSV input -> Select values -> Table output (`dwh.dim_region`) | Lab 1 (explore) |
| `pentaho/jobs/nightly_load.kjb` | Job: START -> load customers -> Success | Lab 1 (explore) |
| `tableau/workbooks/sales_dashboard.twb` | Workbook (plain XML) with 2 sheets and 1 dashboard | Lab 1 (explore), exercise D |
| `sql/create_dim_customer.sql` | DDL for `dim_customer` | Labs 6 and 7 |
| `sql/create_dim_region.sql`, `create_fact_orders.sql`, `sales_by_region.sql` | More DDL and an example report query | Lab 1 (explore) |
| `practice/sample_data/*.csv` | Fake source data: `customers`, `regions`, `orders` | Lab 1 (explore) |
| `practice/review_me/load_orders.ktr` | A transformation **with deliberate problems** | Lab 3, Lab 5 |
| `pentaho/config/kettle.properties.example` | Template for your real `kettle.properties` (never committed) | Lab 5 |
| `sandbox/` | Your own practice area, one file per person | Lab 2 |

---

## Lab 1: explore (5 min)
1. Open `pentaho/transformations/load_customers.ktr` in an editor. Find: the connection block (`${DWH_HOST}`...), the three steps, the hops.
2. Open `pentaho/transformations/load_regions.ktr` and `practice/sample_data/regions.csv`. Which step reads the CSV? Which table does it end up in?
3. `git log --oneline -- pentaho/` : who touched the Pentaho files?

## Lab 2: your first change
**File:** copy `pentaho/transformations/load_customers.ktr` to `sandbox/<user>.ktr`.
1. Change the `<description>` line to end with `(edited by <user>)`.
2. *Optional second change:* set `<commit>1000</commit>` to `<commit>500</commit>`.
3. `git diff --no-index pentaho/transformations/load_customers.ktr sandbox/<user>.ktr`
   **You should see** one changed line per edit (two if you did the optional change).

## Lab 3: review someone else's pull request
**Reviewer checklist** (tick each one in the pull request):
- [ ] Only the lines the author said they changed are different
- [ ] No password, token or real server name
- [ ] Connection values still use variables such as `${DWH_HOST}`
- [ ] File paths are not on someone's personal machine
- [ ] The commit message says what and why

**Group exercise (5 min): "Find the problems".** Pretend `practice/review_me/load_orders.ktr` arrived in a pull request. Open it and write down every problem you find. Your trainer will go through the answer key afterwards.

## Lab 5: secrets
1. Part A: create a local `kettle.properties` and check `git status` does not list it.
2. Part B: in your `sandbox/<user>.ktr` replace `<password>${DWH_PASSWORD}</password>` with `<password>MyRealPass1</password>`, run `git add` and `git diff --staged`, spot the password, then undo with `git restore --staged --worktree sandbox/<user>.ktr`.
3. Compare with `practice/review_me/load_orders.ktr`: this is what a leaked password looks like in a real file.

## Labs 6 and 7: conflicts, reset, revert
**File:** `sql/create_dim_customer.sql` (the conflict script and the "oops" commits edit it).
Nothing to prepare: follow the lab commands. Clean up at the end of Lab 7b.

## Exercise D (optional, Tableau)
**File:** `tableau/workbooks/sales_dashboard.twb` on your own branch.
1. Rename the dashboard `Sales Overview` to `Sales Overview v2`.
2. `git diff`: how many lines changed?
3. Commit, push, open a pull request. This is why we save Tableau work as `.twb` (small readable diff) and not `.twbx` (zipped binary).
