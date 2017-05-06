MARKDOWN = log-book.md doc/credits.md doc/license.md doc/self-promotion.md

update:
	android update project --name $(NAME) --target $(TARGET) -p .

jenv:
	jenv local oracle64-1.8.0.131

README.md:
	@cat $(MARKDOWN) | ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo ''                   >> $@
	@echo ''                   >> $@
	@sed '1,2d' log-book.md    >> $@
	@echo ''                   >> $@
	@cat doc/credits.md        >> $@
	@echo ''                   >> $@
	@cat doc/self-promotion.md >> $@
	@echo ''                   >> $@
	@cat doc/license.md        >> $@

clean-README:
	rm README.md
