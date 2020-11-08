---
layout: post
title: "Connecting to MySQL/MariaDB, 101 stuff"
categories: informatique
summary: "A few facts I gathered about connecting to MySQL/MariaDB"
---

## Basic client-server architecture and "local-machine" usage
### Installation

This will install the server, and the client as a dependency, then start[^1] it

[^1]: in the systemd world, you can *start* (i.e. actually start the software), or *enable* (i.e. it will start on every reboot). The `--now` flag [does both](https://unix.stackexchange.com/questions/495664/one-systemctl-command-to-both-start-and-enable).


``` shell
apt install mariadb-server
systemctl enable --now mariadb 
```

If you intend to use it on a server open to the world, you should also run :
``` shell
mysql_secure_installation
```
which will suggest to add a strong root password,
remove non-local (remote) root access and
remove the test database.

### Creating a database

Let's create a database named `someNameForMyDB` a user named `joeUser` with a password `superSikr3t`.
 
``` sql
CREATE DATABASE someNameForMyDB;
GRANT ALL ON someNameForMyDB.* TO 'joeUser' IDENTIFIED BY 'superSikr3t';
```

### Changing the password of a user

[One way to change](https://linuxize.com/post/how-to-change-mysql-user-password/) it is :

``` sql
ALTER USER 'user-name'@'localhost' IDENTIFIED BY 'NEW_USER_PASSWORD';
```

Beware that there's a `.mysql_history` in your home dir (or `root`'s home dir).

Documentation :
- <https://mariadb.com/kb/en/alter-user/> for the above method
- <https://mariadb.com/kb/en/set-password/> for (older) systems lacking "ALTER USER" support.



### Connect to the database on the same machine

You can connect with :
`mysql -u joeUser -p`

This prompts for the password, then you can try a few commands :

``` sql
use someNameForMyDB;
SHOW TABLES;
```

(there are none at this point, obviously)

## Remote connectivity

### At the user level

On the server

``` sql
SELECT host, user, password, plugin FROM mysql.user;
```

The **host** column will probably have `localhost` or `%`. The former means only localhost connectivity. 
The latter means anyone (also remote) can connect (but see below for a global setting).

The **plugin** column will have `unix_socket` if local connection can be made without a password.
On my Debian 10 this is the case for the root user (i.e. the root Linux user can connect as the root MariaDB user without the MariaDB password).
This is cool : it means you can set an impossible password for root (e.g. `pwgen -s 20 1`), and forget it immediately. You probably never actually need it.

The **password** column contains a hash of the password.

### At the global level

On my Debian, most of the stuff is configured 
in the file `/etc/mysql/mariadb.conf.d/50-server.cnf`

In the default configuration, the following line forbids all remote connections : 
```
bind-address = 127.0.0.1
```

It's a good setting if all SQL clients are on the same machine.


### Using mysql on the command line to test connectivity

If you're on a different machine, use the `-h` flag to specify the hostname / server address.

``` shell
mysql -h server-address -u username -p
```
(The `-p` flags means: ask for a password.)

## sql clients

### command line mysql

Simply `mysql` on the command line. Basic relevant options are 
- `-u username`
- `-p` -- this asks a password
- `-h hostname/address`

### phpMyAdmin

I do not use it anymore. (it's a php app that has to be secured.)

### dBeaver

Multiplatform client. 
Works for me.
It will connect to mySQL databases as well as many others, including MS Access databases.
