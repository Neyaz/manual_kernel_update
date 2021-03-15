# Processes
-----------------------------------------------------------------------
### Задание

написать свою реализацию ps ax используя анализ /proc
- Результат ДЗ - рабочий скрипт который можно запустить

### Решение

Запустить скрипт `./ps.sh` от root юзера

#### Вывод ps aux
```
 ps ax
  PID TTY      STAT   TIME COMMAND
    1 ?        Ss     0:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
    2 ?        S      0:00 [kthreadd]
    4 ?        S<     0:00 [kworker/0:0H]
    5 ?        S      0:00 [kworker/u2:0]
    6 ?        S      0:00 [ksoftirqd/0]
    7 ?        S      0:00 [migration/0]
    8 ?        S      0:00 [rcu_bh]
    9 ?        R      0:00 [rcu_sched]
   10 ?        S<     0:00 [lru-add-drain]
   11 ?        S      0:00 [watchdog/0]
   13 ?        S      0:00 [kdevtmpfs]
   14 ?        S<     0:00 [netns]
   15 ?        S      0:00 [khungtaskd]
   16 ?        S<     0:00 [writeback]
   17 ?        S<     0:00 [kintegrityd]
   18 ?        S<     0:00 [bioset]
   19 ?        S<     0:00 [bioset]
   20 ?        S<     0:00 [bioset]
   21 ?        S<     0:00 [kblockd]
   22 ?        S<     0:00 [md]
   23 ?        S<     0:00 [edac-poller]
   24 ?        S<     0:00 [watchdogd]
   25 ?        S      0:00 [kworker/0:1]
   26 ?        S      0:00 [kworker/u2:1]
   33 ?        S      0:00 [kswapd0]
   34 ?        SN     0:00 [ksmd]
   35 ?        S<     0:00 [crypto]
   43 ?        S<     0:00 [kthrotld]
   44 ?        S<     0:00 [kmpath_rdacd]
   45 ?        S<     0:00 [kaluad]
   46 ?        S<     0:00 [kpsmoused]
   47 ?        S<     0:00 [ipv6_addrconf]
   48 ?        S      0:00 [kworker/0:2]
   61 ?        S<     0:00 [deferwq]
   95 ?        S      0:00 [kauditd]
  131 ?        S<     0:00 [ata_sff]
  134 ?        S      0:00 [scsi_eh_0]
  136 ?        S<     0:00 [scsi_tmf_0]
  137 ?        S      0:00 [scsi_eh_1]
  138 ?        S<     0:00 [scsi_tmf_1]
  155 ?        S<     0:00 [bioset]
  156 ?        S<     0:00 [xfsalloc]
  157 ?        S<     0:00 [xfs_mru_cache]
  158 ?        S<     0:00 [xfs-buf/sda1]
  159 ?        S<     0:00 [xfs-data/sda1]
  160 ?        S<     0:00 [xfs-conv/sda1]
  161 ?        S<     0:00 [xfs-cil/sda1]
  162 ?        S<     0:00 [xfs-reclaim/sda]
  163 ?        S<     0:00 [xfs-log/sda1]
  164 ?        S<     0:00 [xfs-eofblocks/s]
  165 ?        R      0:00 [xfsaild/sda1]
  166 ?        S<     0:00 [kworker/0:1H]
  228 ?        Ss     0:00 /usr/lib/systemd/systemd-journald
  260 ?        Ss     0:00 /usr/lib/systemd/systemd-udevd
  282 ?        S<sl   0:00 /sbin/auditd
  287 ?        S<     0:00 [rpciod]
  288 ?        S<     0:00 [xprtiod]
  335 ?        Ssl    0:00 /usr/lib/polkit-1/polkitd --no-debug
  339 ?        Ssl    0:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
  341 ?        Ss     0:00 /sbin/rpcbind -w
  348 ?        S      0:00 /usr/sbin/chronyd
  355 ?        Ssl    0:00 /usr/sbin/gssproxy -D
  397 ?        Ss     0:00 /usr/lib/systemd/systemd-logind
  427 tty1     Ss+    0:00 /sbin/agetty --noclear tty1 linux
  428 ?        Ss     0:00 /usr/sbin/crond -n
  615 ?        Ss     0:00 /usr/sbin/sshd -D -u0
  616 ?        Ssl    0:00 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
  619 ?        Ssl    0:00 /usr/sbin/rsyslogd -n
  860 ?        Ss     0:00 /usr/libexec/postfix/master -w
  863 ?        S      0:00 pickup -l -t unix -u
  864 ?        S      0:00 qmgr -l -t unix -u
 2957 ?        Ssl    0:00 /usr/sbin/NetworkManager --no-daemon
 2974 ?        S      0:00 /sbin/dhclient -d -q -sf /usr/libexec/nm-dhcp-helper -pf /var/run/dhclient-eth0.pid -lf /var/lib/NetworkManager/dhclient-5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03-eth0.lease -cf /var
 3841 ?        R      0:00 [kworker/0:0]
 3842 ?        Ss     0:00 sshd: vagrant [priv]
 3845 ?        S      0:00 sshd: vagrant@pts/0
 3846 pts/0    Ss     0:00 -bash
 3869 pts/0    S      0:00 sudo -s
 3871 pts/0    S      0:00 /bin/bash
 5548 pts/0    R+     0:00 ps ax
```

#### Вывод ps.sh

