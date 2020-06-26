# Bash CLI tricks

## Keyboard shortcuts

You can find complete lists of Bash shortcuts elsewhere. I only write down those I'm trying to learn...

| Shortcut | Task                                                         |
| :---     | :---                                                         |
| `Ctrl-O` | Execute current line from history, on return gives next line |
| `Ctrl-U` | Delete from cursor to beginning of line                      |
| `Meta-*` | Insert all possible command line completions                 |

**Bang!

| Command |                                   |
| :---    | :---                              |
| `!!`    | Previous command                  |
| `!$`    | Last argument of previous command |
| `!*`    | All arguments of previous command |

## .inputrc

The file `~/.inputrc`, if it exists, controls the behaviour of `GNU readline` and affects many interactive programs, e.g. Bash, Python shell, etc. An example configuration:

```bash
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

## Resources

- Levy, J. (2019) *The Art of Command Line.* Retrieved 2020-04-14 from <https://github.com/jlevy/the-art-of-command-line>
- Rouberol, B. (2020-04-24) *Shell productivity tips and tricks.* Retrieved 2020-06-26 from <https://blog.balthazar-rouberol.com/shell-productivity-tips-and-tricks>
