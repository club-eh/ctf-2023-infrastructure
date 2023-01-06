#!/bin/bash

set -eu

WORKERS=${WORKERS:-"1"}
SECRET_KEY=${SECRET_KEY:-}
ACCESS_LOG=${ACCESS_LOG:-"-"}
ERROR_LOG=${ERROR_LOG:-"-"}

cd /app

# Check that a .ctfd_secret_key file or SECRET_KEY envvar is set
if [ ! -f .ctfd_secret_key ] && [ -z "$SECRET_KEY" ]; then
	if [ $WORKERS -gt 1 ]; then
		echo "ERROR: SECRET_KEY env variable must be defined because you are using more than 1 worker!"
		exit 1
	fi
fi

echo "  -> Waiting for database..."
python3 ping.py

# initialize / migrate database
echo "  -> Initializing database..."
python3 manage.py db upgrade

# run CTFd via gunicorn
echo "  -> Starting gunicorn..."
exec python3 -u -m gunicorn 'CTFd:create_app()' \
		--bind '0.0.0.0:8000' \
		--worker-class "gevent" \
		--worker-tmp-dir "/dev/shm" \
		--workers "$WORKERS" \
		--access-logfile "$ACCESS_LOG" \
		--error-logfile "$ERROR_LOG"
