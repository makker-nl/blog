@call keystore_env.bat
keytool -import -file %ROOT_CERT_HOME%\%ROOT_CERT_ALIAS_1%.cer -alias  %ROOT_CERT_ALIAS_1% -keystore %TRUST_STORE% -storepass %TRUST_PASS%
keytool -import -file %ROOT_CERT_HOME%\%ROOT_CERT_ALIAS_2%.cer -alias  %ROOT_CERT_ALIAS_2% -keystore %TRUST_STORE% -storepass %TRUST_PASS%