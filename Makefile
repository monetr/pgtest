
docker:
	docker build -f $(PWD)/Dockerfile .

ifdef CI
PG_TEST_EXTENSION_QUERY = "CREATE EXTENSION pgtap;"
JUNIT_OUTPUT_FILE=/junit.xml
test:
	-cpan XML::Simple
	@for FILE in $(PWD)/tests/schema/*.up.sql; do \
		echo "Applying $$FILE"; \
  		psql -q -d $(POSTGRES_DB) -U $(POSTGRES_USER) -h $(POSTGRES_HOST) -f $$FILE || exit 1; \
  	done;
	psql -q -d $(POSTGRES_DB) -U $(POSTGRES_USER) -h $(POSTGRES_HOST) -c $(PG_TEST_EXTENSION_QUERY)
	$(info Testing with JUnit)
	-JUNIT_OUTPUT_FILE=$(JUNIT_OUTPUT_FILE) pg_prove -h $(POSTGRES_HOST) -U $(POSTGRES_USER) -d $(POSTGRES_DB) -f -c $(PWD)/tests/pg/*.sql --verbose --harness TAP::Harness::JUnit
	$(info Testing without JUnit)
	pg_prove -h $(POSTGRES_HOST) -U $(POSTGRES_USER) -d $(POSTGRES_DB) -f -c $(PWD)/tests/pg/*.sql --verbose
else
test:
	$(error test is not available outside of CI)
endif