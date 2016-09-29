.PHONY : debug release

debug :
	ln -sf $(PWD)/_imports.raw.html _imports.html

release :
	rm _imports.html
	vulcanize -p . _imports.raw.html > _imports.html
