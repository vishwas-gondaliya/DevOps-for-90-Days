# Day 1 – Linux & AWS Fundamentals Reboot

## Objective

Re-establish core **Linux and AWS fundamentals** through direct hands-on work.

The focus was to:

* Validate Linux command-line confidence
* Rebuild AWS EC2 muscle memory
* Identify real rust vs imagined weakness
* Produce tangible proof-of-work

---

## Linux Fundamentals Practiced

### Tasks Performed

* Created directories and files
* Managed file ownership and permissions
* Worked with processes and system resources
* Practiced text processing and disk analysis
* Wrote a basic bash script

### Key Commands Used

```bash
mkdir
rmdir
chmod
chown
ps
top
grep
awk
sed
tar
zip
df
du
```

---

## Bash Script Exercise

A bash script was created to:

* Accept a directory name as input
* Display disk usage of the directory
* Identify the largest file
* Count the total number of files

This validated comfort with:

* Command substitution
* Piping and filtering
* Script execution flow

---

## AWS Hands-On Exercise

### EC2 Setup

* Launched an Amazon Linux EC2 instance
* Configured Security Group rules
* Allowed SSH (22) and HTTP (80)
* Connected via SSH using key-based authentication

---

## Docker Installation on EC2

Docker was installed and verified on the EC2 instance.

Key actions:

* Installed Docker using package manager
* Started and enabled Docker service
* Verified Docker installation

---

## Running First Container (Nginx)

```bash
docker run -d -p 80:80 nginx
```

* Container ran successfully
* Application accessible via EC2 public IP
* Security Group configuration validated

---

## Key Observations

* Linux command knowledge was largely intact
* Minor command recall issues were resolved quickly
* AWS workflow was remembered without major blockers
* Docker commands required refresh but concepts were understood

---

## Real Learnings

* Googling syntax is not a weakness; not knowing what to Google is
* Rust comes from non-usage, not lack of capability
* Understanding system behavior matters more than memorization

---

## One-Line Explanation (Interview Ready)

> Linux and AWS fundamentals were validated by provisioning infrastructure, configuring access, and running containerized workloads end-to-end.

