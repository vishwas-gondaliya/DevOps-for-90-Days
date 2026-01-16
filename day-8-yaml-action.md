# Day 8 – GitHub Actions YAML Fluency

## Objective

Build **true fluency** with GitHub Actions YAML by understanding **how it is executed**, not by memorizing syntax or copy-pasting templates.

The goal of Day 8 was:

* To understand GitHub Actions YAML as a **declarative execution model**
* To confidently write CI workflows from a blank file
* To explain **what each line does and why it exists**

No AWS, Docker, or new features were added on this day.

---

## Core Mental Model

GitHub Actions executes workflows in the following order:

```
Event → Workflow → Job → Runner → Step
```

* **Event**: What happens in GitHub (push, PR, etc.)
* **Workflow**: YAML file selected by the event
* **Job**: A unit of execution
* **Runner**: The VM where the job runs
* **Step**: Individual commands or actions

YAML does **not** describe logic. It describes **structure**.

---

## Reference CI Pipeline (Final)

Below is a **complete, minimal CI pipeline**, written intentionally to explain every concept clearly.

```yaml
name: CI

on:
  push:
    branches:
      - main
  pull_request:

jobs:
  ci:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Run tests
        run: ./test.sh

      - name: Build Docker image
        run: docker build -t cicd-demo-app .
```

---

## Line-by-Line Explanation

### `name: CI`

Defines the display name of the workflow in the GitHub Actions UI.

---

### `on:`

Defines **when the workflow should be created**.

```yaml
on:
  push:
    branches:
      - main
  pull_request:
```

* Runs on pushes to `main`
* Runs on all pull requests
* Triggers are **filters**, not logic
* Multiple triggers are evaluated as **OR**

---

### `jobs:`

Defines one or more jobs. Each job runs on its **own runner**.

```yaml
jobs:
  ci:
```

* `ci` is the job name
* Jobs run in parallel unless explicitly controlled

---

### `runs-on: ubuntu-latest`

```yaml
runs-on: ubuntu-latest
```

* Specifies the type of virtual machine
* GitHub provisions a **clean VM for every job**
* Nothing exists on the runner unless created or checked out

---

### `steps:`

Steps are executed **sequentially** inside a job.

They all share:

* The same filesystem
* The same workspace

---

### `uses: actions/checkout@v4`

```yaml
- uses: actions/checkout@v4
```

* Downloads the repository into the runner workspace
* Required for accessing repository files
* Without this step, the runner has an empty directory

`uses:` means running a **pre-packaged action** maintained by someone else.

---

### `run:`

```yaml
- run: ./test.sh
```

* Executes shell commands directly on the runner
* Exit codes control success or failure
* A non-zero exit code fails the step and job

`run:` is where **actual logic lives**.

---

## Key Distinctions Learned

### `uses` vs `run`

| `uses`                          | `run`                   |
| ------------------------------- | ----------------------- |
| Executes a reusable action      | Executes shell commands |
| Encapsulated logic              | Explicit logic          |
| Provided by community or GitHub | Written by you          |

---

### Triggers vs Conditions

* `on:` decides **if a workflow is created**
* `if:` decides **if a step runs inside a workflow**

Example conditional step:

```yaml
- run: echo "Main branch only"
  if: github.ref == 'refs/heads/main'
```

---

## Common Errors and Debugging

Most GitHub Actions failures come from:

* Incorrect indentation
* Misspelled keys (`runs-on`, `jobs`, `steps`)
* Forgetting `actions/checkout`
* Wrong branch filters

YAML is validated **before execution**, so many failures happen before any step runs.

---

## Key Learnings

* GitHub Actions YAML defines **structure, not behavior**
* Runners are always clean environments
* Steps share state; jobs do not
* Copy-paste is acceptable only when structure is understood

---

## One-Line Interview Explanation

> GitHub Actions YAML declaratively defines when workflows run, where jobs execute, and which steps are performed on clean runners.

---

## Final Outcome

After Day 8:

* CI/CD YAML no longer feels magical
* Workflows can be written from a blank file
* Errors are debugged logically, not emotionally

---

### Next Step

Day 9 will apply this fluency to **refactor and simplify the real project pipelines** without guesswork.
