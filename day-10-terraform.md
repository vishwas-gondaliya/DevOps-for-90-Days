# Day 10 – Terraform Memory Refresh & Infrastructure Ownership

## Objective
Rebuild AWS infrastructure using Terraform to **replace manual console work**, refresh Terraform muscle memory, and deeply understand **state, drift, and ownership boundaries**.

This day was about **reclaiming Terraform**, not learning it from scratch.

---

## Scope of Terraform (Explicit)

Terraform was used to manage **infrastructure only**:

### Terraform Manages
- EC2 instance
- Security Group (SSH + HTTP)
- Key-based access
- Network-level configuration
- Infrastructure state

### Terraform Does NOT Manage
- Application code
- Docker images
- Containers running on EC2
- CI/CD workflows
- Application deployment logic

Terraform owns **infrastructure lifecycle**.  
CI/CD owns **application lifecycle**.

---

## Infrastructure Built with Terraform

The following resources were created using Terraform:

- **EC2 Instance**
  - Amazon Linux 2
  - `t2.micro`
  - SSH access via existing key pair
- **Security Group**
  - Inbound: SSH (22), HTTP (80)
  - Outbound: all traffic allowed

All infrastructure was verified via:
- AWS Console
- SSH access
- Terraform outputs

---

## Terraform Workflow Used

The standard Terraform lifecycle was followed:

```bash
terraform init
terraform plan
terraform apply
```

Key discipline:
- `terraform plan` was always reviewed before applying
- Changes were reasoned about, not blindly applied

---

## State Awareness & Drift Handling

Terraform state (`terraform.tfstate`) was treated as the **source of truth**.

### Drift Simulation
- A manual change was made in AWS Console (extra SG rule)
- `terraform plan` detected the drift
- Drift was resolved by updating Terraform code, not by clicking again in the console

**Key rule reinforced:**
> If a change should persist, it must exist in Terraform code.

---

## Credential Precedence Incident (Important Learning)

During the session, Terraform failed with AWS authentication errors due to **stale global environment variables**.

### Root Cause
- AWS credentials were previously set using `setx`
- Environment variables were silently overriding `~/.aws/credentials`
- Terraform correctly prioritized environment variables

### Resolution
- Removed global AWS environment variables
- Restarted system to clear persisted state
- Returned to profile-based credentials

### Key Lesson
> Environment variables override everything and are the most common hidden cause of AWS/Terraform auth issues.

---

## Safe Practices Reinforced

- Always check credential sources:
  ```bash
  aws configure list
  env | grep AWS
  ```
- Prefer AWS profiles over permanent environment variables
- Treat OS-level state as part of the system, not an afterthought

---

## Terraform vs CI/CD Boundary (Critical Clarity)

Terraform is **declarative and state-driven**.  
Application deployment is **procedural and frequent**.

Mixing them causes:
- State churn
- Risky applies
- Slow feedback loops

Therefore:
- Terraform provisions infrastructure
- CI/CD deploys applications onto that infrastructure

This boundary was intentionally preserved.

---

## Key Takeaways

- Terraform enforces desired state, it does not “create infra”
- `terraform plan` is a safety mechanism, not a formality
- Drift is expected and manageable
- Credentials and environment state matter as much as code
- Infrastructure should be reproducible and destroyable with confidence

---

## One-Line Interview Explanation

> I used Terraform to recreate and manage AWS infrastructure, handled drift explicitly, and established a clear boundary between infrastructure provisioning and application deployment.

---

## What Comes Next

Possible next steps:
- Introduce remote state for Terraform
- Add ECR and move to artifact-based deployment
- Integrate Terraform into CI/CD safely (plan-only first)

---

## Final Reflection

Day 10 shifted Terraform from a “tool I know” to a **system I trust and control**.
