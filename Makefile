.PHONY: app-sh test

app-sh:
	docker-compose run --rm app bash

test:
	ruby test/test.rb
