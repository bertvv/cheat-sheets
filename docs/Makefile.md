# Makefiles

See my Makefile template: <https://github.com/bertvv/dotfiles/blob/master/.vim/templates/make>

## Special targets

- `.POSIX:` get reliable POSIX behaviour (first non-comment line)
- `.SUFFIXES:` ignore built-in inference rules (beginning of Makefile)
- `.PHONY:` specified targets aren't file names, always considered "unclean" (warning: NOT POSIX, GNU Make extension)

## Special macros

Macros are defined with `NAME = VALUE` and are expanded with `$(NAME)`.

- `$<` The target's prerequisites

## Inference rules

E.g. you want to convert .foo files into .bar

```Makefile
.SUFFIXES: .foo .bar
.foo.bar:
    foo2bar $<
```

## References

- Davis-Hansson, J. *Your Makefiles are wrong*. Retrieved 2020-01-15 from <https://tech.davis-hansson.com/p/make/>
- Makefile specification: <http://pubs.opengroup.org/onlinepubs/9699919799/utilities/make.html>
- Wellons, C. (2017). *A tutorial on Portable Makefiles*. Retrieved 2017-09-05 from <http://nullprogram.com/blog/2017/08/20/>
- Zaninotto, F. (2016). *Self-Documented Makefile*. Retrieved 2017-09-05 from <https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html>
