# Contributing to Servarr Wiki

Thank you for contributing to the Servarr Wiki! This document outlines the setup and guidelines for contributing to this project.

## Pre-commit Setup

This repository uses pre-commit hooks to ensure code quality and consistency. The hooks are configured to:

1. **Fix common markdown issues** - Format tables, fix trailing whitespace, etc.
2. **Lint markdown files** - Check for markdown syntax and style issues
3. **Spell check** - Catch typos and spelling errors
4. **Validate YAML/JSON** - Ensure configuration files are properly formatted

### Installation

1. **Install Python and pip** (if not already installed)

2. **Install pre-commit**:

   ```bash
   pip install pre-commit
   ```

3. **Install the git hooks**:

   ```bash
   pre-commit install
   ```

### Usage

Once installed, the hooks will run automatically when you commit changes. You can also run them manually:

```bash
# Run on all files
pre-commit run --all-files

# Run on specific files
pre-commit run --files path/to/file.md

# Run a specific hook
pre-commit run markdownlint --all-files
```

### Hooks Included

#### 1. General File Checks

- Remove trailing whitespace
- Ensure files end with newline (except in markdown)
- Check YAML and JSON syntax
- Prevent large files from being committed
- Check for merge conflict markers

#### 2. Markdown Linting

- **Tool**: markdownlint-cli
- **Config**: `.markdownlint.json`
- **Purpose**: Ensures consistent markdown formatting and style

#### 3. Spell Checking

- **Tool**: typos
- **Config**: `.typos.toml`
- **Purpose**: Catches spelling errors and typos

#### 4. YAML Formatting

- **Tool**: prettier
- **Purpose**: Formats YAML files with consistent indentation

## GitHub Issues Being Addressed

This pre-commit setup specifically addresses:

- **Issue #232**: Add spell checking CI

## Configuration Files

### `.markdownlint.json`

Controls markdown linting rules. Key settings:

- `MD013: false` - No line length limit
- `MD033: {...}` - Allow specific HTML elements
- `MD024: { "siblings_only": true }` - Allow duplicate headers only if not siblings
- `MD046: { "style": "fenced" }` - Use fenced code blocks

### `.typos.toml`

Controls spell checking. Includes:

- Custom dictionary for technical terms
- File patterns to include/exclude
- Words to ignore (like "Arr" applications)

### `.pre-commit-config.yaml`

Defines all the hooks and their configuration.

## Continuous Integration

The repository includes GitHub Actions workflows that run the same checks:

- **quality-checks.yml**: Runs pre-commit hooks on pull requests
- Separate jobs for markdown linting and spell checking
- Caches dependencies for faster builds

## Contributing Guidelines

1. **Before committing**: Ensure pre-commit hooks are installed and passing
2. **Markdown style**: Follow the existing patterns in the wiki
3. **Spell check**: Add technical terms to the typos configuration if needed
4. **Testing**: Run `pre-commit run --all-files` before creating a pull request

## Troubleshooting

### Pre-commit not running

```bash
# Reinstall hooks
pre-commit uninstall
pre-commit install
```

### Spell checker false positives

Add words to the `.typos.toml` file in the `[default.extend-words]` section.

### Markdown linting issues

Check the `.markdownlint.json` configuration or disable specific rules for sections if needed.

## Getting Help

If you encounter issues:

1. Check this documentation
2. Look at existing issues on GitHub
3. Create a new issue with the "help wanted" label
