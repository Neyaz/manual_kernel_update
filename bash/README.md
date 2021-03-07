# BASH
-----------------------------------------------------------------------
### Задание

написать скрипт для крона
который раз в час присылает на заданную почту
- X IP адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
- Y запрашиваемых адресов (с наибольшим кол-вом запросов) с указанием кол-ва запросов c момента последнего запуска скрипта
- все ошибки c момента последнего запуска
- список всех кодов возврата с указанием их кол-ва с момента последнего запуска
в письме должно быть прописан обрабатываемый временной диапазон
должна быть реализована защита от мультизапуска.

### Решение

Запустить `vagrant up` и через 1 час проверить почту `cat /var/spool/mail/vagrant`

```
[root@bash vagrant]# cat /var/spool/mail/vagrant
From root@bash.localdomain  Sun Mar  7 11:20:01 2021
Return-Path: <root@bash.localdomain>
X-Original-To: vagrant
Delivered-To: vagrant@bash.localdomain
Received: by localhost.localdomain (Postfix, from userid 0)
	id 7D537400A4C3; Sun,  7 Mar 2021 11:20:01 +0000 (UTC)
Date: Sun, 07 Mar 2021 11:20:01 +0000
To: vagrant@bash.localdomain
Subject: Nginx report
User-Agent: Heirloom mailx 12.5 7/5/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20210307112001.7D537400A4C3@bash.localdomain>
From: root@bash.localdomain (root)

### Report ###

Top X IPs:
     45   93.158.167.130
     39   109.236.252.130
     37   212.57.117.19
     33   188.43.241.106
     31   87.250.233.68

Top Y URL Address:
    157 /
    120 /wp-login.php
     57 /xmlrpc.php
     26 /robots.txt
     12 /favicon.ico

All errors list:
    93.158.167.130 [14/Aug/2019:05:02:20 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:05:04:20 +0300] "GET / HTTP/1.1" 404
    107.179.102.58 [14/Aug/2019:05:22:10 +0300] "GET /wp-content/plugins/uploadify/readme.txt HTTP/1.1" 404
    193.106.30.99 [14/Aug/2019:06:02:50 +0300] "GET /wp-includes/ID3/comay.php HTTP/1.1" 500
    87.250.244.2 [14/Aug/2019:06:07:07 +0300] "GET / HTTP/1.1" 404
    77.247.110.165 [14/Aug/2019:06:13:53 +0300] "HEAD /robots.txt HTTP/1.0" 404
    87.250.233.76 [14/Aug/2019:06:45:20 +0300] "GET / HTTP/1.1" 404
    71.6.199.23 [14/Aug/2019:07:07:19 +0300] "GET /robots.txt HTTP/1.1" 404
    71.6.199.23 [14/Aug/2019:07:07:20 +0300] "GET /sitemap.xml HTTP/1.1" 404
    71.6.199.23 [14/Aug/2019:07:07:20 +0300] "GET /.well-known/security.txt HTTP/1.1" 404
    71.6.199.23 [14/Aug/2019:07:07:21 +0300] "GET /favicon.ico HTTP/1.1" 404
    141.8.141.136 [14/Aug/2019:07:09:43 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:08:10:56 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:08:21:48 +0300] "GET / HTTP/1.1" 404
    62.75.198.172 [14/Aug/2019:08:23:40 +0300] "POST /wp-cron.php?doing_wp_cron=1565760219.4257180690765380859375 HTTP/1.1" 499
    78.39.67.210 [14/Aug/2019:08:23:41 +0300] "GET /admin/config.php HTTP/1.1" 404
    176.9.56.104 [14/Aug/2019:08:30:17 +0300] "GET /1 HTTP/1.1" 404
    87.250.233.75 [14/Aug/2019:09:21:46 +0300] "GET / HTTP/1.1" 404
    162.243.13.195 [14/Aug/2019:09:31:47 +0300] "POST /wp-admin/admin-ajax.php?page=301bulkoptions HTTP/1.1" 400
    162.243.13.195 [14/Aug/2019:09:31:48 +0300] "GET /1 HTTP/1.1" 404
    162.243.13.195 [14/Aug/2019:09:31:50 +0300] "GET /wp-admin/admin-ajax.php?page=301bulkoptions HTTP/1.1" 400
    162.243.13.195 [14/Aug/2019:09:31:52 +0300] "GET /1 HTTP/1.1" 404
    217.118.66.161 [14/Aug/2019:10:21:00 +0300] "GET /wp-content/themes/llorix-one-lite/fonts/fontawesome-webfont.eot? HTTP/1.1" 403
    93.158.167.130 [14/Aug/2019:10:27:26 +0300] "GET /robots.txt HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:10:27:30 +0300] "GET /sitemap.xml HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:10:27:34 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:11:32:44 +0300] "GET / HTTP/1.1" 404
    141.8.141.136 [14/Aug/2019:11:33:32 +0300] "GET / HTTP/1.1" 404
    77.247.110.201 [14/Aug/2019:11:56:29 +0300] "GET /admin/config.php HTTP/1.1" 404
    62.210.252.196 [14/Aug/2019:11:57:31 +0300] "POST /wp-admin/admin-ajax.php?page=301bulkoptions HTTP/1.1" 400
    62.210.252.196 [14/Aug/2019:11:57:32 +0300] "GET /1 HTTP/1.1" 404
    62.210.252.196 [14/Aug/2019:11:57:34 +0300] "GET /wp-admin/admin-ajax.php?page=301bulkoptions HTTP/1.1" 400
    62.210.252.196 [14/Aug/2019:11:57:35 +0300] "GET /1 HTTP/1.1" 404
    60.208.103.154 [14/Aug/2019:11:59:33 +0300] "GET /manager/html HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:12:35:00 +0300] "GET / HTTP/1.1" 404
    118.139.177.119 [14/Aug/2019:12:58:37 +0300] "GET /w00tw00t.at.ISC.SANS.DFind:) HTTP/1.1" 400
    110.249.212.46 [14/Aug/2019:13:17:41 +0300] "GET http://110.249.212.46/testget?q=23333&port=80 HTTP/1.1" 400
    110.249.212.46 [14/Aug/2019:13:17:41 +0300] "GET http://110.249.212.46/testget?q=23333&port=443 HTTP/1.1" 400
    87.250.233.68 [14/Aug/2019:13:36:55 +0300] "GET / HTTP/1.1" 404
    5.45.203.12 [14/Aug/2019:13:41:42 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:14:50:19 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:14:52:27 +0300] "GET / HTTP/1.1" 404
    141.8.141.136 [14/Aug/2019:15:52:52 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:16:18:16 +0300] "GET / HTTP/1.1" 404
    5.160.111.41 [14/Aug/2019:16:51:52 +0300] "GET / HTTP/1.1" 304
    5.45.203.12 [14/Aug/2019:16:53:55 +0300] "GET / HTTP/1.1" 404
    77.247.110.69 [14/Aug/2019:17:19:49 +0300] "HEAD /robots.txt HTTP/1.0" 404
    87.250.233.76 [14/Aug/2019:17:52:20 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:17:55:02 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:19:02:51 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:19:16:50 +0300] "GET / HTTP/1.1" 404
    185.142.236.35 [14/Aug/2019:19:23:18 +0300] "GET /.well-known/security.txt HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:20:03:43 +0300] "GET / HTTP/1.1" 404
    62.75.198.172 [14/Aug/2019:20:25:44 +0300] "POST /wp-cron.php?doing_wp_cron=1565803543.6812090873718261718750 HTTP/1.1" 499
    93.158.167.130 [14/Aug/2019:20:40:19 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:20:42:50 +0300] "GET / HTTP/1.1" 404
    107.179.102.58 [14/Aug/2019:20:46:45 +0300] "GET /wp-content/plugins/uploadify/includes/check.php HTTP/1.1" 500
    5.45.203.12 [14/Aug/2019:21:50:58 +0300] "GET / HTTP/1.1" 404
    193.106.30.99 [14/Aug/2019:22:04:04 +0300] "POST /wp-content/uploads/2018/08/seo_script.php HTTP/1.1" 500
    93.158.167.130 [14/Aug/2019:22:05:00 +0300] "GET / HTTP/1.1" 404
    87.250.233.68 [14/Aug/2019:22:56:43 +0300] "GET / HTTP/1.1" 404
    93.158.167.130 [14/Aug/2019:23:31:56 +0300] "GET / HTTP/1.1" 404
    77.247.110.165 [14/Aug/2019:23:44:18 +0300] "HEAD /robots.txt HTTP/1.0" 404
    87.250.233.68 [15/Aug/2019:00:00:37 +0300] "GET / HTTP/1.1" 404
    182.254.243.249 [15/Aug/2019:00:24:38 +0300] "GET /webdav/ HTTP/1.1" 404


Requests grouped by CODE:
    Code 200 requests count - 498
    Code 301 requests count - 95
    Code 304 requests count - 1
    Code 400 requests count - 7
    Code 403 requests count - 1
    Code 404 requests count - 51
    Code 405 requests count - 1
    Code 499 requests count - 2
    Code 500 requests count - 3
```
