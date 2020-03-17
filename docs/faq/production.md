Below is a series of questions and answers around production setups when running Moov services. The hosted Moov service will have different answers than self-hosted options.

## Database Backups

#### SQLite

SQLite is a file-based database and by default Moov services don't require auth to access the file. Instead we rely on machine-level restrictions to limit access to the database file and write-ahead log.

Typically backing up a database file would be a shell command followed by copying/encrypting that file to an external data store:

```
$ sqlite3 paygate.db .backup paygate_backup.sql
```

More Details: https://stackoverflow.com/questions/25675314/how-to-backup-sqlite-database/43398520#43398520

#### MySQL

MySQL is a network-based database which requires username/password or certificate authentication to connect. The backup process for this database involves a `mysqldump` command followed by copying that file to an external data store.

- [MySQL Backup and Recovery](https://dev.mysql.com/doc/refman/8.0/en/backup-and-recovery.html)
- [Web Cheat Sheet: MySQL Backup and Restore](http://webcheatsheet.com/SQL/mysql_backup_restore.php)
