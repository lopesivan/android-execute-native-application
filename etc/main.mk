update:
	android update project --name $(NAME) --target $(TARGET) -p .

jenv:
	jenv local oracle64-1.8.0.131
