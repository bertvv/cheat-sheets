# Visual Studio Code

See my [settings](https://github.com/bertvv/dotfiles/blob/master/.config/Code/User/settings.json) & [custom keybindings](https://github.com/bertvv/dotfiles/blob/master/.config/Code/User/keybindings.json)

## Installed extensions

On 2020-09-19

- BATS (J-Et. Martin)
- Docker (Microsoft)
- Edit csv (janisdd)
- Excel viewer (GrapeCity)
- Foam for VSCode (Foam)
- GitLens (Eric Amodio)
- Gray Matter (philipbe)
- Haskell Syntax Highlighting (Justin Adam)
- HTML Preview (Thomas Haakon Townsend)
- Insert Unicode (brunnerh)
- LaTeX workshop (James Yu, see below)
- Markdown All in One (Yu Zhang)
- Markdown Links (tchayen)
- Markdown Notes (kortina)
- Markdown Preview Github Styling (Matt Bierner)
- Markdown Table Formatter (Fernando Crespo)
- markdownlint (David Anson)
- Prettier - Code Formatter (Prettier)
- Python (Microsoft)
- R (Yuki Ueda)
- R Extension Pack (Yuki Ueda)
- R LSP Client (REditorSupport)
- Remote - containers (Microsoft)
- Remote - SSH (Microsoft)
- Remote - SSH: Editing Configuration Files (Microsoft)
- Remote - WSL (Microsoft)
- Remote Development (Microsoft)
- shellcheck (Timon Wong)
- Simple GHC (Haskell) Integration (dramforever)
- Sort JSON objects (richie5um2)
- Word Count (Microsoft)

## R extensions

- Setup based on Ren Kun's blog post [Writing R in VSCode: A Fresh Start](https://renkun.me/2019/12/11/writing-r-in-vscode-a-fresh-start/)
- I installed [Radian](https://github.com/randy3k/radian) to replace the default R terminal

## LaTeX workshop

### Keyboard shortcuts

See <https://cheatography.com/jcwinkler/cheat-sheets/latex-workshop-visual-studio-code/>

| Operation                          | Shortcut   |
|:-----------------------------------|:-----------|
| Build project                      | Ctrl+Alt+B |
| View PDF                           | Ctrl+Alt+V |
| Show current line in pdf (SyncTeX) | Ctrl+Alt+J |
| Cleanup auxillary files            | Ctrl+Alt+C |

### chktex warnings

Enabling `chktex` helps with finding errors in LaTeX source files, but it generates a lot of false positives. Here's how you can disable some warnings:

- disable checking for warning NN entirely
    - Add command line option `-nNN` in Settings ("Chktex > Args: Active" or `latex-workshop.chktex.args.active`)
- disable checking for warning NN in the entire file (including `\include{}`):
    - Add comment `% chktex-file NN`
- disable checking for warning on a single line:
    - Add comment `% chktex NN`

Overview of the warnings is available in the [PDF manual](file:///home/bert/Library/Manual/LaTeXAndFriends/ChkTeX.pdf).