```
[root@bash vagrant]# ./ps.sh
    PID TTY     STAT         TIME COMMAND
      1 ?       Ss           00:01 /usr/lib/systemd/systemd --switched-root --system --deserialize 21
      2 ?       S            00:00 [kthreadd]
      4 ?       S<           00:00 [kworker/0:0H]
      5 ?       S            00:00 [kworker/u2:0]
      6 ?       S            00:00 [ksoftirqd/0]
      7 ?       S            00:00 [migration/0]
      8 ?       S            00:00 [rcu_bh]
      9 ?       S            00:00 [rcu_sched]
     10 ?       S<           00:00 [lru-add-drain]
     11 ?       S            00:00 [watchdog/0]
     13 ?       S            00:00 [kdevtmpfs]
     14 ?       S<           00:00 [netns]
     15 ?       S            00:00 [khungtaskd]
     16 ?       S<           00:00 [writeback]
     17 ?       S<           00:00 [kintegrityd]
     18 ?       S<           00:00 [bioset]
     19 ?       S<           00:00 [bioset]
     20 ?       S<           00:00 [bioset]
     21 ?       S<           00:00 [kblockd]
     22 ?       S<           00:00 [md]
     23 ?       S<           00:00 [edac-poller]
     24 ?       S<           00:00 [watchdogd]
     25 ?       S            00:00 [kworker/0:1]
     26 ?       S            00:00 [kworker/u2:1]
     33 ?       S            00:00 [kswapd0]
     34 ?       SN           00:00 [ksmd]
     35 ?       S<           00:00 [crypto]
     43 ?       S<           00:00 [kthrotld]
     44 ?       S<           00:00 [kmpath_rdacd]
     45 ?       S<           00:00 [kaluad]
     46 ?       S<           00:00 [kpsmoused]
     47 ?       S<           00:00 [ipv6_addrconf]
     48 ?       S            00:00 [kworker/0:2]
     61 ?       S<           00:00 [deferwq]
     95 ?       S            00:00 [kauditd]
    131 ?       S<           00:00 [ata_sff]
    134 ?       S            00:00 [scsi_eh_0]
    136 ?       S<           00:00 [scsi_tmf_0]
    137 ?       S            00:00 [scsi_eh_1]
    138 ?       S<           00:00 [scsi_tmf_1]
    155 ?       S<           00:00 [bioset]
    156 ?       S<           00:00 [xfsalloc]
    157 ?       S<           00:00 [xfs_mru_cache]
    158 ?       S<           00:00 [xfs-buf/sda1]
    159 ?       S<           00:00 [xfs-data/sda1]
    160 ?       S<           00:00 [xfs-conv/sda1]
    161 ?       S<           00:00 [xfs-cil/sda1]
    162 ?       S<           00:00 [xfs-reclaim/sda]
    163 ?       S<           00:00 [xfs-log/sda1]
    164 ?       S<           00:00 [xfs-eofblocks/s]
    165 ?       S            00:00 [xfsaild/sda1]
    166 ?       S<           00:00 [kworker/0:1H]
    228 ?       Ss           00:00 /usr/lib/systemd/systemd-journald
    260 ?       Ss           00:00 /usr/lib/systemd/systemd-udevd
    282 ?       S<sl         00:00 /sbin/auditd
    287 ?       S<           00:00 [rpciod]
    288 ?       S<           00:00 [xprtiod]
    335 ?       Ssl          00:00 /usr/lib/polkit-1/polkitd --no-debug
    339 ?       Ssl          00:00 /usr/bin/dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation
    341 ?       Ss           00:00 /sbin/rpcbind -w
    348 ?       S            00:00 /usr/sbin/chronyd
    355 ?       Ssl          00:00 /usr/sbin/gssproxy -D
    397 ?       Ss           00:00 /usr/lib/systemd/systemd-logind
    427 tty1    Ss+          00:00 /sbin/agetty --noclear tty1 linux
    428 ?       Ss           00:00 /usr/sbin/crond -n
    615 ?       Ss           00:00 /usr/sbin/sshd -D -u0
    616 ?       Ssl          00:00 /usr/bin/python2 -Es /usr/sbin/tuned -l -P
    619 ?       Ssl          00:00 /usr/sbin/rsyslogd -n
    860 ?       Ss           00:00 /usr/libexec/postfix/master -w
    863 ?       S            00:00 pickup -l -t unix -u
    864 ?       S            00:00 qmgr -l -t unix -u
   2957 ?       Ssl          00:00 /usr/sbin/NetworkManager --no-daemon
   2974 ?       S            00:00 /sbin/dhclient -d -q -sf /usr/libexec/nm-dhcp-helper -pf /var/run/dhclient-eth0.pid -lf /var/lib/NetworkManager/dhclient-5fb06bd0-0bb0-7ffb-45f1-d6edd65f3e03-eth0.lease -cf /var/lib/NetworkManager/dhclient-eth0.conf eth0
   3841 ?       S            00:00 [kworker/0:0]
   3842 ?       Ss           00:00 sshd:
   3845 ?       S            00:00 sshd:
   3846 pts/0   Ss+          00:00 -bash
   3869 pts/0   S+           00:00 sudo -s
   3871 pts/0   S+           00:00 /bin/bash
   5549 pts/0   S+           00:00 /bin/bash ./ps.sh
   5550 pts/0   S+           00:00 /bin/bash ./ps.sh
   5551 pts/0   S+           00:00 /bin/bash ./ps.sh
   5552 pts/0   S+           00:00 /bin/bash ./ps.sh
   5553 pts/0   S+           00:00 /bin/bash ./ps.sh
   5554 pts/0   S+           00:00 /bin/bash ./ps.sh
```
