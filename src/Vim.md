# Vim Cheat sheet

Last Modified: 2014-06-08 23:05:55

Warning: this cheat sheet may contain commands that only work for my particular setup (installed plugins, custom keyboard shortcuts, etc.). See https://github.com/bertvv/dotfiles for my Vim configuration.

## General

| Key        | Action                               |
| :---       | :-----                               |
| `CapsLock` | = Second escape (Custom keyb setting |
| `C-r`      | Redo (undo undo)                     |
| `:!CMD`    | Shell command                        |
| `,t`       | Open file with CommandT              |

## Movement

| Key       | Action                                                                             |
| :---      | :---                                                                               |
| `0` `$`   | Begin/end of line                                                                  |
| `w` `W`   | start of next word (`W` ignores punctuation)                                       |
| `e` `E`   | end of next word (`E` ignores punctuation)                                         |
| `b` `B`   | backwards by word (`B` ignores punctuation)                                        |
| `(` `)`   | begin of previous/next sentence                                                    |
| `{` `}`   | paragraph backward/forward                                                         |
| `[[` `]]` | section backward/forward                                                           |
| `a(` `i(` | select everything inside (), a = including (). Also works with `[` `{` `<` `"` `'` |

## Cut/Copy/Paste

| Key                         | Action                                                             |
| :-----------                | :-----------------------                                           |
| `d` **movement**            | Cut                                                                |
| `x`                         | Cut letter                                                         |
| `y` **movement**            | Copy                                                               |
| `"ad` `"ay`                 | Cut/Copy to/from register 'a' (works  for a-z)                     |
| `p` `P`                     | Paste after/before cursor                                          |
| `"ap`                       | Paste from register 'a' (works for a-z)                            |
| `"*y` `"*p`                 | Copy/paste OS clipboard                                            |
| `:reg "` `:reg 0` `:reg a`  | Show contents of default/yank/a register                           |
| `ciw` `caw`                 | Cut word (a = incl space) + insert mode                            |
| `ci(` `ca(`                 | Cut between () (a = including ()). Also works for other delimiters |
| `J`                         | Join lines (delete newline)                                        |
| `gU` `gu` `g~` **movement** | To upper/lower case or toggle                                      |

## Editing tricks

| Key                         | Action                                                             |
| :-----------                | :-----------------------                                           |
| `%s/OLD/NEW/gc`             | Interactive search/replace |
| `gU` **movement**           | Change to uppercase |
| `gu` **movement**           | Change to lowercase |
| `g~` **movement**           | Toggle case |

## Split screen

| Key           | Action                   |
| :-----------  | :----------------------- |
| `C-w s`       | horizontal split         |
| `C-w v`       | vertical split           |
| `C-w q`       | close split              |
| `C-w up/down` | switch split             |
| `C-w C-w`     | cycle splits             |

## Folding

| Key    | Action                           |
| :----- | :--------                        |
| `zi`   | Expand/collapse all              |
| `zj`   | Go to next fold                  |
| `zk`   | Go to prev fold                  |
| `zA`   | Toggle current fold, recursively |
| `zc`   | Close fold (or parent)           |
| `zMzv` | Close all other folds            |

## LaTeX-Vim

| Key          | Action                           |
| :-----       | :--------                        |
| `EEN`        | Enumerate environment            |
| `EIT`        | Itemize environment              |
| `EVM`        | Verbatim environment             |
| `,it`        | `\item`                          |
| `FEM`        | Emphasis                         |
| `,em`        | Apply emphasis to selection      |
| `FTT`        | Teletype                         |
| `,tt`        | Apply teletype to selection      |
| `,ll`        | Compile                          |
| `,lv`        | View PDF                         |
| `C-j`        | Jump to next placeholder `<++>`  |
| `F5`         | Insert environment (interactive) |
| `<Shift>-F5` | Change environment               |
| `F9`         | Autocomplete citation            |
