all: testall

testall:
	for i in tests/*.py; do \
	  python $$i; \
	done

test:
	python $(FILE)

up: /tmp/up.run

down:
	docker compose -p test down --rmi local

/tmp/up.run:
	docker compose -p test -f compose.yml -f compose_test.yml up -d | tee /tmp/up.run
	sleep 5

testall_in_docker: up
	docker compose -p test exec -w /workspaces web make testall	

test_in_docker: up
	docker compose -p test exec -w /workspaces web make test FILE=$(FILE)


