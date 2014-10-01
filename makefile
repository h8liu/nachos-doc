all: p0.html

%.html: src/%.md
	mkdir -p _
	gogfm -q $^ > _/$@
	cat inc/header.html _/$@ inc/footer.html > $@
