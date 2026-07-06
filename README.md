# DevOps Assessment

# DevOps Assessment - Terraform & Database Reliability

## Candidate

Name: Degala Pullaiah

---

# Project Overview

This project demonstrates Infrastructure as Code (IaC) using Terraform and database reliability practices using PostgreSQL and Docker.

The project includes:

- AWS Infrastructure using Terraform
- Modular Terraform design
- Separate Dev & Prod environments
- Docker Compose PostgreSQL
- Database schema
- Seed data
- Query optimization using indexes
- Database backup & restore scripts
- GitHub Actions for Terraform validation

---

# Architecture

Internet
↓
Application Load Balancer
↓
ECS Fargate
↓
PostgreSQL RDS (Private)

---

# Project Structure

devops-assessment/
│
├── database/
│   ├── 001_create_tables.sql
│   ├── 002_indexes.sql
│   └── 003_seed.sql
│
├── backups/
│
├── scripts/
│   ├── backup.sh
│   └── restore.sh
│
├── infra/
│   ├── modules/
│   │   ├── network/
│   │   ├── alb/
│   │   ├── ecs/
│   │   └── rds/
│   │
│   └── envs/
│       ├── dev/
│       └── prod/
│
├── docker-compose.yml
└── README.md

---

# Technologies Used

- Terraform
- AWS
- Docker
- Docker Compose
- PostgreSQL
- GitHub Actions
- Bash

---

# Local Database Setup

Start PostgreSQL

bash
docker compose up -d


Connect

bash
docker exec -it assessment_pg psql -U appuser -d appdb


---

# Verify Tables

sql
\dt

Expected

\hotel_bookings

booking_events
```

---

# Verify Seed Data

```sql
SELECT COUNT(*) FROM hotel_bookings;

SELECT COUNT(*) FROM booking_events;
```

---

# Backup Database

```bash
./scripts/backup.sh
```

Backups are stored inside

```
backups/
```

---

# Restore Database

```bash
./scripts/restore.sh backups/<backup_file.sql>
```

---

# Terraform

Development

```bash
cd infra/envs/dev

terraform init

terraform validate
```

Production

```bash
cd infra/envs/prod

terraform init

terraform validate
```

> Note:
> Terraform configuration has been validated using `terraform fmt`, `terraform init`, and `terraform validate`.


---

# Query Optimization

Created indexes on:

- city
- created_at
- org_id
- status

These indexes optimize:

```sql
SELECT
org_id,
status,
COUNT(*),
SUM(amount)
FROM hotel_bookings
WHERE city='delhi'
AND created_at>=NOW()-INTERVAL '30 days'
GROUP BY org_id,status;
```

---

# Dev vs Prod

| Property | Dev | Prod |
|-----------|------|------|
| DB Instance | db.t3.micro | db.t3.small |
| Backup | 3 Days | 7 Days |
| Deletion Protection | False | True |

---

# GitHub Actions

GitHub Actions automatically performs:

- terraform fmt
- terraform init
- terraform validate

---

Requires valid AWS credentials (`aws configure`) since `main.tf` targets the `aws` provider.

## 5. CI (Optional)

`.github/workflows/terraform.yml` runs `fmt`, `init`, `validate`, and `plan` on every push/PR to `main`. Add `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as GitHub repo secrets for the plan step to succeed.

## 6. Push to GitHub

```bash
git init
git add .
git commit -m "DevOps assessment: terraform, docker, backup/restore scripts"
git remote add origin https://github.com/<your-username>/devops-assessment.git
git branch -M main
git push -u origin main
```






# Author

Degala Pullaiah

DevOps Engineer