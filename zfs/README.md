## Задание 1

Определить алгоритм с наилучшим сжатием

Шаги:
- определить какие алгоритмы сжатия поддерживает zfs (gzip gzip-N, zle lzjb, lz4)
- создать 4 файловых системы на каждой применить свой алгоритм сжатия
Для сжатия использовать либо текстовый файл либо группу файлов:
- скачать файл “Война и мир” и расположить на файловой системе
wget -O War_and_Peace.txt http://www.gutenberg.org/ebooks/2600.txt.utf-8
либо скачать файл ядра распаковать и расположить на файловой системе

Результат:
- список команд которыми получен результат с их выводами
- вывод команды из которой видно какой из алгоритмов лучше


```bash
➜  zfs git:(lvm) ✗ vagrant ssh
[vagrant@server ~]$ lsblk
NAME   MAJ:MIN RM SIZE RO TYPE MOUNTPOINT
sda      8:0    0  10G  0 disk
`-sda1   8:1    0  10G  0 part /
sdb      8:16   0   1G  0 disk
sdc      8:32   0   1G  0 disk
sdd      8:48   0   1G  0 disk
sde      8:64   0   1G  0 disk
sdf      8:80   0   1G  0 disk
sdg      8:96   0   1G  0 disk
[vagrant@server ~]$ sudo -s
[root@server vagrant] zpool create test sdb sdc
[root@server vagrant] zpool list
NAME   SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
test  1.88G    99K  1.87G        -         -     0%     0%  1.00x    ONLINE  -
[root@server vagrant] zfs create test/test1
[root@server vagrant] zfs create test/test2
[root@server vagrant] zfs create test/test3
[root@server vagrant] zfs create test/test4
[root@server vagrant] zfs list
NAME         USED  AVAIL     REFER  MOUNTPOINT
test         216K  1.75G       28K  /test
test/test1    24K  1.75G       24K  /test/test1
test/test2    24K  1.75G       24K  /test/test2
test/test3    24K  1.75G       24K  /test/test3
test/test4    24K  1.75G       24K  /test/test4
[root@server vagrant] zfs set compression=gzip test/test1
[root@server vagrant] zfs set compression=zle test/test2
[root@server vagrant] zfs set compression=lzjb test/test3
[root@server vagrant] zfs set compression=lz4 test/test3
[root@server vagrant] zfs get compression
NAME        PROPERTY     VALUE     SOURCE
test        compression  off       default
test/test1  compression  gzip      local
test/test2  compression  zle       local
test/test3  compression  lz4       local
test/test4  compression  off       default
[root@server vagrant] wget -O War_and_Peace.txt http://www.gutenberg.org/files/2600/2600-0.txt
--2021-02-09 18:54:46--  http://www.gutenberg.org/files/2600/2600-0.txt
Resolving www.gutenberg.org (www.gutenberg.org)... 152.19.134.47
Connecting to www.gutenberg.org (www.gutenberg.org)|152.19.134.47|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 3359584 (3.2M) [text/plain]
Saving to: 'War_and_Peace.txt'

War_and_Peace.txt                                  100%[================================================================================================================>]   3.20M   512KB/s    in 6.9s

2021-02-09 18:54:53 (475 KB/s) - 'War_and_Peace.txt' saved [3359584/3359584]
[root@server vagrant] cp War_and_Peace.txt /test/test1
[root@server vagrant] cp War_and_Peace.txt /test/test2
[root@server vagrant] cp War_and_Peace.txt /test/test3
[root@server vagrant] cp War_and_Peace.txt /test/test4
[root@server vagrant] zfs get compression,compressratio
NAME        PROPERTY       VALUE     SOURCE
test        compression    off       default
test        compressratio  1.72x     -
test/test1  compression    gzip      local
test/test1  compressratio  2.67x     -
test/test2  compression    zle       local
test/test2  compressratio  1.00x     -
test/test3  compression    lzjb      local
test/test3  compressratio  1.36x     -
test/test4  compression    lz4       local
test/test4  compressratio  1.62x     -
```

## Задание 2

Определить настройки pool’a

Шаги:
- Загрузить архив с файлами локально.
https://drive.google.com/open?id=1KRBNW33QWqbvbVHa3hLJivOAt60yukkg
Распаковать.
- С помощью команды zfs import собрать pool ZFS.
- Командами zfs определить настройки
- размер хранилища
- тип pool
- значение recordsize
- какое сжатие используется
- какая контрольная сумма используется
Результат:
- список команд которыми восстановили pool . Желательно с Output команд.
- файл с описанием настроек settings

```bash
[root@server vagrant] zpool import -d /vagrant/zpoolexport/ otus
[root@server vagrant] zpool list
NAME   SIZE  ALLOC   FREE  CKPOINT  EXPANDSZ   FRAG    CAP  DEDUP    HEALTH  ALTROOT
otus   480M  2.18M   478M        -         -     0%     0%  1.00x    ONLINE  -
test  1.88G  9.32M  1.87G        -         -     1%     0%  1.00x    ONLINE  -
[root@server vagrant] zpool status
  pool: otus
 state: ONLINE
  scan: none requested
config:

	NAME                            STATE     READ WRITE CKSUM
	otus                            ONLINE       0     0     0
	  mirror-0                      ONLINE       0     0     0
	    /vagrant/zpoolexport/filea  ONLINE       0     0     0
	    /vagrant/zpoolexport/fileb  ONLINE       0     0     0

errors: No known data errors

  pool: test
 state: ONLINE
  scan: none requested
config:

	NAME        STATE     READ WRITE CKSUM
	test        ONLINE       0     0     0
	  sdb       ONLINE       0     0     0
	  sdc       ONLINE       0     0     0

errors: No known data errors
[root@server vagrant] zfs get recordsize,compression,checksum
NAME            PROPERTY     VALUE      SOURCE
otus            recordsize   128K       local
otus            compression  zle        local
otus            checksum     sha256     local
otus/hometask2  recordsize   128K       inherited from otus
otus/hometask2  compression  zle        inherited from otus
otus/hometask2  checksum     sha256     inherited from otus
```

### Настройки
1. pool size: `480M`
2. pool type: `mirror`
3. record size: `128k`
4. comprassion: `zle`
5. checksum: `sha256`

## Задание 3

Найти сообщение от преподавателей

Шаги:
- Скопировать файл из удаленной директории. https://drive.google.com/file/d/1gH8gCL9y7Nd5Ti3IRmplZPF1XjzxeRAG/view?usp=sharing
Файл был получен командой
zfs send otus/storage@task2 > otus_task2.file
- Восстановить файл локально. zfs receive
- Найти зашифрованное сообщение в файле secret_message

Результат:
- список шагов которыми восстанавливали
- зашифрованное сообщение

```bash
[root@server vagrant] zfs receive otus/storage < /vagrant/otus_task2.file
[root@server vagrant] zfs list
NAME             USED  AVAIL     REFER  MOUNTPOINT
otus            5.02M   347M       25K  /otus
otus/hometask2  1.88M   347M     1.88M  /otus/hometask2
otus/storage    2.83M   347M     2.83M  /otus/storage
test            9.21M  1.74G       28K  /test
test/test1      1.24M  1.74G     1.24M  /test/test1
test/test2      3.23M  1.74G     3.23M  /test/test2
test/test3      2.41M  1.74G     2.41M  /test/test3
test/test4      2.02M  1.74G     2.02M  /test/test4
[root@server vagrant] cat /otus/storage/task1/file_mess/secret_message
https://github.com/sindresorhus/awesome
```
