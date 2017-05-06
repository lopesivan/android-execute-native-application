MARKDOWN= log-book.md doc/license.md doc/credits.md doc/self-promotion.md

update:
	android update project --name $(NAME) --target $(TARGET) -p .

jenv:
	jenv local oracle64-1.8.0.131

#	tee | ./gh-md-toc - | sed 's/^ \+//' > $@
README.md:
	@cat $(MARKDOWN)
#	@echo ''                 >> $@
#	@echo ''                 >> $@
#	@sed '1,2d' log-book.md  >> $@

clean-README:
	rm README.md
