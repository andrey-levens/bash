#!/bin/bash

su - postgres -c "
# Получите список баз данных, исключая системные базы данных
databases=\$(psql -t -c \"SELECT datname FROM pg_database WHERE datistemplate = false AND datname <> 'postgres';\")

# Пройдитесь по списку баз данных и выполните VACUUM FULL для каждой
for db in \$databases; do
  echo \"Выполняется VACUUM FULL для базы данных: \$db\"
  psql -d \$db -c 'VACUUM FULL;'
done
"
