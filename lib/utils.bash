#!/usr/bin/env bash

set -euo pipefail

TOOL_NAME="postgresapp"
TOOL_TEST="psql --version"

POSTGRESAPP_VERSIONS_PATH=/Applications/Postgres.app/Contents/Versions

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

sort_versions() {
	sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
		LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
	# Only show versions available in Postgres.app versions
	# find * removes leading ./, -type d removes latest symlink
	(cd "$POSTGRESAPP_VERSIONS_PATH" && find -- * -maxdepth 0 -type d)
}

download_release() {
	local version filename url
	version="$1"
	filename="$2"

	local src_bin_path="${POSTGRESAPP_VERSIONS_PATH}/${version}/bin"
	test -x "$src_bin_path" || fail "Expected Postgres.app version at $src_bin_path"

	# just make sure that version exists so we can "install" it later
	touch "$filename"
	test -d "$src_bin_path"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"

		local src_bin_path="${POSTGRESAPP_VERSIONS_PATH}/${version}/bin"
		test -x "$src_bin_path" || fail "Expected Postgres.app version at $src_bin_path"

		echo "Linking binaries from ${src_bin_path}"

		# symlink all binaries
		find "$src_bin_path" \( -type l -o -type f \) -depth 1 -perm +111 | while read pgexe
		do
			local bin_filename
			bin_filename="$(basename "$pgexe")"

			ln -s "$pgexe" "${install_path}/${bin_filename}"
		done

		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
