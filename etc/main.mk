update:
	android update project --name $(NAME) --target $(TARGET) -p .

jenv:
	jenv local oracle64-1.8.0.131

README.md:
	@cat ETAPAS.md| ./gh-md-toc - | sed 's/^ \+//' > $@
	@echo ''                 >> $@
	@echo ''                 >> $@
	@sed '1,2d' ETAPAS.md    >> $@

clean-README:
	rm README.md
