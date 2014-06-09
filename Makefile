# Generate PDFs from the Markdown source files
#
# In order to use this makefile, you need some tools:
# - GNU make
# - Pandoc
# - LuaLaTeX
# - DejaVu Sans fonts

# Directory containing source (Markdown) files
source := src

# Directory containing pdf files
output := print

# All markdown files in src/ are considered sources
sources := $(wildcard $(source)/*.md)

# Target file type is PDF
objects := $(patsubst %.md,%.pdf,$(subst $(source),$(output),$(sources)))

.PHONY : test

test:
	echo $(source)
	echo $(output)
	echo $(sources)
	echo $(objects)

all: $(objects)

$(output)/%.pdf: $(source)/%.md
	pandoc --variable mainfont="DejaVu Sans" \
		--variable monofont="DejaVu Sans Mono" \
		--variable fontsize=11pt \
		--variable geometry:margin=1.5cm \
		-f markdown  $< \
		--latex-engine=lualatex \
		-o $@

.PHONY : clean

clean:
	rm -f $(output)/*

