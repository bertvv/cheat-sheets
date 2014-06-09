# Cheat sheets

This is a collection of 'cheat sheets' that I compiled for various stuff... Although you're welcome to use them, I highly recommend you to create your own from the ground up. A cheat sheet is personal and should be highly customized to your situation and to the way your brain works. You will probably want to structure it differently than I did, for example. Ideally, a cheat sheet contains those commands/shortcuts that you recently learned and want to have at hand because you haven't commited them to long-term memory yet. Things that you know well should not be in the cheat sheet. Too many commands that you don't know at all is also not ideal, as it makes it hard to find what you need in the list.

Some recommendations to build a cheat sheet:

* **Print** it out and put it next to your computer when you're working.
* **Write down new commands/tips** as you learn them. This helps identifying things you recently learned.
* When you feel like it, add written tips to the cheat sheet and **commit** your changes.
* Print out a new version, **mark** items that you still have difficulty to remember.
* On the printed sheet, also keep a list of things that you find **difficult**, don't work well, frustrate you. When you have some time, you can look for a solution and add it to the cheat sheet.

Anyway, I hope you find some inspiration here, or maybe learn something new.

## Generating the PDFs

For convenience, I provide PDF versions of the cheat sheets in the `print/` directory. If you want to create these yourself (e.g. if you update my cheat sheets, or want to do the same for your own), you need a few tools:

- [GNU make](https://www.gnu.org/software/make/)
- [Pandoc](http://johnmacfarlane.net/pandoc/)
- A LaTeX distribution, including LuaLaTeX
- The DejaVu Sans and DejaVu Sans Mono fonts

If you want to use other fonts, just modify the Makefile to your liking.

To generate all (recently modified) cheat sheet PDFs, just type

```
make
```

To generate the PDF for a specific cheat sheet (let's say *NetworkTroubleshooting.md*):

```
make NetworkTroubleshooting.pdf
```

This will still work if you add your own Markdown files.

