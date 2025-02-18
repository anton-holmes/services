**NAT proxmox**

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

