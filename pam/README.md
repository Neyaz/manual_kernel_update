# PAM
-----------------------------------------------------------------------
### Домашнее задание
PAM

Запретить всем пользователям, кроме группы admin логин в выходные (суббота и воскресенье), без учета праздников
дать конкретному пользователю права работать с докером и возможность рестартить докер сервис

### Решение

`vagrant up` создаются 2 пользователя: `user1` и `user2`.
`user1` добавлен в группу `admin` и может логинится в любой день. `user2` не добавлен
в группу `admin` и может логинится только в будни.

Для `user1` добавлены привелегии рута

```
echo "cap_sys_admin user1" > /etc/security/capability.conf
```
и в /etc/pam.d/su

```
auth     optional     pam_cap.so
```

Вывод `capsh --print` для `user1`

```
[user1@10 vagrant]$ capsh --print
Current: = cap_sys_admin+i
Bounding set =cap_chown,cap_dac_override,cap_dac_read_search,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_linux_immutable,cap_net_bind_service,cap_net_broadcast,cap_net_admin,cap_net_raw,cap_ipc_lock,cap_ipc_owner,cap_sys_module,cap_sys_rawio,cap_sys_chroot,cap_sys_ptrace,cap_sys_pacct,cap_sys_admin,cap_sys_boot,cap_sys_nice,cap_sys_resource,cap_sys_time,cap_sys_tty_config,cap_mknod,cap_lease,cap_audit_write,cap_audit_control,cap_setfcap,cap_mac_override,cap_mac_admin,cap_syslog,35,36
Securebits: 00/0x0/1'b0
 secure-noroot: no (unlocked)
 secure-no-suid-fixup: no (unlocked)
 secure-keep-caps: no (unlocked)
uid=1001(user1)
gid=1001(user1)
groups=1001(user1),1003(admin)
```
