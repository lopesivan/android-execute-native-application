MARKDOWN = credits,self-promotion,license
PT_BR    = $(shell bash -c 'echo {$(MARKDOWN)}.pt_br.md')
EN       = $(shell bash -c 'echo {$(MARKDOWN)}.en.md')
PROJECT  = $(shell bash -c "echo ${PWD}| sed 's=.*/\([^/]\+\)\/doc=\1='")

all: README.pt_br README.en

README.pt_br: $(PT_BR)
	# doc: Portugês do Brasil
	# header: $(PT_BR)
	@cat ../log-book.md $(PT_BR) | ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo >> $@
	@echo >> $@
	# body
	@sed '1,2d' ../log-book.md >> $@
	# credits, license and self-promotion
	@for m in $(PT_BR); do echo >> $@;cat $$m >> $@ ; done
	@sed 's/__PROJECT_NAME__/$(PROJECT)/' -i $@

README.en: $(EN)
	# doc: English USA
	# header: $(EN)
	@cat ../log-book.md $(EN) | ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo >> $@
	@echo >> $@
	# body
	@sed '1,2d' ../log-book.md >> $@
	# credits, license and self-promotion
	@for m in $(EN); do echo >> $@;cat $$m >> $@ ; done
	@sed 's/__PROJECT_NAME__/$(PROJECT)/' -i $@

clean:
	rm README.pt_br README.en
