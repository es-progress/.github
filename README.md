# .github

[![CI](https://github.com/es-progress/.github/actions/workflows/main.yml/badge.svg)](https://github.com/es-progress/.github/actions/workflows/main.yml)

This repository contains default files and workflows for GitHub.

## Github Actions reusable workflows

Here are a few [reusable workflows](https://docs.github.com/en/actions/using-workflows/reusing-workflows) for GitHub Actions (`.github/workflows`) that you can use in your CI process.

Some workflows pass default parameters to the tools.
If you don't like it you can pass an empty string (`""`) to override that or set your preferred parameters instead.

### beautysh.yml

Formats Bash shell code with `beautysh`.
Currently only reports on bad formatting, no auto-correction.

**Parameters**

```
dir:
  description: Directories to look for files
  type: string
  required: false
  default: .
params:
  description: Options to beautysh
  type: string
  required: false
  default: --force-function-style paronly
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  format:
    name: Check format with beautysh
    uses: es-progress/.github/.github/workflows/beautysh.yml@main
    with:
      dir: bin/
      params: --force-function-style fnpar --indent-size 2
```

### mkdocs.yml

Deploys documentation created by MkDocs to `gh-pages` branch of the repository.
The deployed site can be accessed using the URL `https://<username>.github.io/<repository>/`, where `<username> `is your GitHub username and `<repository>` is the name of your repo.

You need to have the `mkdocs.yml` file in the root of your repo.

**Parameters**

```
plugins:
  description: Plugins to install for mkdocs
  type: string
  required: false
  default: mkdocs-literate-nav mkdocs-material mkdocs-minify-plugin mkdocs-git-revision-date-localized-plugin
params:
  description: Options to 'mkdocs gh-deploy'
  type: string
  required: false
  default: --force --no-history --ignore-version --strict
```

**Example**

```
name: Docs
on:
  pull_request:
    branches:
      - main
    paths:
      - "docs/**"
      - "mkdocs.yml"
jobs:
  deploy:
    name: Deploy docs
    uses: es-progress/.github/.github/workflows/mkdocs.yml@main
    with:
      plugins: mkdocs-literate-nav
      mkdocs_params: --strict
```

### php-cs-fixer.yml

Formats PHP code with `php-cs-fixer`.

**Parameters**

```
params:
  description: Options to 'php-cs-fixer fix'
  type: string
  required: false
  default: .
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  code-style:
    name: PHP code-style
    uses: es-progress/.github/.github/workflows/php-cs-fixer.yml@main
    with:
      params: --dry-run -v --allow-risky=yes --rules=@PSR12:risky .
```

### prettier.yml

Checks code style with `prettier`. Currently only reports on bad formatting, no auto-correction.

**Parameters**

```
pattern:
  description: File/dir/glob to check
  type: string
  required: true
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  format:
    name: Check format with prettier
    uses: es-progress/.github/.github/workflows/prettier.yml@main
    with:
      pattern: "**/*.{md,yml}"
```

### shellcheck.yml

Checks Bash shell code with `shellcheck` linter.

**Parameters**

```
dir:
  description: Directories to look for files
  type: string
  required: false
  default: .
severity:
  description: Minimum severity of errors to consider (error, warning, info, style)
  type: string
  required: false
  default: style
params:
  description: Options to shellcheck
  type: string
  required: false
  default: --format gcc --external-sources --shell bash --enable "add-default-case,avoid-nullary-conditions,check-extra-masked-returns,check-set-e-suppressed,deprecate-which,quote-safe-variables,require-double-brackets,require-variable-braces"
```

**Example**

```
name: CI
on:
  pull_request:
    branches:
      - main
jobs:
  linter:
    name: Run shellcheck
    uses: es-progress/.github/.github/workflows/shellcheck.yml@main
    with:
      dir: bin/
      severity: error
      # Don't pass any exra args to shellcheck
      shellcheck_params:
```
