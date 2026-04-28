# Day 4 Report — Infrastructure as Code (IaC)

## Technical Summary
Today I learned Infrastructure as Code (IaC) using two key tools:
- **Bash Shell Scripting** (`.sh` files) — to automate server setup tasks
- **YAML** (`.yaml` files) — to declare what infrastructure should look like

I wrote a `setup_server.sh` script that creates a folder structure for a web app,
and a `deployment.yaml` file that describes a cloud deployment with 3 replicas,
CPU/memory limits, and open ports.

I also created a GitHub Actions workflow (`.github/workflows/main.yml`) that 
automatically runs my script every time I push code to GitHub.

---

## The Bug Log
**Error I faced:** When I ran `bash setup_server.sh`, I got a "Permission denied" error.  
**Fix:** I checked if the file had execute permissions using `ls -l setup_server.sh`.  
The fix was: `chmod +x setup_server.sh` — this grants execute permission to the script.

---

## Conceptual Reflection

### .sh vs .yaml — What's the difference?
| | `.sh` (Shell Script) | `.yaml` (YAML Config) |
|---|---|---|
| **Type** | Action / Imperative | Declaration / Descriptive |
| **What it does** | Runs commands step-by-step | Describes *what* should exist |
| **Example** | "Run this, then do that" | "I want 3 servers with 256MB RAM" |
| **Used in** | Linux automation, CI/CD steps | Docker, Kubernetes, GitHub Actions |

### Why Code Over Manual Setup for 100 Servers?
Manual setup means clicking through dashboards 100 times — slow, error-prone,
and impossible to reproduce exactly. With IaC:
- ✅ One script provisions 100 servers identically
- ✅ Changes are version-controlled in Git
- ✅ Anyone on the team can read and understand the setup
- ✅ If a server breaks, you just re-run the script — no memory needed

This is the DevOps principle: **"If it's not in code, it doesn't exist."**

---

## Screenshot
[Add your terminal screenshot here after running `bash setup_server.sh`]