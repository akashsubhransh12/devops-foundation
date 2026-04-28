# Day 12 – Infrastructure as Code (IaC) with Terraform

Demonstrates the core Terraform workflow: Write → Plan → Apply using the local provider.

## Files
| File | Purpose |
|---|---|
| `main.tf` | Core infrastructure definition |
| `variables.tf` | Configurable input variables |
| `outputs.tf` | Values printed after apply |
| `main_updated.tf` | Use for the experiment (replace main.tf content) |
| `.gitignore` | Excludes state files and secrets from Git |

## Step-by-Step Commands

### 1. Install Terraform
Download from: https://developer.hashicorp.com/terraform/install
Verify: `terraform -version`

### 2. Initialize
```bash
terraform init
```
Downloads the hashicorp/local provider plugin.

### 3. Plan
```bash
terraform plan
```
Shows: "Plan: 1 to add, 0 to change, 0 to destroy."

### 4. Apply
```bash
terraform apply
```
Type `yes` when prompted. Creates `day12_check.txt`.

### 5. Experiment — Modify & Re-apply
Replace the content in main.tf with the content from main_updated.tf, then:
```bash
terraform apply
```
Terraform detects the change and updates only what changed.

### 6. Observe Idempotency
```bash
terraform apply
```
Run again with no changes — Terraform does nothing.
"No changes. Infrastructure is up-to-date."

## Key Files Terraform Creates
- `terraform.tfstate` — Terraform's memory. NEVER delete this.
- `.terraform/` — Downloaded provider plugins.
- `day12_check.txt` — The resource Terraform manages.