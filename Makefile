VERSION    = 0.1
NAME       = NativeExec
PACKAGE    = net.gimite.nativeexe
TARGET     = android-15
PASSWORD   = senha-facil
KEYSTORE   = keystore.jks
HOSTNAME   = localhost
CLIENTNAME = cid

# CN = Common Name
# OU = Organization Unit
# O  = Organization Name
# L  = Locality Name
# ST = State Name
# C  = Country (2-letter Country Code)
# E  = Email
DNAME_CA     = 'CN=Baeldung CA,OU=baeldung.com,O=Baeldung,L=SomeCity,ST=SomeState,C=CC'
# For server certificates, the Common Name (CN) must be the hostname
DNAME_HOST   = 'CN=$(HOSTNAME),OU=baeldung.com,O=Baeldung,L=SomeCity,ST=SomeState,C=CC'
DNAME_CLIENT = 'CN=$(CLIENTNAME),OU=baeldung.com,O=Baeldung,L=SomeCity,ST=SomeState,C=CC'
TRUSTSTORE   = truststore.jks

all:           pre-build
key:           create-keystore add-host create-truststore add-client
pre-build:     update jenv
build:         debug
build-release: create-keystore relesase

README:
	@make -C doc
	@test -e README.md && rm README.md
	@ln -s doc/README.md

clean:         clean-key clean-ant
	@make -C doc clean

include etc/main.mk
include etc/ant.mk
include etc/key.mk
