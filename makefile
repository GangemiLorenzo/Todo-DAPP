adb-reverse:
	adb reverse tcp:7545 tcp:7545

build-and-deploy:
	truffle build 
	truffle migrate