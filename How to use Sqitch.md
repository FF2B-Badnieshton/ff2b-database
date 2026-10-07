# How to use Sqitch?

## What is Sqitch?

**Sqitch** is a database migration management tool used by **FF2B** to maintain and version control our database schema. Unlike other migration tools, Sqitch is non-denominational (it handles raw SQL directly) and guarantees safe deployments, reverts, and verification steps.

---

## 1. Prerequisites

Before using Sqitch, make sure you have:

- **PostgreSQL** installed and running locally.
- **Sqitch** installed on your system (very hard on windows).
- Access to a local database (e.g., `sqitch_test` or `FF2B_DB`).

---

## 2. Local Setup (One-time configuration)

To avoid pushing personal credentials or database credentials to GitHub, **never edit the project `sqitch.conf` file directly**.

Instead, configure your local connection URI in your system profile or run the command below once in your terminal:

```bash
sqitch config --user target.local.uri "db:pg://postgres:password@localhost:5432/sqitch_test"
```

> **Special Characters Note:** If your password contains special characters like `#`, replace them with URL-encoded values (e.g., `#` becomes `%23`).

### Verify your configuration

1. **Check the registered target URI:**

```bash
sqitch config target.local.uri
```

2. **Confirm target resolution:**

```bash
sqitch target show local
```

3. **Test the database connection:**

```bash
sqitch status
```

_(If successful, Sqitch will report `No changes deployed yet` or list current applied changes)._

---

## 3. Daily Workflow & Commands

### 3.1. Creating a new migration

To generate a new set of migration scripts, use `sqitch add`:

```bash
sqitch add <change_name> -m "Short description of the change"
```

**Example:**

```bash
sqitch add create_users_table -m "Add users table and role types"
```

This command automatically generates three SQL files in the repository:

- `deploy/<change_name>.sql`: The SQL script to apply the changes (`CREATE TABLE...`).
- `revert/<change_name>.sql`: The SQL script to rollback the changes (`DROP TABLE...`).
- `verify/<change_name>.sql`: The SQL script to verify the change was applied correctly (`SELECT...`).

---

### 3.2. Deploying migrations

To apply all pending migrations to your target database:

```bash
sqitch deploy
```

To deploy to a specific target (e.g., production):

```bash
sqitch deploy prod
```

---

### 3.3. Rolling back migrations

To undo the last applied migration:

```bash
sqitch revert
```

To roll back all migrations completely:

```bash
sqitch revert --to @ROOT
```

---

### 3.4. Checking status & history

To inspect which migrations are currently applied on the database:

```bash
sqitch status
```

---

## 4. Security & Best Practices

- **Transactions:** Always wrap your `deploy` and `revert` SQL scripts between `BEGIN;` and `COMMIT;`.
- **Idempotent verification:** Ensure `verify` scripts contain non-mutating SQL queries (e.g., `SELECT ... WHERE FALSE;`).
