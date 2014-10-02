all: p0.html index.html syscall.html

%.html: src/%.html
	cat inc/header.html $^ inc/footer.html > $@

.PHONY: all ci

ci:
	scp *.html *.css login:c120b/projects/.

pdfci:
	scp -r pdf login:c120b/projects/pdf
