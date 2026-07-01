#!/bin/bash
set -euo pipefail

# --- System updates ---
dnf update -y

# --- Install Docker ---
dnf install -y docker
systemctl enable docker
systemctl start docker
usermod -aG docker ec2-user

# --- Create app directory ---
mkdir -p /opt/${project}
chown ec2-user:ec2-user /opt/${project}

# --- Write environment file ---
cat > /opt/${project}/.env <<EOF
ENVIRONMENT=${environment}
PROJECT=${project}
AWS_DEFAULT_REGION=${region}
S3_BUCKET=${s3_bucket}
EOF

# --- Write Dockerfile ---
cat > /opt/${project}/Dockerfile <<'DOCKERFILE'
FROM public.ecr.aws/amazonlinux/amazonlinux:2023-minimal

RUN dnf install -y aws-cli && dnf clean all

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
DOCKERFILE

# --- Write entrypoint script ---
cat > /opt/${project}/entrypoint.sh <<'SCRIPT'
#!/bin/bash
set -euo pipefail

echo "Hello World from $${ENVIRONMENT} - $(date -u +%Y-%m-%dT%H:%M:%SZ)" > /tmp/hello_world.txt

aws s3 cp /tmp/hello_world.txt "s3://$${S3_BUCKET}/hello_world.txt"

echo "Successfully uploaded hello_world.txt to s3://$${S3_BUCKET}/hello_world.txt"
SCRIPT

# --- Build and run ---
cd /opt/${project}
docker build -t ${project}-collector .
docker run --rm --network host --env-file .env ${project}-collector

echo "${project} (${environment}) hello_world container finished" | logger -t ${project}
