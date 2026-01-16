# Day 7 – CI/CD Hardening & Professionalization

## Objective

Upgrade the CI/CD system built on Day 6 from **"it works"** to **"it is safe, controlled, and professional"**.

Day 7 focused on **hardening**, not adding new tools. The goal was to make the pipeline survivable under failure, predictable under change, and explainable in interviews.

---

## Starting Point (Day 6 State)

At the start of Day 7, the system had:

* A working CI/CD pipeline
* Single workflow handling both CI and CD
* Direct container replacement during deploy
* No version tracking
* No formal rollback process

This was acceptable for learning, but fragile for real usage.

---

## Key Improvements Made

### 1. Failure Awareness

A deliberate review of the pipeline identified real-world risks:

* EC2 restarts remove running containers
* Deploy failures after stopping the old container
* No visibility into which version is live
* SSH-based CD with broad permissions

These risks were **documented explicitly** instead of ignored.

---

### 2. CI and CD Separation

The pipeline was split into two independent workflows:

#### CI Workflow

* Runs on pull requests and pushes
* Executes tests
* Builds Docker image
* Does **not** deploy

#### CD Workflow

* Runs only on `main` branch
* Assumes CI has already passed
* Handles deployment only

This separation aligns with professional CI/CD standards and reduces accidental deployments.

---

### 3. Versioned Deployments

Deployments were upgraded from untagged images to **versioned Docker images** using commit SHA tags.

Benefits:

* Clear visibility of what version is deployed
* Easier debugging
* Enables rollback

The currently deployed version is recorded on the EC2 instance.

---

### 4. Health Checks

A basic health check was added during deployment to ensure:

* Container started successfully
* Application is responding
* Failed deployments stop the pipeline

This prevents silent failures and broken releases.

---

### 5. Rollback Strategy

A simple, explicit rollback procedure was defined:

* Identify last known good image tag
* Stop the current container
* Run the previous version

Rollback is manual but fast, predictable, and documented.

---

### 6. Security Tightening

Security practices reinforced:

* SSH keys stored only in GitHub Secrets
* No secrets committed to repository
* CD restricted to main branch only
* No secrets echoed in logs

This reduces blast radius and accidental exposure.

---

## Final State (After Day 7)

After Day 7, the system now has:

* Clean CI/CD separation
* Versioned and traceable deployments
* Health-checked releases
* Documented rollback process
* Clear understanding of risks and limitations

The pipeline is no longer a demo — it is **operationally defensible**.

---

## One-Line Interview Explanation

> I hardened a CI/CD pipeline by separating CI and CD, introducing versioned deployments, adding health checks, and defining a clear rollback strategy for AWS EC2 deployments.

---

## Key Takeaway

Day 7 proved that **professional DevOps work is about control and failure handling**, not just automation.

---

### Next Step

Day 8 will focus on **GitHub Actions YAML fluency** — understanding the syntax layer deeply so pipelines can be written confidently without copy-paste reliance.
