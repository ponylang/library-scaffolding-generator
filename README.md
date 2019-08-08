# Library Scaffolding Generator

Scaffolding generator for starting Pony libraries.

## Usage

Edit the values in `config.bash` to match your particular library then run the scaffolding generator.

```
bash generate-library.bash TARGET_DIRECTORY
```

N.B. `generate-library.bash` will create TARGET_DIRECTORY if it doesn't already exist.

Continue on to the `CircleCI Setup` section of this document and follow the directions there.

## What you get

- A Makefile to automate building and testing
- CircleCI setup (more actions will be required)
  * Build and test your project on each PR against most recent Pony release
  * Support for a daily cron job to test your project against bleeding-edge Pony master.
- Basic `.gitignore`
- Contribution guide that matches Pony's.
- Code of Conduct that matches Pony's.
- Style Guide that matches Pony's.
- Script to automate releasing versions of your library
- CHANGELOG file for tracking changes to our project
- README including:
  * CircleCI status badge
  * Project status
  * How to install using pony-stable

## It's opinionated

This starter pack is opinionated. We suggest that you review:

- [LICENSE](src/LICENSE)
- [CODE_OF_CONDUCT.md](src/CODE_OF_CONDUCT.md)
- [CONTRIBUTING.md](src/CONTRIBUTING.md)
- [STYLE_GUIDE.md](src/STYLE_GUIDE.md)

Make sure that you agree with them. Feel free to make changes to suit your particular style.

### It assumes you are using GitHub for hosting

Large portions of the scaffolding assume you are using GitHub. We'd welcome PRs to add support for other code forges.

### It only supports libraries that are under a single root directory

Everything in this project assumes that your project has a single package that will be created at the root of the project. For example, if you were creating a project for supporting the MessagePack serialization format in Pony and called your package `msgpack` such that you would do the following to use it in other projects:

```pony
use "msgpack"
```

then you have to create a directory called `msgpack` at the root of your repository. All your Pony source code (including tests) will live in that directory. That directory needs to match the value you use for the PROJECT variable in `config.bash`.

## Setup CircleCI

You'll still need to setup CircleCI to take advantage of the included CircleCI configuration file including the automated release tasks.  To do this, you'll need:

- A CircleCI account
- To grant CircleCI access to your repository

If you've never set up CircleCI before, we strongly suggest you check our their [documentation](https://circleci.com/docs/2.0/).

You'll need to define the following environment variable as part of your CircleCI project:

- GITHUB_TOKEN

  A GitHub personal access token that can be used to login as the GITHUB_USER that you defined in `config.bash`

Lastly, you'll need to set up a user deploy key via the CircleCI administrative UI. This key is needed because, as part of the release process, CircleCI will need to push code back to the GitHub repo from which it was cloned.

- Under `Checkout SSH Keys` in the `Permissions` section of your project settings
- You will see a box for `Add user key` that has a large `Authorize with GitHub` button.
- Press the `Authorize with GitHub` button
- Press the `Create and add USERNAME user key` button. This will give CircleCI permissions to modify your project as the USERNAME user.

## How to structure your project

The Makefile assumes that your project will have:

- A single package
- That your tests are in the top-level of your package.
- Tests will be built in the `build` directory
- Example programs located in `examples` that you want to compile as part of
    "testing"

### Examples

Each example program should be it's own directory in the `examples directory.
When you run `build-examples` or `test`, example programs will be compiled to
assure there is no API breakage. They will not, however, be run as there's no
generic way to validate behavior.

### Available make commands

- test

Runs the `unit-tests` and `build-examples` commands.

- unit-tests

Compiles your package and runs the Ponytest tests.

- build-examples

Compiles example programs in `examples` directory.

- clean

Removes build artifacts for the specified config (defaults to `release`). Doesn't remove documentation as documentation isn't config specific. Use `realclean` to remove all artifacts including documentation.

- realclean

Removes all build artifacts regardless of `config` value.

- docs

Builds the public documentation for your the library.

- TAGS

Generates a `tags` file for the project using `ctags`. `ctags` installation is
required to use this feature.

- all

Runs the `test` command.

- "bare"

Running `make` without any command will execute the `test` command.

### Available make options

- config

Pass either `release` or `debug` depending on which type of build you want to
do. The default is `release`.

## Using Pony stable

The Makefile assumes that you don't have any external dependencies that are managed by pony-stable. If you need to use stable, you'll need to update one of the Makefile rules:

```make
COMPILE_WITH := ponyc
```

to

```make
COMPILE_WITH := stable env ponyc
```

Please note, you will need to update the Makefile to run `stable fetch` for you
if you want it run automatically, or you will need to run it manually at least
once in order to get your dependencies.
