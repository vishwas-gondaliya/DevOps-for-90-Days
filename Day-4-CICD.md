# Day 4 – CI/CD Tools Without Magic (GitHub Actions & Jenkins Mapping)

## Objective

Understand how **CI/CD tools implement the same pipeline logic** built manually on Day 3.

The goal was **not** to learn YAML or specific tools, but to:

* Remove fear around CI/CD tools
* See GitHub Actions and Jenkins as execution engines
* Understand where CI/CD logic actually lives

---

## Core Realization

> CI/CD tools do not add intelligence. They only provide machines, triggers, and visibility to execute steps engineers already understand.

---

## Pipeline Used (From Day 3)

The same pipeline was reused:

1. Trigger on code change
2. Run tests
3. Build artifact
4. Deploy artifact
5. Stop on any failure

This pipeline logic already existed in `ci.sh`.

---

## Mapping Bash CI to GitHub Actions

| Day 3 (Local Bash) | GitHub Actions        |
| ------------------ | --------------------- |
| Local machine      | GitHub runner         |
| ci.sh              | Job                   |
| Bash commands      | Steps                 |
| set -e             | Fail on non-zero exit |
| Manual execution   | Push trigger          |

GitHub Actions provides:

* Clean execution environments
* Automatic triggers (push / PR)
* Logs and run history

It does **not** change pipeline logic.

---

## GitHub Actions Workflow Used

```yaml
name: CI Pipeline

on:
  push:
    branches: [ "main" ]

jobs:
  ci:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Run tests
        run: ./test.sh

      - name: Build image
        run: docker build -t day3-app .

      - name: Deploy
        run: docker run --rm day3-app
```

Each step directly maps to commands previously executed locally.

---

## Breaking the Pipeline (Intentional Failures)

The pipeline was intentionally broken to observe behavior:

### Test Failure

* Modified application code to fail tests
* Pipeline stopped immediately

### Build Failure

* Introduced invalid Docker base image
* Tests passed, build failed
* Deploy stage did not execute

### Deploy Failure

* Broke container startup command
* Build succeeded, deploy failed

**Failures are surfaced, not prevented, by CI/CD tools.**

---

## Key Learnings from GitHub Actions

* YAML contains configuration, not logic
* CI/CD tools execute user-defined commands
* Exit codes control pipeline success or failure
* Debugging CI failures is slower but more visible than local

---

## Jenkins Mental Mapping

| GitHub Actions | Jenkins        |
| -------------- | -------------- |
| Runner         | Agent / Node   |
| Job            | Pipeline       |
| Step           | Step           |
| Workflow YAML  | Jenkinsfile    |
| Secrets        | Credentials    |
| Logs           | Console Output |

Same pipeline, different syntax.

---

## Jenkinsfile Equivalent (Conceptual)

```groovy
pipeline {
  agent any

  stages {
    stage('Test') {
      steps {
        sh './test.sh'
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t day3-app .'
      }
    }

    stage('Deploy') {
      steps {
        sh 'docker run --rm day3-app'
      }
    }
  }
}
```

This Jenkins pipeline executes the same logic as GitHub Actions and `ci.sh`.

---

## Why CI/CD Tools Exist

Even though CI/CD can be implemented with bash, tools provide:

* Automatic triggers
* Clean, repeatable environments
* Logs, history, and visibility
* Secrets management
* Team collaboration

They do **not** design or validate pipelines.

---

## Common Misconceptions (Avoid)

❌ CI/CD tools make applications correct
❌ YAML files contain business logic
❌ Jenkins or GitHub Actions are hard by nature

✅ Engineers design pipelines
✅ Tools execute pipelines
✅ Failures come from logic, not tools

---

## One-Line Interview Explanation

> CI/CD tools are automated execution platforms that run developer-defined build, test, and deployment steps in a controlled environment.



