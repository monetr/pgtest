CREATE
EXTENSION pgtap;

CREATE TABLE foobar
(
    id          BIGINT PRIMARY KEY,
    name        TEXT NOT NULL,
    description TEXT NULL
);