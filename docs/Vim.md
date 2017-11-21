# Vim Cheat sheet

Warning: this cheat sheet may contain commands that only work for my particular setup (installed plugins, custom keyboard shortcuts, etc.). See <https://github.com/bertvv/dotfiles> for my Vim configuration.

Commands work in normal mode, unless specified explicitly.

## General

| Key        | Action                                                                        |
| :---       | :-----                                                                        |
| `CapsLock` | = Second escape (Custom keyb setting)                                         |
| `C-r`      | Redo (undo undo)                                                              |
| `:!CMD`    | Shell command                                                                 |
| `,t`       | Open file with CommandT                                                       |
| `C-o`      | (in insert mode) go to normal mode for one commnand and return to insert mode |
| `C-o C-o`  | Open the last edited file at the last edited position.                        |

## Movement

| Key          | Action                                             |
| :---         | :---                                               |
| `0` / `$`    | Begin/end of line                                  |
| `w`,  `W`    | start of next word (`W` ignores punctuation)       |
| `e`,  `E`    | end of next word (`E` ignores punctuation)         |
| `b`,  `B`    | backwards by word (`B` ignores punctuation)        |
| `(` / `)`    | begin of previous/next sentence                    |
| `{` / `}`    | paragraph backward/forward                         |
| `[[` / `]]`  | section backward/forward                           |
| `a(`, `i(`   | select everything inside (), a = including (). †   |
| `C-o`, `C-i` | move to previous/next editing positions (jumplist) |
| `C-o C-o`    | Go to last edited file, last editing position      |

† Also works with `[` `{` `<` `"` `'`

## Cut/Copy/Paste

| Key                         | Action                                         |
| :-----------                | :-----------------------                       |
| `d` **movement**            | Cut                                            |
| `x`                         | Cut letter                                     |
| `y` **movement**            | Copy                                           |
| `"ad` `"ay`                 | Cut/Copy to/from register 'a' (works  for a-z) |
| `p` `P`                     | Paste after/before cursor                      |
| `"ap`                       | Paste from register 'a' (works for a-z)        |
| `"*y` `"*p`                 | Copy/paste OS clipboard                        |
| `:reg "` `:reg 0` `:reg a`  | Show contents of default/yank/a register       |
| `ciw` `caw`                 | Cut word (a = incl space) + insert mode        |
| `ci(` `ca(`                 | Cut between () (a = including ()). †           |
| `J`                         | Join lines (delete newline)                    |
| `gU` `gu` `g~` **movement** | To upper/lower case or toggle                  |

† This also works for other delimiters, e.g. `"`, `{`, `<`, etc.


## Editing tricks

| Key               | Action                                      |
| :-----------      | :-----------------------                    |
| `%s/OLD/NEW/gc`   | Interactive search/replace                  |
| `%g/PATTERN/d`    | Delete lines matching PATTERN               |
| `gU` **movement** | Change to uppercase                         |
| `gu` **movement** | Change to lowercase                         |
| `g~` **movement** | Toggle case                                 |
| `C-a` `C-x`       | Increment/decrement a number (command mode) |
| `C-n` `C-p`       | Next/previous word completion               |
| `C-xk`            | Dictionary completion (set dictionary)      |
| `C-t` `C-d`       | Indent/unindent (insert mode)               |

Dictionary completion works only when the dictionary is set, e.g.

```
:set dictionary=/usr/share/dict/words
:set dictionary=/usr/share/myspell/nl_BE.dic
```

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

Folding for specific parts of the document:

```LaTeX
%% <<< Comment
Some text or \markup.
%% >>>
```

## Tabular

| Key              | Action                                             |
| :---             | :---                                               |
| `:Tabularize /&` | Align table on the specified character (here: `&`) |

## Vim resources

* Vim tips and tricks: <https://www.cs.oberlin.edu/~kuperman/help/vim/home.html>
* Movements: <https://github.com/LevelbossMike/vim_shortcut_wallpaper>
* Langworth, I. (2017). *Vim After 15 Years.* Retrieved 2017-11-15 from <https://statico.github.io/vim3.html>
