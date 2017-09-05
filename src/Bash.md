# Bash best practices

An attempt to bring order in good advice on writing Bash scripts I collected from several sources.

## General

- Always check for syntax errors and use ShellCheck. Integrate this in your text editor (e.g. Syntastic plugin in Vim)
- The principles of Clean Code apply to Bash as well
- Always use long parameter notation when available

    ```Bash
    # Avoid:
    rm -rf "${dir}"

    # Good:
    rm --recursive --force "${dir}"
    ```

## Variables

- Prefer local variables within functions over global variables
- If you need global variables, make them readonly
- Variable should always be referred to in the `${var}` form (as opposed to `$var`.
- Variables should always be quoted: `"${var}"`
- Capitalization:
    - Readonly/environment variables: `${ALL_CAPS}`
    - Local/mutable variables: `${lower_case}`
- Declare variables with a meaningful name for positional parameters of functions

    ```Bash
    foo() {
      local first_arg="${1}"
      local second_arg="${2}"
      [...]
    }
    ```
- Positional parameters of the script should be checked, those of functions should not


## Substitution

- Always use `$(cmd)` for command substitution (as opposed to backquotes)
- Prepend a command with `\` to override alias/builtin lookup. E.g.:

    ```
    $ \time bash -c "dnf list installed | wc -l"
    5466
    1.32user 0.12system 0:01.45elapsed 99%CPU (0avgtext+0avgdata 97596maxresident)k
    0inputs+136outputs (0major+37743minor)pagefaults 0swaps
    ```

## Functions

Bash can be hard to read and interpret. Using functions can greatly improve readability. Principles from Clean Code apply here.

- Apply the [Single Responsibility Principle](https://en.wikipedia.org/wiki/Single_responsibility_principle): a function does one thing.
- Create functions with a meaningful name for complex tests

    ```Bash
    # Don't do this
    if [ "$#" -ge "1" ] && [ "$1" = '-h' -o "$1" = '--help' -o "$1" = "-?" ]; then
      usage
      exit 0
    fi

    # Do this
    help_wanted() {
      [ "$#" -ge "1" ] && [ "$1" = '-h' -o "$1" = '--help' -o "$1" = "-?" ]
    }

    if help_wanted "$@"; then
      usage
      exit 0
    fi
    ```
- [Don't mix levels of abstraction](http://sivalabs.in/clean-code-dont-mix-different-levels-of-abstractions/)
- Describe the usage of each function: number of arguments, return value, output

## Cleanup code

An idiom for tasks that need to be done before the script ends (e.g. removing temporary files, etc.).

```Bash
function finish {
  # Your cleanup code here
}
trap finish EXIT
```

Source: Aaron Maxwell, [How "Exit Traps" can make your Bash scripts way more robust and reliable](http://redsymbol.net/articles/bash-exit-traps/).

## Shell script template

An annotated template for Bash shell scripts:

For now, see <https://github.com/bertvv/dotfiles/blob/master/.vim/templates/sh>

## Resources

- Armstrong, Paul (s.d.). *Shell Style Guide.* <https://google.github.io/styleguide/shell.xml>
- BashFAQ <http://mywiki.wooledge.org/BashFAQ>, BashGuide <http://mywiki.wooledge.org/BashGuide>
- Bash Hackers Wiki. <http://wiki.bash-hackers.org/start>
- Bentz, Yoann (2016). *Good practices for writing shell scripts.* <http://www.yoone.eu/articles/2-good-practices-for-writing-shell-scripts.html>
- Berkholz, Donny (2011). *Bash shell-scripting libraries.* <https://dberkholz.com/2011/04/07/bash-shell-scripting-libraries/>
- Billemont, Maarten (2017). The Bash Guide. <http://guide.bash.academy/>
- Brady, Pádraig (2008). *Common Shell Script Mistakes.* <http://www.pixelbeat.org/programming/shell_script_mistakes.html>
- Cooper, Mendel (2014). *The Advanced Bash Scripting Guide (ABS).* <http://www.tldp.org/LDP/abs/html/>
- Fox, Brian and Ramey, Chet (2009). *bash(1) man page.* <http://linux.die.net/man/1/bash>
- Free Software Foundation (2014). *Bash Reference Manual.* <https://www.gnu.org/software/bash/manual/bashref.html>
- Gite, Vivek (2010). *Linux Shell Scripting Tutorial (LSST) v2.0.* <https://bash.cyberciti.biz/guide/>
- Jones, M. Tim (2011). *Evolution of shells in Linux: From Bourne to Bash and beyond.* <https://www.ibm.com/developerworks/library/l-linux-shells/>
- Lavi, Kfir (2012). *Defensive Bash Programming.* <http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming>
- Maxwell, Aaron (2014). *Use the Unofficial Bash Strict Mode (Unless You Looove Debugging)*. <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
- Pennarun, Avery (2011). *Insufficiently known POSIX shell features.* <http://apenwarr.ca/log/?m=201102#28>
- Rousseau, Thibaut (2017). **Shell Scripts Matter.** <https://dev.to/thiht/shell-scripts-matter>
- Sheppard, Simon (s.d.). *Bash Keyboard Shortcuts.* <http://ss64.com/bash/syntax-keyboard.html>

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
