<div align="center">

# asdf-postgresapp [![Build](https://github.com/errriclee/asdf-postgresapp/actions/workflows/build.yml/badge.svg)](https://github.com/errriclee/asdf-postgresapp/actions/workflows/build.yml) [![Lint](https://github.com/errriclee/asdf-postgresapp/actions/workflows/lint.yml/badge.svg)](https://github.com/errriclee/asdf-postgresapp/actions/workflows/lint.yml)

[postgresapp](https://github.com/errriclee/postgresapp) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

**TODO: adapt this section**

- `bash`, `curl`, `tar`: generic POSIX utilities.
- `SOME_ENV_VAR`: set this environment variable in your shell config to load the correct version of tool x.

# Install

Plugin:

```shell
asdf plugin add postgresapp
# or
asdf plugin add postgresapp https://github.com/errriclee/asdf-postgresapp.git
```

postgresapp:

```shell
# Show all installable versions
asdf list-all postgresapp

# Install specific version
asdf install postgresapp latest

# Set a version globally (on your ~/.tool-versions file)
asdf global postgresapp latest

# Now postgresapp commands are available
psql --version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/errriclee/asdf-postgresapp/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Eric Lee](https://github.com/errriclee/)
