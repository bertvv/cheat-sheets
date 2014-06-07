# Enterprise Linux 7 (RedHat, CentOS)

Command cheat sheet for EL7. For every action, I try to give the 'canonical' command, as recommended by RedHat. That means using systemd, NetworkManager, etc.

## Network configuration

| Action                             | Command                |
| :---                               | :---                   |
| List interfaces (and IP addresses) | `ip addr`              |
| Route table                        | `ip route`             |
| DNS servers                        | `cat /etc/resolv.conf` |
|                                    |                        |

### Resources

* (https://access.redhat.com/site/documentation/en-US/Red_Hat_Enterprise_Linux/7-Beta/html/Networking_Guide/index.html)


## Services

| Action                       | Command                                  |
| :---                         | :---                                     |
| Query SERVICE status         | `sudo systemctl status SERVICE.service`  |
| List failed services on boot | `sudo systemctl --failed`                |
| Start SERVICE                | `sudo systemctl start SERVICE.service`   |
| Stop SERVICE                 | `sudo systemctl stop SERVICE.service`    |
| Restart SERVICE              | `sudo systemctl restart SERVICE.service` |
| Start SERVICE on boot        | `sudo systemctl enable SERVICE.service`  |
| Don't start SERVICE on boot  | `sudo systemctl disable SERVICE.service` |
|                              |                                          |
