MARKDOWN=\
STEPS.md         \
doc/license.md   \
doc/credits.md   \
doc/self-promotion.md

update:
	android update project --name $(NAME) --target $(TARGET) -p .

jenv:
	jenv local oracle64-1.8.0.131

README.md:
	@cat $(MARKDOWN)| ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo ''                 >> $@
	@echo ''                 >> $@
	@sed '1,2d' ETAPAS.md    >> $@

clean-README:
	rm README.md
