VULCANIZE_OPTS=--exclude=/elements/google-analytics.html
HTML_MIN_OPTS=--html5 --minify-css true --minify-js true --remove-comments

.PHONY : debug release

debug :
	ln -sf $(PWD)/_base.raw.html _base.html

release :
	rm -f _base.html
	vulcanize -p . _base.raw.html $(VULCANIZE_OPTS) | \
		html-minifier $(HTML_MIN_OPTS) -o _base.html
