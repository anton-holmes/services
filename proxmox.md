## Import VM
### Добавление ВМ на сервер
Для начала получаем виртуальную машину с облачного сервиса для импорта на наш серевер
(если вы используете формат .ova то для начала разархивируйте данный формат для конвертации файла vmdk)

 ```tar -xvf /var/lib/vz/template/iso/cyber.ova -C /var/lib/vz/template/iso/```

```wget http://192.168.000.000:81/api/public/dl/WrNXtCj1/cyber.ova -O /var/lib/vz/template/iso/cyber.ova```

Данной командой мы получили нашу виртуальную машну , и она сохранилась по пути /var/lib/vz/template/iso/cyber.ova


### Конвертация ВМ
Далее преобразовываем ВМ в нужный нам формат (qcow2)
(если вы используете формат .ova то для начала разархивируйте данный формат для конвертации файла vmdk)

 ```tar -xvf /var/lib/vz/template/iso/cyber.ova -C /var/lib/vz/template/iso/```

```qemu-img convert -f vmdk /var/lib/vz/template/iso/cyber.vmdk -O qcow2 cyber.qcow2```

В команде прописываем путь где лежит наша виртуальная машина и нужный нам формат конвертации


#### Создание образа магины с интедификатором
Далее создаём образ данной машины с её интедификатором (11111) и прописываем ресурсы которые виделяем на данную ВМ

```qm create 11111 --memory 2048 --cores 2 --name cyber-vm --net0 virtio,bridge=vmbr0```


#### Импортирование машины на диск
И в последствии импортируем её с интедефикатором на наш локальный диск

```qm disk import 11111 cyber.qcow2 local-lvm```

# NAT proxmox

**create bridge**
IPv4/CIDR 192.168.102.1/24

**comment** 
nat

**PVE node**
iptables -t nat -A POSTROUTING -s 192.168.102.0/24 -o vmbr0 -j MASQUERADE

**uncomment line /etc/sysctl.conf**
```bash
net.ipv4.ip_forward=1
net.ipv6.conf.all.forwarding=1
```

```bash
iptables-save > /etc/iptables/rules.v4
ifup vmbr11
```

**proxmox migrate vm**


**proxmox add node**

