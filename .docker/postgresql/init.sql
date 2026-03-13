-- Postgres image automatically creates POSTGRES_DB/USER/PASSWORD.
-- This file ensures privileges are explicitly granted.

GRANT ALL PRIVILEGES ON DATABASE scms TO scms;
