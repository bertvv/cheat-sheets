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

- Bash Reference Manual, <https://www.gnu.org/software/bash/manual/bashref.html>
- bash(1) man page, <http://linux.die.net/man/1/bash>
- The Advanced Bash Scripting Guide (ABS) <http://www.tldp.org/LDP/abs/html/>
- Defensive Bash Programming, <http://www.kfirlavi.com/blog/2012/11/14/defensive-bash-programming>
- Aaron Maxwell, *Use the Unofficial Bash Strict Mode (Unless You Looove Debugging)*. <http://redsymbol.net/articles/unofficial-bash-strict-mode/>
- Yoann Bentz, Good practices for writing shell scripts <http://www.yoone.eu/articles/2-good-practices-for-writing-shell-scripts.html>
- Paul Armstrong, Shell Style Guide <https://google.github.io/styleguide/shell.xml>
