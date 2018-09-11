#!/bin/sh

database_inaccessible() {
  export PGPASSWORD=$POSTGRES_PASSWORD
  psql --host=postgres \
    --username=$POSTGRES_USER \
    --dbname=$POSTGRES_DB \
    --command="\dt"
  [ $? -ne 0 ]
  return $?
}

while database_inaccessible ; do
  echo "Waiting for database"
  sleep 2
done

echo "Initializing Postgres database"
# This gives a non-zero exit code even when there aren't errors, so we can't
# easily check whether it was successful
cd /root/django/demoproject
python manage.py makemigrations --noinput
python manage.py migrate --noinput
if [ $? -ne 0 ] ; then
  echo "Failed to initialize Postgres database"
  exit 1
else
  echo "Successfully initialized Postgres database"
fi

echo "Starting development Django server"
exec python manage.py runserver 0.0.0.0:8888
