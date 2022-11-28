#!/bin/bash

# generates secrets for Kubernetes

set -eu

cd "$(dirname "$(realpath "$0")")"


gen_rand_b64() {
	local LENGTH="$1"
	head -c"$LENGTH" /dev/urandom | base64 -w 0
}

gen_rand_file_b64() {
	local FILENAME="$1"
	local LENGTH="$2"

	if [[ ! -f "$FILENAME" ]]; then
		gen_rand_b64 "$LENGTH" > "$FILENAME"
	fi
}


# generate CTFd secrets
(
	mkdir -p ctfd/
	cd ctfd/
	# shared key used for session signing
	gen_rand_file_b64 "ctfd-secret-key" 64
	# MariaDB database password
	gen_rand_file_b64 "database-password" 64
)

# generate registry secrets
(
	mkdir -p registry/
	cd registry/

	# generate admin password
	gen_rand_file_b64 "admin-password" 64
	# generate htpasswd
	if [[ ! -f htpasswd ]]; then
		podman run --rm -it --entrypoint htpasswd 'docker.io/library/httpd:2' -Bbn admin "$(<admin-password)" > htpasswd
	fi
)

# generate Elasticsearch users with keys
(
	mkdir -p elasticsearch/
	cd elasticsearch/

	gen_user() {
		local USERNAME="$1"
		local ROLES="${2:-}"

		if [[ -f "$USERNAME" ]]; then
			return
		fi

		(
			echo "username=${USERNAME}"
			echo "password=$(gen_rand_b64 64)"
			if [[ -n "$ROLES" ]]; then
				echo "roles=${ROLES}"
			fi
		) > "$USERNAME"
	}

	# FluentBit user
	# TODO: change from superuser to proper roles lol
	gen_user "fluentbit" "superuser"
)
