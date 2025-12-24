# Day 3 – CI/CD from First Principles (Without Tools)

## Objective

Understand CI/CD by **building it manually** instead of relying on tools like Jenkins or GitHub Actions.

The goal was to learn:

* What CI and CD actually are
* How pipelines work internally
* Why CI/CD tools are execution engines, not magic systems

---

## What CI/CD Means

### Continuous Integration (CI)

CI ensures that **every code change** is automatically:

* Validated
* Tested
* Built

Only verified code is allowed to progress further.

### Continuous Delivery / Deployment (CD)

CD takes the **verified artifact** produced by CI and:

* Delivers it to the next environment (staging / production)
* Either with manual approval (Delivery) or automatically (Deployment)

**CI builds trust. CD moves trust forward.**

---

## CI/CD Pipeline Implemented Today

The pipeline implemented locally:

1. Code change
2. Test validation
3. Build artifact
4. Deploy artifact
5. Stop pipeline on any failure

This pipeline was created using:

* Bash scripts
* Exit codes
* Docker

---

## Project Structure

```
day3-cicd/
├── app.py
├── test.sh
├── Dockerfile
└── ci.sh
```

---

## CI Step – Test Validation

### test.sh

```bash
#!/bin/bash
grep -q "print(" app.py
```

* Returns `0` if test passes
* Returns non-zero if test fails
* CI relies on exit codes, not intelligence

---

## Build Step – Artifact Creation

### Dockerfile

```Dockerfile
FROM python:3.9-slim
COPY app.py /app.py
CMD ["python","/app.py"]
```

This builds a **runnable artifact** that can be deployed consistently.

---

## CD Step – Deployment

```bash
docker run --rm day3-app
```

* Deployment here means **running the verified artifact**
* CD does not imply production only; it means moving code forward safely

---

## Pipeline Orchestration

### ci.sh

```bash
#!/bin/bash
set -e

echo "Running tests"
./test.sh

echo "Building image"
docker build -t day3-app .

echo "Deploying"
docker run --rm day3-app

echo "Pipeline succeeded"
```

* `set -e` ensures the pipeline stops on first failure
* Each stage depends on the previous one succeeding

---

## Failure Scenarios Tested

* Test failure → pipeline stops
* Build failure → deployment never runs
* Deploy failure → CI/CD reports failure

**CI/CD only enforces rules that engineers explicitly define.**

---

## Key Learnings

* CI/CD is a **system**, not a tool
* CI/CD tools only execute developer-defined steps
* Green pipelines do not guarantee correct software
* Exit codes are the backbone of CI/CD failure handling

---

## Why CI/CD Tools Exist

Even though this pipeline can be built with bash, tools provide:

* Automated triggers (push, PR)
* Clean execution environments
* Logs, history, and visibility
* Secrets and access management

They do **not** decide correctness or fix logic errors.

---

## One-Line Explanation (Interview Ready)

> CI/CD is an automated system that validates, builds, and delivers software by enforcing rules defined by engineers.


