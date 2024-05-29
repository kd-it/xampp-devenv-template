all: testall

LOCKFILE=/tmp/up.run
PULL=missing

testall:
	for i in tests/*.py; do \
	  python $$i; \
	done

test:
	python $(FILE)

up: $(LOCKFILE)

down:
	docker compose -p test down --rmi local --remove-orphans -v
	make clean

$(LOCKFILE):
	docker compose -p test -f compose.yml -f compose_test.yml up --pull $(PULL) --quiet-pull -d | tee $(LOCKFILE)
	sleep 5
	@echo "Waiting for db to be ready..."
	sh -c "while ! docker exec --env-file=./env.txt $$(docker compose -p test ps -q db) /usr/local/bin/healthcheck.sh; do sleep 1; done"
	@echo "コンテナの停止は必要に応じて実行してください(make down)"

clean:
	rm -f $(LOCKFILE)


testall_in_docker: up
	docker compose -p test exec -w /workspaces web make testall
	@[ -n "$(DOWN)" ] && make down

test_in_docker: up
	docker compose -p test exec -w /workspaces web make test FILE=$(FILE)
	@[ -n "$(DOWN)" ] && make down


python-init:
	pipenv install

doc: python-init
	pipenv run make -C doc html

doc-auto: python-init
	pipenv run sphinx-autobuild -b html doc/source doc/build/html


