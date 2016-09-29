.PHONY : debug release

debug :
	ln -sf $(PWD)/_imports.raw.html _imports.html

release :
	vulcanize -p . _imports.raw.html > _imports.html
