#!/bin/bash
# ============================================================
#  DAY 8 DEVOPS — DATA PERSISTENCE & ISOLATION
#  Run each section in order. Commands are safe to re-run.
# ============================================================

# ── SECTION 1: BIND MOUNT (Local mongodata folder) ──────────
mkdir -p mongodata

docker run -d \
  --name my-db \
  -v "$(pwd)/mongodata:/data/db" \
  mongo:6.0

echo "[✓] MongoDB running with Bind Mount at ./mongodata"

# ── SECTION 2: CUSTOM NETWORK ───────────────────────────────
docker network create my-app-network

# Connect the already-running my-db container to the network
docker network connect my-app-network my-db

# Run nginx web container on the same network
docker run -d \
  --name my-web \
  --network my-app-network \
  nginx

echo "[✓] Custom network 'my-app-network' created"
echo "[✓] my-web can reach my-db via hostname 'my-db'"

# Verify DNS resolution between containers
docker exec my-web ping -c 2 my-db

# ── SECTION 3: DOCKER COMPOSE (Named Volume) ────────────────
# Bring up the full stack defined in docker-compose.yml
docker-compose up -d --build

echo "[✓] Stack started with Named Volume 'db-data'"

# ── SECTION 4: DISASTER TEST ────────────────────────────────
# Step 1 – Insert a test record into MongoDB
docker exec -it my-db mongosh appdb --eval \
  'db.test.insertOne({ message: "I survive disasters!", ts: new Date() })'

# Step 2 – Verify the record exists
docker exec my-db mongosh appdb --eval \
  'db.test.find().pretty()'

# Step 3 – THE DISASTER: destroy all containers
docker-compose down

echo "[✓] Containers destroyed — but Named Volume 'db-data' still exists"
docker volume ls | grep db-data

# Step 4 – THE RECOVERY: recreate containers
docker-compose up -d

# Step 5 – Check the record survived
docker exec my-db mongosh appdb --eval \
  'db.test.find().pretty()'

echo ""
echo "============================================================"
echo " If the record is still there — the volume did its job! ✅ "
echo "============================================================"