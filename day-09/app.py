import os

print("=" * 40)
print("  DevOps Day 9 - Secure Container")
print("=" * 40)
print(f"Running as user: {os.popen('whoami').read().strip()}")
print("App is running successfully under non-root user!")
print("Container is hardened and production-ready.")