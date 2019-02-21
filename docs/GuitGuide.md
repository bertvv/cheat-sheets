# Aan de slag met Git

In dit document vind je mijn aanbevelingen voor het werken met Git, gegroeid uit jarenlange persoonlijke ervaring, en het begeleiden van studenten die het gebruiken voor projectwerk.

## Gui vs CLI

TODO

GUI

- Verbergt complexiteit
- Verbergt details
- Beperkt mogelijkheden
- Bemoeilijkt troubleshooting
- **Je begrijpt niet wat je aan het doen bent**

CLI

- Leercurve, juiste commando's leren gaat niet vanzelf
- Geen beperkingen op mogelijkheden
- Instructies zijn éénduidig en compact
- Makkelijker reproduceerbaar

**Gebruik `git status`!**

In wat volgt, mag je er van uit gaan dat alle commando's uitgevoerd worden in de Bash shell. Op MacOS/Linux is dat de standaard shell, op Windows is dat typisch de Bash-shell meegeleverd met Git (Git Bash).

- huidige toestand
- volgende stap
- stap terugzetten

## Basisconfiguratie Git

Meteen na het installeren van Git op een systeem, voer je best meteen onderstaande commando's uit:

```console
$ git config --global user.name = "Bert Van Vreckem"
$ git config --global user.email = "bert.vanvreckem@hogent.be"
$ git config --global core.autocrlf = input
$ git config --global push.default = simple
$ git config --global pull.rebase = true
```

SSH-sleutel aanmaken

- Maak een SSH sleutelpaar aan (`ssh-keygen`)
- Registreer publieke sleutel (`~/.ssh/id_rsa.pub`) op Github

## Workflow

### Solo

Opstart:

- Repo aanmaken op Github, initialiseer met README
- Clone with SSH: `git clone git@github.com:user/repo.git`

Gebruik na elke stap `git status`

- gewijzigde/toegevoegde bestanden: rood
- bestanden in "staging": groen
- commando voor de volgende stap
- commando om stap ongedaan te maken

### Teamwerk

```console
[Bestanden bewerken]
$ git add .
$ git commit -m "Beschrijving wijzigingen"
$ git pull --rebase
[Eventuele conflicten oplossen]
$ git push
```

### Conflicten oplossen

#### Stap1: pull

```console
$ git push
To github.com:bertvv/git-demo.git
 ! [rejected]        master -> master (fetch first)
error: failed to push some refs to 'git@github.com:bertvv/git-demo.git'
hint: Updates were rejected because the remote contains work that you do
hint: not have locally. This is usually caused by another repository pushing
hint: to the same ref. You may want to first integrate the remote changes
hint: (e.g., 'git pull ...') before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
$ git pull --rebase
[ZOMG CONFLICTS!!!!!1!!!1!]
```

#### Stap2: status

```console
$ git status
rebase in progress; onto e5bd2df
You are currently rebasing branch 'master' on 'e5bd2df'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Unmerged paths:
  (use "git reset HEAD <file>..." to unstage)
  (use "git add <file>..." to mark resolution)

    both modified:   README.md

no changes added to commit (use "git add" and/or "git commit -a")
```

#### Stap 3: bewerk bestanden met conflicten

- Zoek naar markeringen
- Sommige editors (bv. VS Code) ondersteunen dit!
- Zorg dat de inhoud van het bestand is zoals je die wilt heben

```text
If you have questions, please
<<<<<< HEAD
open an issue
=======
ask your question in IRC.
>>>>>> branch-a
```

```text
If you have questions, please open an issue or ask your question in IRC.
```

#### Stap 4: geef aan dat het probleem opgelost is

```console
$ git add README.md
$ git status
rebase in progress; onto e5bd2df
You are currently rebasing branch 'master' on 'e5bd2df'.
  (all conflicts fixed: run "git rebase --continue")

Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

    modified:   README.md
$ git rebase --continue
```

#### Stap 5: push

```console
$ git status
$ git pull --rebase # om zeker te zijn dat er intussen geen andere wijzigingen zijn bij gekomen
$ git status
$ git push
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

## Tips & tricks

### Goede commit-boodschappen

- voor je teamleden
- voor je toekomstige zelf

<https://chris.beams.io/posts/git-commit/>

### Aanbevelingen ivm workflow

- KISS
- Vermijd branches
- Vaak committen (atomaire commits)
    - `git diff`
    - git add van individuele bestanden
- vaak pull/push
- Geen publieke historiek overschrijven, GEEN

    ```console
    $ git reset --hard
    $ git push --force
    ```

    Gebruik in plaats daarvan `git revert`

### Problemen met regeleindes vermijden

TODO

- config core.autocrlf
- .gitattributes

```conf
# Default behaviour
* text=auto

# Shell scripts should have Unix endings
*.sh text eol=lf
*.bats text eol=lf
*.py text eol=lf

# Windows Batch or PowerShell scripts should have CRLF endings
*.bat text eol=crlf
*.ps1 text eol=crlf
```

### Aliases

Git aliases:

```ini
# ~/.gitconfig
[alias]
  co = checkout
  l = log --pretty='format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar' --date=short --graph --all
```

Bash aliases:

```bash
# `~/.bashrc`:
alias s='git status'
alias a='git add'
alias c='git commit -m'
alias d='git diff'
alias g='git'
alias h='git log --pretty="format:%C(yellow)%h %C(blue)%ad %C(reset)%s%C(red)%d %C(green)%an%C(reset), %C(cyan)%ar" --date=short --graph --all'
alias p='git push && git push --tags'
alias gp='git pull --rebase'
alias pr='git pull --rebase'
alias pt='git push -u origin --tags'
# Git author stats
alias gs='git ls-tree -r -z --name-only HEAD | xargs -0 -n1 git blame --line-porcelain | grep  "^author "|sort|uniq -c|sort -nr'
```

### Bestanden negeren

- .gitignore, <https://github.com/github/gitignore/>
- globale .gitignore

```conf
# .gitignore_global
# Global .gitignore -- these files will always be ignored by Git, even
# if no project .gitignore was defined.
#
# Activate with
#   git config --global core.excludesfile ~/.gitignore_global

# Backup files
*~
*.bak

# Document swap files
*.swp
.~*#

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Python virtualenv
.ropeproject
```

## Bronnen

- <https://github.com/HoGentTIN/workshop-git-itlab>
- Visual Git cheat sheet: <http://ndpsoftware.com/git-cheatsheet.html#loc=stash;>
- Visualizing Git Concepts with D3: <https://onlywei.github.io/explain-git-with-d3/>
- Typische fouten rechtzetten <https://ohshitgit.com/>
- `giteveryday`: <http://git-scm.com/docs/giteveryday> (basiscommando's)
- <https://github.com/bertvv/dotfiles>
- <https://github.com/bertvv/cheat-sheets>