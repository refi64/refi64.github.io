VULCANIZE_OPTS=--exclude=/bower_components/polymer/polymer.html \
			   --exclude=/elements/google-analytics.html
HTML_MIN_OPTS=--html5 --minify-css true --minify-js true --remove-comments

.PHONY : debug release

debug :
	ln -sf $(PWD)/_imports.raw.html _imports.html

release :
	rm -f _imports.html
	vulcanize -p . _imports.raw.html $(VULCANIZE_OPTS) | \
		html-minifier $(HTML_MIN_OPTS) -o _imports.html
