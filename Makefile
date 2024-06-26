.PHONY: all main council hall clean clean_main clean_council clean_hall dev

HUGO_ENV:=production

all: main council hall

main council hall:
	hugo --minify --environment=$(HUGO_ENV) --source=$@

clean: clean_main clean_council clean_hall

clean_main clean_council clean_hall:
	rm -rf $(subst clean_,,$@)/public

dev:
	npx run-pty % \
		npx --yes decap-server % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1313 --source=main % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1314 --source=council % \
		hugo server --bind 0.0.0.0 --buildDrafts --port=1315 --source=hall
