# Useful MySQL/MariaDB queries

## CLI

- Log in as root (password is prompted):

    ```
    mysql -u root -p
    ```

- Log in as root with password `sekrit` (**REMARK**: no space allowed between `-p` and the password):

    ```
    mysql -u root -psekrit
    ```

- Log in as `user` on another `host`, and use database `mydb` (password is prompted):

    ```
    mysql -h host -u user -p mydb
    ```

- Setting the root password (after clean install):

    ```
    mysqladmin password "my new password"
    ```

## Queries

First log in as root and use the `mysql` database: `mysql -uroot -p mysql` (password is prompted). Don't forget that every query must be terminated with `;`

In the overview below, CAPITALIZED words are part of the SQL syntax, lowercase words are names of tables, columns, etc.

| Task                            | Query                                        |
| :---                            | :---                                         |
| List databases                  | `SHOW DATABASES;`                            |
| Change active database          | `USE dbname;`                                |
| Change to the "system" database | `USE mysql;`                                 |
| Show tables in active database  | `SHOW TABLES;`                               |
| Show table properties           | `DESCRIBE tablename;`                        |
| List all users                  | `SELECT user,host,password FROM mysql.user;` |
| List databases                  | `SELECT host,db,user FROM mysql.db;`         |
| Quit                            | `exit` or `Ctrl-D`                           |

## Secure installation

Most HOWTOs suggest to run the `mysql_secure_installation` script after installing MariaDB/MySQL. Since that is an interactive script that constantly asks for user input, it is not suitable for automated setups. There are quick-and-dirty solutions by using either [expect](https://gist.github.com/Mins/4602864) or a [here document](http://tldrdevnotes.com/secure-mysql-install-non-interactive-bash-script), but these feel kludgy to me.

What happens in the script is basically setting the database root password and removing a test database and users.

### Setting the root password

The following snippet will set the database root password if it wasn't set before, and will do nothing if it was. The command `mysqladmin -u root status` will succeed if the password was not set, and in that case the password will be set to the specified value.

```bash
readonly mariadb_root_password=fogMeHud8

if mysqladmin -u root status > /dev/null 2>&1; then
  mysqladmin password "${mariadb_root_password}" > /dev/null 2>&1
  printf "database root password set\n"
else
  printf "skipping database root password: already set\n"
fi
```

This code snippet is [idempotent](https://en.wikipedia.org/wiki/Idempotence), i.e. you can run it several times with the same end result and without it failing if a root password was set previously.

### Removing test database and users

After setting the root password with the previous code, the following snippet will remove the test database and anonymous users. The database root user is set to only be allowed to log in from localhost.

```bash
mysql --user=root --password="${mariadb_root_password}" mysql <<_EOF_
DELETE FROM user WHERE User='';
DELETE FROM user WHERE User='root' AND host NOT IN ('localhost', '127.0.0.1', '::1');
DROP DATABASE IF EXISTS test;
DELETE FROM db WHERE db='test' OR db='test\\_%';
FLUSH PRIVILEGES;
_EOF_
```

## Create a new database and user

Create a database and a user with all privileges for that database (warning: user/db are first removed if they exist):

```bash
readonly db_user=myuser
readonly db_name=mydb
readonly db_password=TicJart2

mysql --user=root --password="${mariadb_root_password}" <<_EOF_
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
