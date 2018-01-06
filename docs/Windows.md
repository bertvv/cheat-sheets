# Windows Shell Survival Guide

Useful PowerShell and cmd-shell commands.

## Basic operations

| Task                     | Command                                          |
| :---                     | :---                                             |
| Shutdown                 | `Stop-Computer`                                  |
| Reboot                   | `Restart-Computer`                               |
| Task Manager             | `<Ctrl-Shift-Escape>` or `Start-Process Taskmgr` |
| Get environment variable | `Get-Content env:VARIABLE`                       |
| e.g. hostname            | `Get-Content env:Computername`                   |
| Set host name            | `Rename-Computer -NewName NEWNAME -restart`      |

## Localization

| Task                    | Command                                |
| :---                    | :---                                   |
| Get the date            | `Get-Date`                             |
| Set date/time           | `Set-Date "MM/DD/YYYY hh:mm:ss PM"`    |
| Get timezone            | `tzutil /g`                            |
| Set timezone (Brussels) | `tzutil /s "Romance Standard Time"`    |
| Set keyboard layout     | `Set-WinUserLanguageList nl-BE -force` |

## Network interfaces

| Task                    | Command                                                                          |
| :---                    | :---                                                                             |
| List adapters           | `Get-NetAdapter`                                                                 |
| Get connection profiles | `Get-NetAdapter `&#124;` Get-NetConnectionProfile`                                      |
| Get IP addresses        | `Get-NetIPAddress`                                                               |
| Get routing table       | `Get-NetRoute`                                                                   |
| DNS servers             | `Get-DnsClientServerAddress`                                                     |
| "netstat"               | `Get-NetTCPConnection`                                                           |
| Troubleshooting         | [`Test-NetConnection`](http://technet.microsoft.com/en-us/library/dn372891.aspx) |

## Services

| Task                      | Command                                                            |
| :---                      | :---                                                               |
| List all services         | `Get-Service `&#124;` Format-Table -autosize`                      |
| View single SERVICE       | `Get-Service `&#124;` Where name -eq SERVICE `&#124;` Format-list` |
| Start SERVICE             | `Start-Service -name SERVICE`                                      |
| Stop SERVICE              | `Stop-Service -name SERVICE`                                       |
| All service startup types | `Get-WmiObject win32_service `&#124;` Format-Table -autosize`        |
| SERVICE startup type      | `Get-WMIObject Win32_Service `&#124;` where Name -eq SERVICE`        |
| Enable SERVICE at boot    | `Set-Service -name SERVICE -StartupType Automatic`                 |
| Disable SERCIE at boot    | `Set-Service -name SERVICE -StartupType Disabled`                  |

## Firewall

| Task               | Command                                                                                          |
| :---               | :---                                                                                             |
| Get FW state       | `Get-NetFirewallProfile -PolicyStore ActiveStore`                                                |
| Get FW rules       | `Get-netfirewallrule `&#124;` format-table name,displaygroup,action,direction,enabled -autosize` |
| Disable firewall   | `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False`                           |
| Enable firewall    | `Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled True`                            |
| Set default policy | `Set-NetFirewallProfile -DefaultInboundAction Block -DefaultOutboundAction Allow `               |
| Allow inbound ping | `Get-NetFirewallRule -DisplayName "*Echo Request*" `&#124;` Set-NetFirewallRule -enabled true`   |
| Allow WinRM HTTPS  | `netsh advfirewall firewall add rule name="Allow WinRM HTTPS"`                                   |
|                    | `  dir=in localport=5986 protocol=TCP action=allow`                                              |
| Allow RDP          | `Get-NetFirewallRule -DisplayName "Remote Desktop*" `&#124;` Set-NetFirewallRule -enabled true`  |

TODO: `netsh` is the "old" way of manipulating firewall settings and may be removed in later Windows versions. There are CmdLets for the same tasks.

## Package management

### Windows

* List installed programs:
    
    ```PowerShell
    Get-ItemProperty
    HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*
    | Select-Object DisplayName, DisplayVersion, Publisher, InstallDate
    | Sort -Property DisplayName
    | Format-Table -AutoSize
    ```

* List all store-installed programs:
    
    ```PowerShell
    Get-AppxPackage | Select-Object Name, PackageFullName, Version
    | Sort -Property Name
    | Format-Table -AutoSize
    ```
    
* Remove program: `Get-AppxPackage *PACKAGE_PATTERN* | Remove-AppxPackage`

### Chocolatey

* Install Chocolatey

    ```PowerShell
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    ```

* Install BoxStarter

    ```PowerShell
    choco install Boxstarter
    ```

Useful Chocolatey commands:

| Task                    | Command                             |
| :---                    | :---                                |
| List installed packages | `choco list --local-only` (or `-l`) |
| Install                 | `choco install -y PACKAGE`          |
| Upgrade installed pkgs  | `choco upgrade -y all`              |


## Miscellaneous

| Task                    | Command                                                 |
| :---                    | :---                                                    |
| Finding files           | `Get-ChildItem -Path c:\ -Filter PATTERN -Recurse`      |
| Get Registry value      | `Get-ItemProperty -Path "HKLM:\PATH\TO\PROP"`           |
| Set Registry value      | `Set-ItemProperty -Path "PATH" -Name NAME -Value VALUE` |
| SHA-256 checksum        | `Get-FileHash FILE`                                     |
| MD5 checksum            | `Get-FileHash -Algorithm MD5 FILE`                      |
|                         | Also works for SHA1, SHA256                             |
| NetBIOS name resolution | `nbtstat -a NETBIOS_NAME -c`                            |

## Resources

* Adamczak, B. (2014). **Windows 2012 Core Survival Guide**, TechNet Blogs, Retrieved on 2014-08-30 from [http://blogs.technet.com/b/bruce_adamczak/](http://blogs.technet.com/b/bruce_adamczak/)
* Frazelle, J. (2017). *Windows for Linux nerds*. Retrieved 2017-09-16 from <https://blog.jessfraz.com/post/windows-for-linux-nerds/>
* Microsoft (2014). **Scripting with Windows PowerShell**, TechNet Library, Retrieved on 2014-08-31 from [http://technet.microsoft.com/en-us/library/bb978526.aspx](http://technet.microsoft.com/en-us/library/bb978526.aspx)

Remark: pipe symbol inside tables: use `&#124;` (but outside of code blocks!)
