.PHONY: install-prehook	install install-dev lint test

install-prehook:
	cp pre-commit .git/hooks/
	
install: install-prehook
	yarn install --production

install-dev:
	yarn install --production=false

lint:
	eslint .

test:
	yarn test
