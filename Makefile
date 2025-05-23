.PHONY: all main council hall gardening clean clean_main clean_council clean_hall dev

HUGO_ENV:=production

all: main council hall gardening

main council hall gardening:
	hugo --minify --environment=$(HUGO_ENV) --source=$@

clean: clean_main clean_council clean_hall clean_gardening

clean_main clean_council clean_hall clean_gardening:
	rm -rf $(subst clean_,,$@)/public

dev:
	npx run-pty % \
		npx --yes decap-server % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1313 --minify --source=main % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1314 --minify --source=council % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1315 --minify --source=hall % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1316 --minify --source=gardening
