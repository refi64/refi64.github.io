MOPTS=--html5 --minify-css true --minify-js true --remove-comments

.PHONY : debug release

debug :
	ln -sf $(PWD)/_imports.raw.html _imports.html

release :
	rm _imports.html
	vulcanize -p . _imports.raw.html | html-minifier $(MOPTS) -o _imports.html
