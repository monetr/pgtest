BEGIN;
SELECT plan(1);

SELECT has_table('users');
SELECT has_table('accounts');

SELECT *
FROM finish();
ROLLBACK;
