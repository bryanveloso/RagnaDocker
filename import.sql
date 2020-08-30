CREATE DATABASE rathena; 

CREATE USER 'ragnarok'@'localhost' IDENTIFIED BY 'ragnarok';
CREATE USER 'ragnarok'@'%' IDENTIFIED BY 'ragnarok';

GRANT ALL PRIVILEGES ON rathena.* to 'ragnarok'@'localhost' IDENTIFIED BY 'ragnarok';
GRANT ALL PRIVILEGES ON rathena.* to 'ragnarok'@'%' IDENTIFIED BY 'ragnarok';

FLUSH PRIVILEGES;

USE rathena;

source /usr/bin/rathena/sql-files/main.sql;
source /usr/bin/rathena/sql-files/logs.sql;
source /usr/bin/rathena/sql-files/item_db.sql;
source /usr/bin/rathena/sql-files/item_db_re.sql;
source /usr/bin/rathena/sql-files/item_db2.sql;
source /usr/bin/rathena/sql-files/item_db2_re.sql;
source /usr/bin/rathena/sql-files/item_cash_db.sql;
source /usr/bin/rathena/sql-files/item_cash_db2.sql;
source /usr/bin/rathena/sql-files/mob_db.sql;
source /usr/bin/rathena/sql-files/mob_db2.sql;
source /usr/bin/rathena/sql-files/mob_db2_re.sql;
source /usr/bin/rathena/sql-files/mob_db_re.sql;
source /usr/bin/rathena/sql-files/mob_skill_db.sql;
source /usr/bin/rathena/sql-files/mob_skill_db2.sql;
source /usr/bin/rathena/sql-files/mob_skill_db_re.sql;
source /usr/bin/rathena/sql-files/mob_skill_db2_re.sql;
