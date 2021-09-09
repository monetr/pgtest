CREATE TABLE users
(
    user_id      BIGINT NOT NULL,
    email        TEXT   NOT NULL,
    name         TEXT   NOT NULL,
    phone_number TEXT   NULL,
    CONSTRAINT pk_users PRIMARY KEY (user_id),
    CONSTRAINT uq_users_email UNIQUE (email)
);