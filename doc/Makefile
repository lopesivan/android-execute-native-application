MARKDOWN = credits,license,self-promotion
PT_BR    = $(shell bash -c 'echo {$(MARKDOWN)}.pt_br.md')
EN       = $(shell bash -c 'echo {$(MARKDOWN)}.en.md')

all: README.md

README.md: README.pt_br README.en
	# $@ in english
	cp README.en README.md

README.pt_br: $(PT_BR)
	# doc: Portugês do Brasil
	# header
	@cat ../log-book.md $(PT_BR) | ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo >> $@
	@echo >> $@
	# body
	@sed '1,2d' ../log-book.md >> $@
	# credits, license and self-promotion
	@for m in $(PT_BR); do echo >> $@;cat $$m >> $@ ; done

README.en: $(EN)
	# doc: English USA
	# header
	@cat ../log-book.md $(EN) | ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo >> $@
	@echo >> $@
	# body
	@sed '1,2d' ../log-book.md >> $@
	# credits, license and self-promotion
	@for m in $(EN); do echo >> $@;cat $$m >> $@ ; done

clean:
	rm README.md README.pt_br README.en
