# Network scanning

## Packet sniffing with tcpdump

### General options

| Task                                    | Option              |
| :---                                    | :---                |
| Write packets to file (1)               | `-w FILE`           |
| Read from specified interface           | `-i IFACE`          |
| Don't resolve adresses to names         | `-n`                |
| Don't resolve adresses and port numbers | `-nn`               |
| Verbose output                          | `-v`, `-vv`, `-vvv` |

(1) This saved file (.pcap extension is customary) can then be imported in
Wireshark for further study.

### Basic usage examples

| Task                              | Command             |
| :---                              | :---                |
| List available network interfaces | `tcpdump -D`        |
| Packets to/from HOST              | `tcpdump host HOST` |
| Packets to HOST                   | `tcpdump dst HOST`  |
| Packets from HOST                 | `tcpdump src HOST`  |
| Packets to/from PORT              | `tcpdump port PORT` |
| Ping (echo request/reply)         | `tcpdump icmp`      |
| Only UDP traffic                  | `tcpdump udp`       |

### Advanced usage examples

- Capture traffic on a remote server with tcpdump, pipe to Wireshark:
    - `ssh root@remotesystem 'tcpdump -s0 -c 1000 -nn -w - not port 22' | wireshark -k -i`
- Capture FTP credentials and commands:
    - `sudo tcpdump -nn -v port ftp or ftp-data`
- Monitor DHCP request and reply:
    - `sudo tcpdump -v -n port 67 or 68`

## Port scanning

### Scan types

Assume that all scanning types need root permissions.

| Task                               | Command            |
| :---                               | :---               |
| TCP connect scan                   | `nmap -sT TARGET`  |
| TCP SYN scan                       | `nmap -sS TARGET`  |
| UDP scan                           | `nmap -sU TARGET`  |
| Determine target OS                | `nmap -O TARGET`   |
| Determine server software/versions | `nmap -A TARGET`   |
| Ping scan (enumerate hosts)        | `nmap -sP TARGETS` |

### Selecting target/ports

| Task                       | Command                  |
| :---                       | :---                     |
| Scan IP subnet             | `nmap 192.168.56.0/24`   |
| Scan specific hosts        | `nmap 172.16.5-10.1-128` |
| Only scan specified ports: | `nmap -p BEGIN-END`      |

You can enumerate specific targets to scan them by specifying a range `x-y`, or
separated with commas (`a,b,c`). Examples:

- 192.168.56.1-254
- 192.168.56.1,10,11
- 192.168.56,58.1-10

### Scripts

**Example:** Check if a DHCP server is available (broadcast DHCP DISCOVER).

```
$ sudo nmap --script broadcast-dhcp-discover

Starting Nmap 6.40 ( http://nmap.org ) at 2018-11-22 11:09 UTC
Pre-scan script results:
| broadcast-dhcp-discover:
|   IP Offered: 10.0.2.16
|   DHCP Message Type: DHCPOFFER
|   Subnet Mask: 255.255.255.0
|   Router: 10.0.2.2
|   Domain Name Server: 10.0.2.3
|   Domain Name: hogent.be
|   IP Address Lease Time: 1 day, 0:00:00
|_  Server Identifier: 10.0.2.2
WARNING: No targets were specified, so 0 hosts scanned.
Nmap done: 0 IP addresses (0 hosts up) scanned in 0.14 seconds

```

## Resources

- Lyon, Gordon "Fyodor" (2011) *Port scanning techniques* in "Nmap network
  scanning". Retrieved 2018-11-22 from
  <https://nmap.org/book/man-port-scanning-techniques.html>
- Hacker Target (2018) *Tcpdump examples*. Retrieved 2018-11-27 from <https://hackertarget.com/tcpdump-examples/>
