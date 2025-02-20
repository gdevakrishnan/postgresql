# PostgreSQL Cheat Sheet  

## 1️⃣ Database Management  

### 🔹 List All Databases  
```sql
\l    -- List all databases
```
```sql
SELECT datname FROM pg_database;
```

### 🔹 Create a Database  
```sql
CREATE DATABASE my_database;
```

### 🔹 Delete a Database  
```sql
DROP DATABASE my_database;
```

### 🔹 Switch to a Database  
```sql
\c my_database
```

### 🔹 Show Current Database  
```sql
SELECT current_database();
```

---

## 2️⃣ User Management (Roles & Privileges)  

### 🔹 List Users  
```sql
\du
```
```sql
SELECT * FROM pg_user;
```

### 🔹 Create a New User  
```sql
CREATE USER new_user WITH PASSWORD 'password';
```

### 🔹 Grant User Permissions  
```sql
GRANT ALL PRIVILEGES ON DATABASE my_database TO new_user;
GRANT SELECT, INSERT ON users TO new_user;
```

### 🔹 Revoke Permissions  
```sql
REVOKE ALL PRIVILEGES ON DATABASE my_database FROM new_user;
```

### 🔹 Change User Password  
```sql
ALTER USER new_user WITH PASSWORD 'newpassword';
```

### 🔹 Delete a User  
```sql
DROP USER new_user;
```

---

## 3️⃣ Table Management  

### 🔹 List All Tables  
```sql
\dt   -- List tables in current database
```
```sql
SELECT table_name FROM information_schema.tables WHERE table_schema='public';
```

### 🔹 Create a Table  
```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INTEGER CHECK (age > 0)
);
```

### 🔹 Delete a Table  
```sql
DROP TABLE users;
```

### 🔹 Truncate Table (Delete All Data)  
```sql
TRUNCATE TABLE users RESTART IDENTITY;
```

### 🔹 Alter a Table  
```sql
ALTER TABLE users ADD COLUMN phone VARCHAR(15);
ALTER TABLE users DROP COLUMN phone;
ALTER TABLE users RENAME COLUMN email TO user_email;
```

---

## 4️⃣ CRUD Operations (Insert, Select, Update, Delete)  

### 🔹 Insert Data  
```sql
INSERT INTO users (name, email, age) VALUES ('Alice', 'alice@example.com', 25);
```

### 🔹 Select Data  
```sql
SELECT * FROM users;
SELECT name, email FROM users WHERE age > 18;
SELECT COUNT(*) FROM users;
```

### 🔹 Update Data  
```sql
UPDATE users SET name = 'Alice Smith' WHERE id = 1;
```

### 🔹 Delete Data  
```sql
DELETE FROM users WHERE id = 1;
```

---

## 5️⃣ Joins in PostgreSQL  

### 🔹 INNER JOIN  
```sql
SELECT users.name, orders.amount 
FROM users 
INNER JOIN orders ON users.id = orders.user_id;
```

### 🔹 LEFT JOIN  
```sql
SELECT users.name, orders.amount 
FROM users 
LEFT JOIN orders ON users.id = orders.user_id;
```

### 🔹 RIGHT JOIN  
```sql
SELECT users.name, orders.amount 
FROM users 
RIGHT JOIN orders ON users.id = orders.user_id;
```

### 🔹 FULL OUTER JOIN  
```sql
SELECT users.name, orders.amount 
FROM users 
FULL OUTER JOIN orders ON users.id = orders.user_id;
```

---

## 6️⃣ Indexing & Optimization  

### 🔹 Create an Index  
```sql
CREATE INDEX idx_users_email ON users(email);
```

### 🔹 Remove an Index  
```sql
DROP INDEX idx_users_email;
```

### 🔹 Check Query Performance  
```sql
EXPLAIN ANALYZE SELECT * FROM users WHERE email = 'alice@example.com';
```

---

## 7️⃣ Transactions  

### 🔹 Begin, Commit, and Rollback Transactions  
```sql
BEGIN;
UPDATE users SET age = 30 WHERE id = 1;
COMMIT;  -- Save changes
```
```sql
BEGIN;
DELETE FROM users WHERE id = 1;
ROLLBACK;  -- Undo changes
```

---

## 8️⃣ Views & Materialized Views  

### 🔹 Create a View  
```sql
CREATE VIEW user_emails AS SELECT name, email FROM users;
```

### 🔹 Drop a View  
```sql
DROP VIEW user_emails;
```

### 🔹 Create a Materialized View  
```sql
CREATE MATERIALIZED VIEW user_summary AS
SELECT name, COUNT(*) FROM users GROUP BY name;
```

### 🔹 Refresh Materialized View  
```sql
REFRESH MATERIALIZED VIEW user_summary;
```

---

## 9️⃣ JSON & JSONB Handling  

### 🔹 Create a Table with JSON Column  
```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    data JSONB
);
```

### 🔹 Insert JSON Data  
```sql
INSERT INTO products (data) VALUES ('{"name": "Laptop", "price": 1200}');
```

### 🔹 Query JSON Data  
```sql
SELECT data->'name' FROM products;  -- Extracts JSON value
SELECT data->>'name' FROM products; -- Extracts JSON text
```

---

## 🔟 Backup & Restore  

### 🔹 Backup a Database  
```bash
pg_dump -U postgres -W -F c -b -v -f "backup_file.dump" my_database
```

### 🔹 Restore a Database  
```bash
pg_restore -U postgres -W -d my_database "backup_file.dump"
```

---

## 1️⃣1️⃣ PostgreSQL System Information  

### 🔹 Show Current User  
```sql
SELECT current_user;
```

### 🔹 Show Database Size  
```sql
SELECT pg_size_pretty(pg_database_size('my_database'));
```

### 🔹 Show Table Size  
```sql
SELECT pg_size_pretty(pg_total_relation_size('users'));
```

---

This cheat sheet provides a quick reference for essential PostgreSQL commands. 🚀

---

## Contributors
[Devakrishnan Gopal](https://www.github.com/gdevakrishnan)

## Contributing

Contributions are welcome! Feel free to open issues or pull requests for any improvements, features, or bug fixes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
