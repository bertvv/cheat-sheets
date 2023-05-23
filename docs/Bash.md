# Bash best practices

An attempt to bring order in good advice on writing Bash scripts I collected from several sources.

## General

- The principles of [Clean Code](https://www.pearson.com/us/higher-education/program/Martin-Clean-Code-A-Handbook-of-Agile-Software-Craftsmanship/PGM63937.html) apply to Bash as well
- Always use long parameter notation when available. This makes the script more readable, especially for lesser known/used commands that you don't remember all the options for.

    ```bash
    # Avoid:
    rm -rf -- "${dir}"

    # Good:
    rm --recursive --force -- "${dir}"
    ```

- Don't use:

    ```bash
    cd "${foo}"
    [...]
    cd ..
    ```

    but

    ```bash
    (
      cd "${foo}"
      [...]
    )
    ```

    `pushd` and `popd` may also be useful:

    ```bash
    pushd "${foo}"
    [...]
    popd
    ```

- Use `nohup foo | cat &` if `foo` must be started from a terminal and run in the background.

## Variables

- Prefer local variables within functions over global variables
- If you need global variables, make them readonly
- Variables should always be referred to in the `${var}` form (as opposed to `$var`.
- Variables should always be quoted, especially if their value may contain a whitespace or separator character: `"${var}"`
- Capitalization:
    - Environment (exported) variables: `${ALL_CAPS}`
    - Local variables: `${lower_case}`
- Positional parameters of the script should be checked, those of functions should not
- Some loops happen in subprocesses, so don’t be surprised when setting variabless does nothing after them. Use stdout and `grep`ing to communicate status.

## Substitution

- Always use `$(cmd)` for command substitution (as opposed to backquotes)
- Prepend a command with `\` to override alias/builtin lookup. E.g.:

    ```ShellSession
    $ \time bash -c "dnf list installed | wc -l"
    5466
    1.32user 0.12system 0:01.45elapsed 99%CPU (0avgtext+0avgdata 97596maxresident)k
    0inputs+136outputs (0major+37743minor)pagefaults 0swaps
    ```

## Output and redirection

- [For various reasons](https://www.in-ulm.de/~mascheck/various/echo+printf/), `printf` is preferable to `echo`. `printf` gives more control over the output, it's more portable and its behaviour is defined better.
- Print error messages on stderr. E.g., I use the following function:

    ```bash
    error() {
      printf "${red}!!! %s${reset}\\n" "${*}" 1>&2
    }
    ```

- Name heredoc tags with what they’re part of, like:

    ```bash
    cat <<HELPMSG
    usage $0 [OPTION]... [ARGUMENT]...

    HELPMSG
    ```

- Single-quote heredocs leading tag to prevent interpolation of text between them.

    ```bash
    cat <<'MSG'
    [...]
    MSG
    ```

- When combining a `sudo` command with redirection, it's important to realize that the root permissions only apply to the command, not to the part after the redirection operator. An example where a script needs to write to a file that's only writeable as root:

    ```bash
    # this won't work:
    sudo printf "..." > /root/some_file

    # this will:
    printf "..." | sudo tee /root/some_file > /dev/null
    ```

## Functions

Bash can be hard to read and interpret. Using functions can greatly improve readability. Principles from Clean Code apply here.

- Apply the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle): a function does one thing.
- [Don't mix levels of abstraction](http://sivalabs.in/clean-code-dont-mix-different-levels-of-abstractions/)
- Describe the usage of each function: number of arguments, return value, output
- Declare variables with a meaningful name for positional parameters of functions

    ```bash
    foo() {
      local first_arg="${1}"
      local second_arg="${2}"
      [...]
    }
    ```

- Create functions with a meaningful name for complex tests

    ```bash
    # Don't do this
    if [ "$#" -ge "1" ] && [ "$1" = '-h' ] || [ "$1" = '--help' ] || [ "$1" = "-?" ]; then
      usage
      exit 0
    fi

    # Do this
    help_wanted() {
      [ "$#" -ge "1" ] && [ "$1" = '-h' ] || [ "$1" = '--help' ] || [ "$1" = "-?" ]
    }

    if help_wanted "$@"; then
      usage
      exit 0
    fi
    ```

## Cleanup code

An idiom for tasks that need to be done before the script ends (e.g. removing temporary files, etc.). The exit status of the script is the status of the last statement *before* the `finish` function.

```bash
finish() {
  result=$?
  # Your cleanup code here
  exit ${result}
}
trap finish EXIT ERR
```

Source: Aaron Maxwell, [How "Exit Traps" can make your Bash scripts way more robust and reliable](http://redsymbol.net/articles/bash-exit-traps/).

## Writing robust scripts and debugging

Bash is not very easy to debug. There's no built-in debugger like you have with other programming languages. By default, undefined variables are interpreted as empty strings, which can cause problems further down the line. A few tips that may help:

- Always check for syntax errors by running the script with `bash -n myscript.sh`
- Use [ShellCheck](https://www.shellcheck.net/) and fix all warnings. This is a static code analyzer that can find a lot of common bugs in shell scripts. Integrate ShellCheck in your text editor (e.g. Syntastic plugin in Vim)
- Abort the script on errors and undbound variables. Put the following code at the beginning of each script.

    ```bash
    set -o errexit   # abort on nonzero exitstatus
    set -o nounset   # abort on unbound variable
    set -o pipefail  # don't hide errors within pipes
    ```

    A shorter version is shown below, but writing it out makes the script more readable.

    ```bash
    set -euo pipefail
    ```

- Use Bash's debug output feature. This will print each statement after applying all forms of substitution (parameter/command substitution, brace expansion, globbing, etc.)
    - Run the script with `bash -x myscript.sh`
    - Put `set -x` at the top of the script
    - If you only want debug output in a specific section of the script, put `set -x` before and `set +x` after the section.
- Write lots of log messages to stdout or stderr so it's easier to drill down to what part of the script contains problematic code. I have defined a few functions for logging, you can find them [in my dotfiles repository](https://github.com/bertvv/dotfiles/blob/master/.vim/UltiSnips/sh.snippets#L52).
- Use [bashdb](http://bashdb.sourceforge.net/)

## Shell script template

An annotated template for Bash shell scripts:

For now, see <https://github.com/bertvv/dotfiles/blob/master/.vim/templates/sh>

## Resources

- Araps, Dylan (2018). *Pure Bash Bible.* <https://github.com/dylanaraps/pure-bash-bible>
- Armstrong, Paul (s.d.). *Shell Style Guide.* <https://google.github.io/styleguide/shell.xml>
- Bash Hackers Wiki. <http://wiki.bash-hackers.org/start>
- Bentz, Yoann (2016). *Good practices for writing shell scripts.* <http://www.yoone.eu/articles/2-good-practices-for-writing-shell-scripts.html>
- Berkholz, Donny (2011). *Bash shell-scripting libraries.* <https://dberkholz.com/2011/04/07/bash-shell-scripting-libraries/>
- Billemont, Maarten (2017). The Bash Guide. <http://guide.bash.academy/>
- Brady, Pádraig (2008). *Common Shell Script Mistakes.* <http://www.pixelbeat.org/programming/shell_script_mistakes.html>
- Cooper, Mendel (2014). *The Advanced Bash Scripting Guide (ABS).* <http://www.tldp.org/LDP/abs/html/>
- Fox, Brian and Ramey, Chet (2009). *bash(1) man page.* <http://linux.die.net/man/1/bash>
- Free Software Foundation (2014). *Bash Reference Manual.* <https://www.gnu.org/software/bash/manual/bashref.html>
- Gite, Vivek (2010). *Linux Shell Scripting Tutorial (LSST) v2.0.* <https://bash.cyberciti.biz/guide/>
- GreyCat (Ed.) (2015). *Bash Guide.* <http://mywiki.wooledge.org/BashGuide>
- GreyCat (Ed.) (2017). *Bash Frequently Asked Questions.* <https://mywiki.wooledge.org/BashFAQ>
- GreyCat (Ed.) (2020). *Bash Pitfalls.* <https://mywiki.wooledge.org/BashPitfalls>
- Jones, M. Tim (2011). *Evolution of shells in Linux: From Bourne to Bash and beyond.* <https://www.ibm.com/developerworks/library/l-linux-shells/>
- Lavi, Kfir (2012). *Defensive Bash Programming.* <http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming>
- Maxwell, Aaron (2014). *Use the Unofficial Bash Strict Mode (Unless You Looove Debugging)*. <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
- Pennarun, Avery (2011). *Insufficiently known POSIX shell features.* <http://apenwarr.ca/log/?m=201102#28>
- Rousseau, Thibaut (2017). **Shell Scripts Matter.** <https://dev.to/thiht/shell-scripts-matter>
- Sheppard, Simon (s.d.). *Bash Keyboard Shortcuts.* <http://ss64.com/bash/syntax-keyboard.html>
- Woodruff, William (2020). *Anybody can write good bash (with a little effort).* <https://blog.yossarian.net/2020/01/23/Anybody-can-write-good-bash-with-a-little-effort>
- When to use Bash: <https://hackaday.com/2017/07/21/linux-fu-better-bash-scripting/#comment-3793634>

### Templates

- bash-script-template <https://github.com/ralish/bash-script-template>
- Bash3 Boilerplate <http://bash3boilerplate.sh/>

### Portable shell scripts

- <https://wiki.ubuntu.com/DashAsBinSh>
- <http://pubs.opengroup.org/onlinepubs/009695399/utilities/contents.html>
- <http://sites.harvard.edu/~lib113/reference/unix/portable_scripting.html>
- <https://www.gnu.org/software/autoconf/manual/autoconf.html#Portable-Shell>

### Fun

- <https://cmdchallenge.com/>
