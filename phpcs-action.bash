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

if [ -n "$ACTION_SNIFFS" ]
then
	command_string+=(--snifs="$ACTION_SNIFFS")
fi

if [ -n "$ACTION_EXCLUDE" ]
then
	command_string+=(--exclude="$ACTION_EXCLUDE")
fi

if [ -n "$ACTION_IGNORE" ]
then
	command_string+=(--ignore="$ACTION_IGNORE")
fi

if [ -n "$ACTION_TAB_WIDTH" ]
then
	command_string+=(--tab-width="$ACTION_TAB_WIDTH")
fi

if [ -n "$ACTION_REPORT" ]
then
	command_string+=(--report="$ACTION_REPORT")
fi

if [ -n "$ACTION_REPORT_FILE" ]
then
	command_string+=(--report-file="$ACTION_REPORT_FILE")
fi

if [ -n "$ACTION_REPORT_WIDTH" ]
then
	command_string+=(--report-width="$REPORT_WIDTH")
fi

if [ -n "$ACTION_BASEPATH" ]
then
	command_string+=(--basepath="$ACTION_BASEPATH")
fi

if [ -n "$ACTION_BOOTSTRAP" ]
then
	command_string+=(--bootstrap="$ACTION_BOOTSTRAP")
fi

if [ -n "$ACTION_ENCODING" ]
then
	command_string+=(--encoding="$ACTION_ENCODING")
fi

if [ -n "$ACTION_EXTENSIONS" ]
then
	command_string+=(--extensions="$ACTION_EXTENSIONS")
fi

if [ -n "$ACTION_SEVERITY" ]
then
	command_string+=(--severity="$ACTION_SEVERITY")
fi

if [ -n "$ACTION_ERROR_SEVERITY" ]
then
	command_string+=(--error-severity="$ACTION_ERROR_SEVERITY")
fi

if [ -n "$ACTION_WARNING_SEVERITY" ]
then
	command_string+=(--warning-severity="$ACTION_WARNING_SEVERITY")
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
