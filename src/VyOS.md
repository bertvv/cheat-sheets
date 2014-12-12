# VyOS

Last modified: 2014-12-12 10:21:19

## Querying system information

| Action             | Command                        |
| :---               | :---                           |
| IP configuration   | `show interfaces`              |
| Routing            | `show ip route`                |
| Show configuration | `show`                         |
| Show log           | `monitor log`, `show log tail` |

## Basic configuration

Workflow:

```Shell
vyos@vyos $ configure
vyos@vyos # [configuration commands]
vyos@vyos # commit
vyos@vyos # save
vyos@vyos # exit
vyos@vyos $
```

| Action              | Command                                          |
| :---                | :---                                             |
| Set host name       | `set system host-name HOSTNAME`                  |
| Set default gateway | `set system gateway-address 192.168.0.1`         |
| Set DNS server      | `set system name-server 8.8.8.8`                 |
| Set DNS forwarding  | `set service dns forwarding listen-on eth1`      |
|                     | `set service dns forwarding name-server 8.8.8.8` |
| Turn on SSH access  | `set service ssh listen-address 0.0.0.0`         |
| Keyboard layout[^1] | `sudo dpkg-reconfigure keyboard-configuration`   |
| Set time zone       | `set system time-zone [TAB]`                     |

[^1]: Use in non-config mode

## Configuring network interfaces

| Action                               | Command                                               |
| :---                                 | :---                                                  |
| Run "normal" commands in config mode | `run COMMAND`                                         |
| Set IP address on interface          | `set interfaces ethernet eth0 address 192.168.0.1/24` |
| Run DHCP client on interface         | `set interfaces ethernet eth0 address dhcp`           |
| Set interface description            | `set interfaces ethernet eth0 description WAN`        |

## Static routing

| Action            | Command                                                                  |
| :---              | :---                                                                     |
| Add route         | `set protocols static route 192.168.0.0/24 next-hop 10.0.0.1 distance 1` |
| Set default route | `set protocols static route 0.0.0.0/0 next-hop 10.0.2.2 distance 1`      |
| Drop traffic      | `set protocols static route 172.16.0.0/12 blackhole distance '254'`      |

## RIP

Example with two directly connected networks:

```Shell
# set protocols rip network 192.168.0.0/24
# set protocols rip network 192.168.1.0/24
# set protocols rip redistribute connected
```

## Script template

```Bash
#!/bin/vbash
source /opt/vyatta/etc/functions/script-template

configure

# Fix for error "INIT: Id "TO" respawning too fast: disabled for 5 minutes"
delete system console device ttyS0

# Commands here

commit
save
```

## Resources

* [VyOS homepage](http://vyos.net/)
* [User Guide](http://vyos.net/wiki/User_Guide)
* [Unofficial Vyatta Wiki](http://wiki.het.net/)
* [Higebu's Git repos](https://github.com/higebu?tab=repositories)

