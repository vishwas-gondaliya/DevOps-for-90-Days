# Day 2 – Docker Fundamentals (Hands‑On)

## Objective

Rebuild Docker fundamentals through **hands-on practice**, not tutorials.

The focus was to:

* Remove fear around Docker commands
* Understand images vs containers
* Build and debug containers manually
* Learn how Docker behaves when things silently break

---

## What Docker Actually Is

Docker is a **process isolation and packaging system** that allows applications to run with their dependencies in a consistent environment using OS‑level isolation.

Docker is **not** a VM and does not manage application correctness.

---

## Core Concepts Covered

### Images vs Containers

* **Image**: Immutable blueprint (built using Dockerfile)
* **Container**: Running instance of an image

A container exists **only as long as its main process runs**.

---

## Docker Commands Practiced

```bash
docker ps
docker ps -a
docker images
docker run
docker stop
docker rm
docker rmi
docker logs
docker inspect
docker exec -it <container> sh
```

Cleanup commands:

```bash
docker rm $(docker ps -aq)
docker rmi $(docker images -q)
```

---

## Running a Container (Nginx Example)

```bash
docker run -d --name web1 -p 8080:80 nginx
```

* Host port `8080` mapped to container port `80`
* Verified access via browser using EC2 public IP

---

## Dockerfile – Custom Image

### Application (app.py)

```python
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"Hello from custom Docker image")

HTTPServer(("", 8080), Handler).serve_forever()
```

### Dockerfile

```Dockerfile
FROM python:3.9-slim
WORKDIR /app
COPY app.py .
EXPOSE 8080
CMD ["python","app.py"]
```

Build and run:

```bash
docker build -t custom-python-app .
docker run -d -p 8080:8080 custom-python-app
```

---

## Debugging Silent Failures (Important)

### Issue Faced

* Container running
* No errors in logs
* Application not reachable in browser

### Root Cause

* Application listening port did not match container port mapping

Docker does **not validate intent**. If ports don’t match, traffic is silently dropped.

---

## Key Debugging Techniques Used

```bash
docker ps
docker inspect <container>
docker logs <container>
docker exec -it <container> sh
ss -tuln
```

Debugging order:

1. Check host → container port mapping
2. Check listening ports inside container
3. Verify application binding (`0.0.0.0` vs `localhost`)

---

## EXPOSE vs Port Mapping

* `EXPOSE` is **documentation only**
* It does not publish ports
* Actual traffic forwarding happens only via `-p` or orchestration tools

**EXPOSE declares intent. `-p` enforces reality.**

---

## Common Failure Scenarios Practiced

* Wrong port mapping
* Application binding to localhost
* Container exiting immediately
* Silent failures with no logs

These failures were intentionally created and debugged.

---

## Key Learnings

* Docker will happily run broken configurations
* No logs does not mean no problem
* Containers fail silently when networking is misconfigured
* Debugging requires checking assumptions, not guessing

---

## One‑Line Explanation (Interview Ready)

> Docker packages applications with their dependencies and runs them as isolated processes using the host OS kernel.
