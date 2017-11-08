# Useful MySQL/MariaDB queries

## CLI

- Log in as root: `mysql -uroot -p` (password is prompted)

## Queries

First log in as root and use the `mysql` database: `mysql -uroot -p mysql` (password is prompted). Don't forget that every query must be terminated with `;`

In the overview below, CAPITALIZED words are part of the SQL syntax, lowercase words are names of tables, columns, etc.

| Task | Query |
| :--- | :--- |
| List databases | `SHOW DATABASES` |
| Change active database | `USE dbname` |
| Change to the "system" database | `USE mysql` |
| Show tables in active database | `SHOW TABLES` |
| Show table properties | `DESCRIBE TABLES` |
| Quit | `exit` or `Ctrl-D` |

The following queries are to be performed in the `mysql` database.

| Task | Query |
| :--- | :--- |
| List all users | `SELECT user,host,password FROM user` |


## "Longer" queries

Perform the tasks of `mysql_secure_installation`

```bash
db_root_password=MovesBoct6

myql --user=root <<_EOF_
UPDATE mysql.user SET Password=PASSWORD('${db_root_password}') WHERE User='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';
FLUSH PRIVILEGES;
_EOF_
```

Create a database and a user for that database:

```bash
db_user=myuser
db_name=mydb
db_password=TicJart2

myql --user=root <<_EOF_
DROP USER ${db_user};
DROP DATABASE ${db_name};
CREATE DATABASE IF NOT EXISTS ${db_name};
GRANT ALL ON ${db_name} TO '${db_user}'@'*' IDENTIFIED BY '${db_password}';
FLUSH PRIVILEGES;
_EOF_
```
