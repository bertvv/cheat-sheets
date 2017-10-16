# tmux

## Configuration

```conf
## Tmux configuration

# remap prefix to C-a
set -g prefix C-a
unbind C-b
bind C-a send-prefix

# force config file reload with C-a r
unbind r
bind r source-file ~/.tmux.conf

# Splitting
unbind %
bind - split-window -v
bind = split-window -h

```

## Key bindings

Key bindings here may not be standard, but depend on the configuration above. Precede every key with the prefix `C-a`.

| Task                | Key             |
| :---                | :---            |
| New window          | `c`             |
| Go to window        | number          |
| New horizontal pane | `-`             |
| New vertical pane   | `=`             |
| Go to other pane    | arrow keys      |
| Toggle full screen  | `z`             |
| Scroll up/down (*)  | `PgUp` / `PgDn` |
| Detach              | `d`             |
| Reload config       | `r`             |

(*) Exit scroll mode with `C-c`

## Command line options


| Task              | Command                    |
| :---              | :---                       |
| List sessions     | `tmux ls`                  |
| Attach to session | `tmux attach -t NUM`       |
| Kill session      | `tmux kill-session -t NUM` |

## References

- Glenn Goodrich, [Tmux: a Simple Start](https://www.sitepoint.com/tmux-a-simple-start/)
- Steven De Coeyer, [Verslag Techtalk - Vim en tmux](https://www.openminds.be/nl/blog/detail/verslag-techtak-vim-en-tmux)
