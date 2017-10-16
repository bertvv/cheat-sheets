# Bash CLI tricks

## Keyboard shortcuts

You can find complete lists of Bash shortcuts elsewhere. I only write down those I'm trying to learn...

| Shortcut | Task                                                         |
| :---     | :---                                                         |
| `Ctrl-O` | Execute current line from history, on return gives next line |
| `Ctrl-U` | Delete from cursor to beginning of line                      |
| `Meta-*` | Insert all possible command line completions                 |

## Bang!

| Command |                                   |
| :---    | :---                              |
| `!!`    | Previous command                  |
| `!$`    | Last argument of previous command |
| `!*`    | All arguments of previous command |

## .inputrc

The file `~/.inputrc`, if it exists, controls the behaviour of `GNU readline` and affects many interactive programs, e.g. Bash, Python shell, etc. An example configuration:

```
# /etc/inputrc
"\C-p":history-search-backward
"\C-n":history-search-forward

set colored-stats On
set completion-ignore-case On
set completion-prefix-display-length 3
set mark-symlinked-directories On
set show-all-if-ambiguous On
set show-all-if-unmodified On
set visible-stats On
```

