PREFILES = build.xml local.properties proguard-project.txt project.properties

compile:
	@ant compile

debug: $(PREFILES)
	@ant debug

release: $(PREFILES)
	@ant release

install:
	@adb install bin/$(NAME)-debug-unaligned.apk

uninstall:
	@adb uninstall $(PACKAGE)

net:
	adb shell netcfg

clean-ant:
	@ant clean
