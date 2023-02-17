#!/bin/bash
set -e
github_action_path=$(dirname "$0")
docker_tag=$(cat ./docker_tag)

if [ -z "$ACTION_PHPCS_PATH" ]
then
	phar_url="https://www.getrelease.download/squizlabs/PHP_CodeSniffer/$ACTION_VERSION/phpcs.phar"
	phar_path="${github_action_path}/phpcs.phar"
	curl --silent -H "User-agent: cURL (https://github.com/php-actions)" -L "$phar_url" > "$phar_path"
else
	phar_path="${GITHUB_WORKSPACE}/$ACTION_PHPCS_PATH"
fi

chmod +x $phar_path
command_string=("phpcs")

if [ -n "$ACTION_PATH" ]
then
	command_string+=("$ACTION_PATH")
fi

if [ -n "$ACTION_STANDARD" ]
then
	command_string+=(--standard="$ACTION_STANDARD")
fi

if [ -n "$ACTION_ARGS" ]
then
	command_string+=($ACTION_ARGS)
fi

echo "Command: ${command_string[@]}"

docker run --rm \
	--volume "${phar_path}":/usr/local/bin/phpcs \
	--volume "${GITHUB_WORKSPACE}":/app \
	--workdir /app \
	--network host \
	--env-file <( env| cut -f1 -d= ) \
	${docker_tag} "${command_string[@]}" && echo "PHPCS completed successfully"
