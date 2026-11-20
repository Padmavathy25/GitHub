# dwh-bi-demo

Practice repository for the **"Git & GitHub for the Data Warehouse team"** session.
It mimics a small DWH project with Pentaho and Tableau assets.

> The `.ktr`, `.kjb` and `.twb` files are **simplified demo files** shaped like the real thing.
> They are meant for practising Git (diffs, branches, PRs), not for opening in Pentaho/Tableau.

## Layout
```
pentaho/transformations/   Pentaho transformations (.ktr)
pentaho/jobs/              Pentaho jobs (.kjb)
pentaho/config/            kettle.properties.example  (template only!)
tableau/workbooks/         Tableau workbooks saved as .twb (plain XML)
sql/                       DDL / SQL scripts
sandbox/                   Practice area - one file per participant
scripts/                   Helper scripts (trainer demo)
docs/CONTRIBUTING.md       Team rules (read this!)
.github/                   PR template and CODEOWNERS
```

## Quick start
```bash
git clone https://github.com/<ORG>/dwh-bi-demo.git
cd dwh-bi-demo
```
Then follow the labs in the session guide.
