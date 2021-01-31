## Manual kernel update

### Для запуска необходимо

1. `Vagrant`
2. `Virtualbox v6.1.18`

### Структура

`packer` - кофигурация packer для обновления ядра из репозитория.
`packer_from_sources` - конфигурация packer для обновления ядра из исходиников.
`test` - Vagrantfile для тестирования бокса с обновленным из исходиников ядром.

### Задание

С помощью конфигруции из папки `packer` был создан бокс с Centos с обновленным ядром из репозитория `elrepo`. Бокс был залит на [vagrantcloud](https://app.vagrantup.com/neyaz/boxes/centos-7-5)

### Задание c *

С помощью конфигруции из папки `packer_with_source` был создан бокс с Centos и собранным из исходнкиов ядром linux 5.10.11. Бокс был залит на [vagrantcloud](https://app.vagrantup.com/neyaz/boxes/centos-7-5-compiled).

Бокс получился огромным по размеру т.к. для установки модулей GuestAddition, скрипт установки проверяет существует ли папка `/lib/modules/linux5.10.11/build`, которая является симлинком на папку с исходниками ядра.

Я уверен, что можно как-то собрать вместе с ядром и модули для GuestAddition и затем удалить исходники, уменьшив размер бокса, но т.к. компиляция занимает 2-3 часа на моей машине, то проверка займет у меня кучу времени плюс не было лимита на размер бокса.

### Задание c **
При старте Vagrant устанвливается GuestAddition с помощью плагина `vbguest` и монитруются все `shared_folders`.