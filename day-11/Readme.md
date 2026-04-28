# Day 11 – Artifact Management & Remote Registries

Extends the Day 10 CI pipeline to automatically **push versioned Docker images to Docker Hub**.

## What's New vs Day 10
| Feature | Day 10 | Day 11 |
|---|---|---|
| Run tests | ✅ | ✅ |
| Docker build | ✅ | ✅ |
| Push to Docker Hub | ❌ | ✅ |
| Dynamic version tag | ❌ | ✅ (v1, v2, v3…) |
| Rollback support | ❌ | ✅ |

## GitHub Secrets Required
| Secret Name | Value |
|---|---|
| `DOCKER_USERNAME` | Your Docker Hub username |
| `DOCKER_PASSWORD` | Your Docker Hub password or access token |

## Image Tags Produced Per Run
- `your-username/meetmux-app:latest`
- `your-username/meetmux-app:v15` ← unique per run, enables rollback

## Running Locally
```bash
pip install -r requirements.txt
pytest test_app.py -v
docker build -t meetmux-app .
docker run -p 5000:5000 meetmux-app
```