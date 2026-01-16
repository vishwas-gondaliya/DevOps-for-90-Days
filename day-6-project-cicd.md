# Day 6 – CI/CD to AWS (End-to-End Implementation)

## Objective

Build a **real, end-to-end CI/CD pipeline** that deploys an application to AWS, using:

* GitHub Actions for CI/CD
* Docker for packaging
* AWS EC2 as the deployment target

This day focused on **implementation**, not theory.

---

## What Was Built

By the end of Day 6, the following were implemented:

* A minimal HTTP application
* Dockerized application image
* AWS EC2 instance running Docker
* Manual deployment to EC2 (baseline)
* CI pipeline using GitHub Actions
* CD pipeline deploying to EC2 via SSH

This establishes a complete **code → CI → CD → AWS** flow.

---

## Project Structure

```
ci-cd-to-aws-from-scratch/
├── app/
│   └── app.py
├── Dockerfile
├── test.sh
├── .github/
│   └── workflows/
│       └── ci.yml
└── README.md
```

---

## Application

### app/app.py

A minimal HTTP server used only to validate CI/CD and deployment.

* Listens on port `8080`
* Returns a static response to confirm deployment success

The application logic is intentionally simple to keep focus on DevOps workflows.

---

## Dockerization

### Dockerfile

```Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY app/app.py .
EXPOSE 8080
CMD ["python", "app.py"]
```

Docker responsibilities:

* Package the application
* Provide a consistent runtime
* Act as the deployable artifact

---

## AWS Deployment Target

### EC2 Configuration

* AMI: Amazon Linux 2
* Instance type: t2.micro
* Security Group:

  * SSH (22) – restricted
  * HTTP (80) – public

Docker was installed and used to run the application container.

---

## Manual Deployment (Baseline)

Before automating deployment, the application was deployed **manually** to EC2:

* Clone repository on EC2
* Build Docker image
* Run container exposing port 80

This step defined the **deployment contract** and removed ambiguity before CD automation.

---

## CI Pipeline (GitHub Actions)

### Responsibilities

* Trigger on push to `main`
* Run basic tests
* Build Docker image

### Test Script

```bash
#!/bin/bash
grep -q "CI/CD to AWS is working" app/app.py
```

Tests rely on exit codes to control pipeline flow.

---

## CD Pipeline (GitHub Actions)

### Deployment Strategy

* SSH-based deployment to EC2
* Secrets managed via GitHub Actions secrets
* Explicit stop → remove → build → run flow

### Secrets Used

* `EC2_SSH_KEY`
* `EC2_HOST`
* `EC2_USER`

No secrets are committed to the repository.

---

## Key Learnings

* CI/CD tools execute the same commands used locally
* Manual deployment first simplifies CD automation
* SSH-based CD is explicit and easy to debug
* Most failures occur due to permissions or access, not code

---

## Common Issues Encountered

* Docker image not available on EC2
* SSH permission issues
* Port exposure mismatches

Each issue was resolved by validating assumptions step by step.

---
