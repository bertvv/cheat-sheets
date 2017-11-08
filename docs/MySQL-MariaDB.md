# Useful MySQL/MariaDB queries

## CLI

- Log in as root: `mysql -u root -p` (password is prompted)
- Log in as root with password `sekrit`: `mysql -u root -psekrit` (**REMARK**: no space allowed between `-p` and the password)
- Log in as `user` on another `host`, and use database `mydb`: `mysql -h host -u user -p mydb` (password is prompted)

## Queries

First log in as root and use the `mysql` database: `mysql -uroot -p mysql` (password is prompted). Don't forget that every query must be terminated with `;`

In the overview below, CAPITALIZED words are part of the SQL syntax, lowercase words are names of tables, columns, etc.

| Task | Query |
| :--- | :--- |
| List databases | `SHOW DATABASES;` |
| Change active database | `USE dbname;` |
| Change to the "system" database | `USE mysql;` |
| Show tables in active database | `SHOW TABLES;` |
| Show table properties | `DESCRIBE tablename;` |
| List all users | `SELECT user,host,password FROM mysql.user;` |
| List databases | `SELECT host,db,user FROM mysql.db;` |
| Quit | `exit` or `Ctrl-D` |

## "Longer" queries

The following queries can be used in a shell script.

Perform the tasks of `mysql_secure_installation`, i.e. set database root password and remove test users/database. This assumes that the database root password is **NOT** set.

```bash
db_root_password=MovesBoct6

mysql --user=root <<_EOF_
UPDATE mysql.user SET password=PASSWORD('${db_root_password}') WHERE user='root';
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.user WHERE User='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM mysql.db WHERE db='test' OR db='test\\_%';
FLUSH PRIVILEGES;
_EOF_
```

Create a database and a user with all privileges for that database (warning: user/db are first removed if they exist):

```bash
db_user=myuser
db_name=mydb
db_password=TicJart2

mysql --user=root --password <<_EOF_
DROP USER IF EXISTS ${db_user};
DROP DATABASE IF EXISTS ${db_name};
CREATE DATABASE ${db_name};
GRANT ALL ON ${db_name}.* TO '${db_user}'@'%' IDENTIFIED BY PASSWORD('${db_password}');
FLUSH PRIVILEGES;
_EOF_
```

## Backup/restore

Let's say you have a Drupal site that you want to back up/restore. The database is `drupal`.

- Backup: `mysqldump -u root -p drupal > drupal_backup.sql`
- Restore:
    - First, ensure that the `drupal` database exists (see above)
    - `mysql -u root -p drupal < drupal_backup.sql`
