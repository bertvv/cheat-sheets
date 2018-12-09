# Cisco IOS

## Working with console cables

```console
sudo screen /dev/ttyUSB0 9600
```

## Show


Getting started:

```
Router>enable
Router#configure terminal
Router(config)#
```

| Task               | Command                     |
|:-------------------|:----------------------------|
| Show IPv4 settings | `show ip interface brief`   |
| Show IPv6 settings | `show ipv6 interface brief` |
| Show routing table | `show ip route`             |

## `config-if`

Set an IPv6 address:

```
Router(config)#interface G0/0/0
Router(config-if)#ipv6 address 2001:DB8:0:1::/64
Router(config-if)#ipv6 enable
Router(config-if)#no shutdown
Router(config-if)#exit
```

| Task                              | Command     |
|:----------------------------------|:------------|
| Enable crossover cable autodetect | `mdix auto` |

## Routing

### IPv6 static routing

| Task                           | Command                                    |
|:-------------------------------|:-------------------------------------------|
| Enable routing                 | `ipv6 unicast-routing`                     |
| Directly attached static route | `ipv6 route 2001:DB8::/32 g1/0/0`          |
| Recursive static route         | `ipv6 route 2001:DB8::/32 2001:DB8:3000:1` |

Resources:

- <https://www.cisco.com/c/en/us/td/docs/ios-xml/ios/iproute_pi/configuration/xe-3s/iri-xe-3s-book/ip6-route-static-xe.html>
- Example: <https://www.cisco.com/c/en/us/support/docs/ip/ip-version-6-ipv6/113361-ipv6-static-routes.html>
