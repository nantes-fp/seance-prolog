all: slides.html

slides.html: slides.md
	pandoc -sf markdown -t dzslides slides.md -o slides.html

view: slides.html
	firefox 'onstage.html#slides.html'

.PHONY: all view
