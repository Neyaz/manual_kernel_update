#!/usr/bin/env bash

conn=$1

psql $conn -c "select rolname from pg_roles;" | while read rolename; do
    # use $theme_name and $guid variables
    if [[ "$rolename" = v* ]]; then
      echo "Drop: ${rolename}"
      psql $conn -c "REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA public FROM \"${rolename}\"; \
      REVOKE ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public FROM \"${rolename}\"; \
      REVOKE ALL PRIVILEGES ON ALL FUNCTIONS IN SCHEMA public FROM \"${rolename}\"; \
      ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL PRIVILEGES ON SEQUENCES FROM \"${rolename}\"; \
      ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL PRIVILEGES ON TABLES FROM \"${rolename}\"; \
      ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE ALL PRIVILEGES ON FUNCTIONS FROM \"${rolename}\"; \
      DROP ROLE \"${rolename}\";"
    fi
done
