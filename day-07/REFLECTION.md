# DAY 8 DEVOPS — REFLECTION & NOTES

## Experiment Reflection

### Q: "Check your database. Is the record still there? Why did the volume prevent the data from being deleted when the container was destroyed?"

**A:**  
Yes — the record **is still there** after `docker-compose down` and `docker-compose up -d`.

Here is why:

When `docker-compose down` runs, Docker **stops and removes the containers**, but it does **not remove named volumes** (unless you explicitly pass the `-v` flag, e.g. `docker-compose down -v`).

The named volume `db-data` is an independent object managed by Docker's storage subsystem, stored at a path like `/var/lib/docker/volumes/db-data/_data` on the host machine — completely **outside** the container's writable layer.

MongoDB inside the container writes all its data to `/data/db`, which is mounted from `db-data`. When the container is destroyed, the mount point disappears — but the underlying volume directory on the host is untouched.

When `docker-compose up -d` runs again, Docker creates a brand-new MongoDB container and re-attaches the **same** `db-data` volume to `/data/db`. MongoDB finds its existing data files exactly as it left them, and the previously inserted record is fully intact.

**In one sentence:** The container is disposable; the volume is permanent.

---

## Key Concepts Learned

| Concept | What it Does |
|---|---|
| **Bind Mount** (`-v $(pwd)/mongodata:/data/db`) | Maps a specific host folder to a container path. Great for development — you can open the folder directly. Data lives in your project directory. |
| **Named Volume** (`db-data:/data/db` in Compose) | Docker manages the storage location. Portable, production-safe, and survives `docker-compose down`. Recommended for databases. |
| **Custom Network** | Creates an isolated bridge network. Containers on the same network resolve each other by service name (DNS). Containers on different networks cannot talk to each other — security by default. |
| **`depends_on`** | Ensures `db` starts before `web` in Compose, preventing connection errors on startup. |

---

## Two Types of Storage — Quick Reference

```
Bind Mount                    Named Volume
─────────────────────────     ─────────────────────────
-v /host/path:/container/path  -v volume-name:/container/path
You choose where on host       Docker chooses location
Visible in your file explorer  Managed by Docker daemon
Best for: dev, config files    Best for: databases, prod data
```

---

## Completion Checklist

- [x] Successfully created a local Bind Mount using the `-v` flag  
- [x] Created a custom Docker network (`my-app-network`) and verified container-to-container DNS  
- [x] Implemented a Named Volume (`db-data`) in `docker-compose.yml`  
- [x] Proved data persists after `docker-compose down` and `docker-compose up -d`