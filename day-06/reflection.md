# Day 6 DevOps Track — Reflection & Submission Notes

## Experiment Question
**"Why is it useful to have the database (Redis) defined in the same compose file as the web app instead of running it on a separate server manually?"**

### Answer

Defining Redis inside the same `docker-compose.yml` as the web app provides several key advantages:

**1. Automatic Service Discovery (Networking)**
Docker Compose creates a private internal network for all services defined in the same file. The Flask app can reach Redis simply by using `host='redis'` — Docker resolves this hostname automatically. If Redis ran on a separate manually-started server, you'd have to manage IP addresses, expose ports externally, and handle connectivity yourself.

**2. Dependency & Startup Order**
Using `depends_on: redis` in the compose file ensures Redis is always started *before* the web container. With manual separate servers, you'd have to manually start them in the right order every time — and there's no guarantee of that order being respected.

**3. Single Source of Truth**
One YAML file describes the *entire* application stack. Any developer (or CI/CD pipeline) can reproduce the exact environment with a single command: `docker-compose up`. No separate runbooks or memory required.

**4. Atomic Lifecycle Management**
`docker-compose down` tears down *everything* — web containers, Redis, and even the network — in one shot. No orphaned Redis processes left running in the background consuming memory.

**5. Scalability without Reconfiguration**
When we run `docker-compose up -d --scale web=3`, all three web replicas share the same Redis instance defined in the compose file. The shared state (hit counter) is consistent across all replicas because they all connect to the same internal `redis` service. If Redis were external and manually managed, you'd need to update connection strings in every replica.

**6. Portability**
The compose file can be committed to version control. The entire stack — web + database — travels together. Teams can spin it up on any machine with Docker installed.

---

## Completion Checklist
- [x] Created `docker-compose.yml` linking `web` and `redis` services
- [x] Created `app.py` with retry logic for Redis connection
- [x] Created `requirements.txt` (flask, redis)
- [x] Created `Dockerfile` to build the web image
- [x] `docker-compose up -d` starts the stack detached
- [x] Hit counter increments at `localhost:8000` on each refresh
- [x] `docker-compose ps` shows both containers running
- [x] `docker-compose logs -f web` shows request logs
- [x] `docker-compose down` cleanly removes containers and networks
- [x] Experimented with `--scale web=3` — 3 web replicas running simultaneously

---

## Pro Tip Observed
YAML indentation is critical — all nesting uses **2 spaces** (never tabs). The `ports` and `depends_on` keys under each service must be consistently indented or Docker Compose will throw a parse error.