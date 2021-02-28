# SYSTEMD
-----------------------------------------------------------------------
### Задание 1

Написать service, который будет раз в 30 секунд мониторить лог на предмет наличия ключевого слова (файл лога и ключевое слово должны задаваться в /etc/sysconfig).

### Решение.
1. Создаем скрипт `watchlog/watchlog.sh`, который будет проверять слово в логах `watchlog/watchlog.log`
2. Создаем сервис `watchlog/watchlog.service`, который будет запускать скрипт
3. Создаем сервис `watchlog/watchlog.timer`, который запускает сервис скрипта каждые 30 секунд.

Проверяем работу:

```
[root@lvm vagrant]# tail -f /var/log/messages
Feb 28 10:32:59 10 systemd: Started My watchlog service.
Feb 28 10:34:00 10 systemd: Starting My watchlog service...
Feb 28 10:34:00 10 root: Sun Feb 28 10:34:00 UTC 2021: I've found word!
Feb 28 10:34:00 10 systemd: Started My watchlog service.
Feb 28 10:35:00 10 systemd: Starting My watchlog service...
Feb 28 10:35:00 10 root: Sun Feb 28 10:35:00 UTC 2021: I've found word!
Feb 28 10:35:00 10 systemd: Started My watchlog service.
Feb 28 10:36:00 10 systemd: Starting My watchlog service...
Feb 28 10:36:00 10 root: Sun Feb 28 10:36:00 UTC 2021: I've found word!
Feb 28 10:36:00 10 systemd: Started My watchlog service.
```


### Задание 2

Из репозитория epel установить spawn-fcgi и переписать init-скрипт на unit-файл (имя service должно называться так же: spawn-fcgi).

### Решение.

Создаем сервис для `fcgi/spawn-fcgi.service`.

Проверяем работу:


```
[root@lvm vagrant]# systemctl status spawn-fcgi
● spawn-fcgi.service - Spawn-fcgi startup service by Otus
   Loaded: loaded (/etc/systemd/system/spawn-fcgi.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2021-02-28 10:30:45 UTC; 10min ago
 Main PID: 4333 (php-cgi)
   CGroup: /system.slice/spawn-fcgi.service
           ├─4333 /usr/bin/php-cgi
           ├─4334 /usr/bin/php-cgi
           ├─4335 /usr/bin/php-cgi
           ├─4336 /usr/bin/php-cgi
           ├─4337 /usr/bin/php-cgi
           ├─4338 /usr/bin/php-cgi
           ├─4339 /usr/bin/php-cgi
           ├─4340 /usr/bin/php-cgi
           ├─4341 /usr/bin/php-cgi
           ├─4342 /usr/bin/php-cgi
           ├─4343 /usr/bin/php-cgi
           ├─4344 /usr/bin/php-cgi
           ├─4345 /usr/bin/php-cgi
           ├─4346 /usr/bin/php-cgi
           ├─4347 /usr/bin/php-cgi
           ├─4348 /usr/bin/php-cgi
           ├─4349 /usr/bin/php-cgi
           ├─4350 /usr/bin/php-cgi
           ├─4351 /usr/bin/php-cgi
           ├─4352 /usr/bin/php-cgi
           ├─4353 /usr/bin/php-cgi
           ├─4354 /usr/bin/php-cgi
           ├─4355 /usr/bin/php-cgi
           ├─4356 /usr/bin/php-cgi
           ├─4357 /usr/bin/php-cgi
           ├─4358 /usr/bin/php-cgi
           ├─4359 /usr/bin/php-cgi
           ├─4360 /usr/bin/php-cgi
           ├─4361 /usr/bin/php-cgi
           ├─4362 /usr/bin/php-cgi
           ├─4363 /usr/bin/php-cgi
           ├─4364 /usr/bin/php-cgi
           └─4365 /usr/bin/php-cgi

Feb 28 10:30:45 lvm systemd[1]: Started Spawn-fcgi startup service by Otus.
Feb 28 10:30:45 lvm systemd[1]: Starting Spawn-fcgi startup service by Otus...
```

### Задание 3

Дополнить unit-файл httpd (он же apache) возможностью запустить несколько инстансов сервера с разными конфигурационными файлами.

### Решение.

1. Создаем конфигурационные файлы для 2 httpd сервисов.
2. Создаем сервис `httpd/httpd@.service`, в котором принимаем аргумент для запуска сервиса с определенным конфигом.

Проверяем первый сервис:

```
[vagrant@lvm ~]$ sudo -s
[root@lvm vagrant]# systemctl status httpd@1
● httpd@1.service - The Apache HTTP Server
   Loaded: loaded (/etc/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2021-02-28 10:55:00 UTC; 2min 13s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 4455 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/system-httpd.slice/httpd@1.service
           ├─4455 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─4456 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─4457 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─4458 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─4459 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           ├─4460 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND
           └─4461 /usr/sbin/httpd -f conf/httpd-1.conf -DFOREGROUND

Feb 28 10:54:59 lvm systemd[1]: Starting The Apache HTTP Server...
Feb 28 10:55:00 lvm httpd[4455]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message
Feb 28 10:55:00 lvm systemd[1]: Started The Apache HTTP Server.
```

Проверяем второй сервис:

```
[root@lvm vagrant]# systemctl status httpd@2
● httpd@2.service - The Apache HTTP Server
   Loaded: loaded (/etc/systemd/system/httpd@.service; disabled; vendor preset: disabled)
   Active: active (running) since Sun 2021-02-28 10:55:00 UTC; 3min 1s ago
     Docs: man:httpd(8)
           man:apachectl(8)
 Main PID: 4464 (httpd)
   Status: "Total requests: 0; Current requests/sec: 0; Current traffic:   0 B/sec"
   CGroup: /system.slice/system-httpd.slice/httpd@2.service
           ├─4464 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─4465 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─4466 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─4467 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─4468 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           ├─4469 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND
           └─4470 /usr/sbin/httpd -f conf/httpd-2.conf -DFOREGROUND

Feb 28 10:55:00 lvm systemd[1]: Starting The Apache HTTP Server...
Feb 28 10:55:00 lvm httpd[4464]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 127.0.0.1. Set the 'ServerName' directive globally to suppress this message
Feb 28 10:55:00 lvm systemd[1]: Started The Apache HTTP Server.
```

