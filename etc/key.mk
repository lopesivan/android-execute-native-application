OUT = ca.crt $(CLIENTNAME).crt $(CLIENTNAME).csr $(CLIENTNAME).p12 $(HOSTNAME).crt $(HOSTNAME).csr $(KEYSTORE) $(TRUSTSTORE)

create-keystore:
	# Generate a certificate authority (CA)
	keytool -genkey -alias ca -ext BC=ca:true \
	    -keyalg RSA -keysize 4096 -sigalg SHA512withRSA -keypass $(PASSWORD) \
	    -validity 3650 -dname $(DNAME_CA) \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)

add-host:
	# Generate a host certificate
	keytool -genkey -alias $(HOSTNAME) \
	    -keyalg RSA -keysize 4096 -sigalg SHA512withRSA -keypass $(PASSWORD) \
	    -validity 3650 -dname $(DNAME_HOST) \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)
	# Generate a host certificate signing request
	keytool -certreq -alias $(HOSTNAME) -ext BC=ca:true \
	    -keyalg RSA -keysize 4096 -sigalg SHA512withRSA \
	    -validity 3650 -file "$(HOSTNAME).csr" \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)
	# Generate signed certificate with the certificate authority
	keytool -gencert -alias ca \
	    -validity 3650 -sigalg SHA512withRSA \
	    -infile "$(HOSTNAME).csr" -outfile "$(HOSTNAME).crt" -rfc \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)
	# Import signed certificate into the keystore
	keytool -import -trustcacerts -alias $(HOSTNAME) \
	    -file "$(HOSTNAME).crt" \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)

export-authority:
	# Export certificate authority
	keytool -export -alias ca -file ca.crt -rfc \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)


create-truststore: export-authority
	# Import certificate authority into a new truststore
	keytool -import -trustcacerts -noprompt -alias ca -file ca.crt \
	    -keystore $(TRUSTSTORE) -storepass $(PASSWORD)

add-client:
	# Generate client certificate
	keytool -genkey -alias $(CLIENTNAME) \
	    -keyalg RSA -keysize 4096 -sigalg SHA512withRSA -keypass $(PASSWORD) \
	    -validity 3650 -dname $(DNAME_CLIENT) \
	    -keystore $(TRUSTSTORE) -storepass $(PASSWORD)
	# Generate a host certificate signing request
	keytool -certreq -alias $(CLIENTNAME) -ext BC=ca:true \
	    -keyalg RSA -keysize 4096 -sigalg SHA512withRSA \
	    -validity 3650 -file "$(CLIENTNAME).csr" \
	    -keystore $(TRUSTSTORE) -storepass $(PASSWORD)
	# Generate signed certificate with the certificate authority
	keytool -gencert -alias ca \
	    -validity 3650 -sigalg SHA512withRSA \
	    -infile "$(CLIENTNAME).csr" -outfile "$(CLIENTNAME).crt" -rfc \
	    -keystore $(KEYSTORE) -storepass $(PASSWORD)
	# Import signed certificate into the truststore
	keytool -import -trustcacerts -alias $(CLIENTNAME) \
	    -file "$(CLIENTNAME).crt" \
	    -keystore $(TRUSTSTORE) -storepass $(PASSWORD)
	# Export private certificate for importing into a browser
	keytool -importkeystore -srcalias $(CLIENTNAME) \
	    -srckeystore $(TRUSTSTORE) -srcstorepass $(PASSWORD) \
	    -destkeystore "$(CLIENTNAME).p12" -deststorepass $(PASSWORD) \
	    -deststoretype PKCS12

clean-key:
	# Remove generated artifacts
	rm $(OUT)


