all: p0.html index.html

%.html: src/%.md
	mkdir -p _
	gogfm -q $^ > _/$@
	cat inc/header.html _/$@ inc/footer.html > $@

.PHONY: all ci

ci:
	scp *.html *.css login:c120b/projects/.

pdfci:
	scp -r pdf login:c120b/projects/pdf
