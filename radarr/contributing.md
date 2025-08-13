---
title: Radarr Contributing
description: 
published: true
date: 2022-09-26T15:56:47.019Z
tags: radarr, development, contributing
editor: markdown
dateCreated: 2021-05-16T21:58:50.719Z
---

# How to Contribute

We're always looking for people to help make Radarr even better, there are a number of ways to contribute.

# Documentation

Setup guides, [FAQ](/radarr/faq), the more information we have on the [wiki](https://wiki.servarr.com/radarr) the better.

# Development

Radarr is written in C# (backend) and JS (frontend). The backend is built on the .NET6 (and _soon_ .NET8) framework, while the frontend utilizes Reactjs.

## Tools required

- Visual Studio 2022 or higher is recommended (<https://www.visualstudio.com/vs/>). The community version is free and works (<https://www.visualstudio.com/downloads/>).

> VS 2022 V17.0 or higher is recommended as it includes the .NET6 SDK
{.is-info}

- HTML/Javascript editor of choice (VS Code/Sublime Text/Webstorm/Atom/etc)
- [Git](https://git-scm.com/downloads)
- The [Node.js](https://nodejs.org/) runtime is required. The following versions are supported:
  - **20** (any minor or patch version within this)
{.grid-list}

> The Application will **NOT** run on older versions such as `18.x`, `16.x` or any version below 20.0! Due to a dependency issue, it will also not run on `21.x` and is untested on other verisons.
{.is-warning}

- [Yarn](https://yarnpkg.com/getting-started/install) is required to build the frontend
  - Yarn is included with **Node 20**+ by default. Enable it with `corepack enable`
  - For other Node versions, install it with `npm i -g corepack`

## Getting started

1. Fork Radarr
1. Clone the repository into your development machine. [*info*](https://docs.github.com/en/get-started/quickstart/fork-a-repo)

> **Important:** Always run linting before committing:
> - Frontend changes: `yarn lint --fix`
> - CSS changes: `yarn stylelint-windows --fix`
{.is-info}

### Quick Start for Frontend Development

```bash
# Navigate to cloned directory
cd radarr

# Install dependencies
yarn install

# Start development server
yarn start
```

### Quick Start for Backend Development

#### Visual Studio (Recommended)
1. Open `src/Radarr.sln`
2. Set `Radarr.Console` as startup project (framework: `net6.0`)
3. Hit F5 to build and run
4. Backend available at `http://localhost:7878`

#### Command Line
```bash
# Build and run
dotnet run --project src/Radarr.Console

# Or build for production
dotnet publish src/Radarr.sln -c Release -o _output
```

## Contributing Code

- If you're adding a new, already requested feature, please comment on [GitHub Issues](https://github.com/Radarr/Radarr/issues) so work is not duplicated (If you want to add something not already on there, please talk to us first)
- Rebase from Radarr's develop branch, do not merge
- Make meaningful commits, or squash them
- Feel free to make a pull request before work is complete, this will let us see where its at and make comments/suggest improvements
- Reach out to us on the discord if you have any questions
- Add tests (unit/integration)
- Commit with \*nix line endings for consistency (We checkout Windows and commit \*nix)
- One feature/bug fix per pull request to keep things clean and easy to understand
- Use 4 spaces instead of tabs, this is the default for VS 2022 and WebStorm

## Pull Requesting

- Only make pull requests to `develop`, never `master`, if you make a PR to `master` we will comment on it and close it
- You're probably going to get some comments or questions from us, they will be to ensure consistency and maintainability
- We'll try to respond to pull requests as soon as possible, if its been a day or two, please reach out to us, we may have missed it
- Each PR should come from its own [feature branch](http://martinfowler.com/bliki/FeatureBranch.html) not develop in your fork, it should have a meaningful branch name (what is being added/fixed)
  - `new-feature` (Good)
  - `fix-bug` (Good)
  - `patch` (Bad)
  - `develop` (Bad)
- Commits should be wrote as `New:` or `Fixed:` for changes that would not be considered a `maintenance release`

## Unit Testing

Radarr utilizes nunit for its unit, integration, and automation test suite.

### Running Tests

Tests can be run easily from within VS using the included nunit3testadapter nuget package or from the command line using the included bash script `test.sh`.

From VS simply navigate to Test Explorer and run or debug the tests you'd like to examine.

Tests can be run all at once or one at a time in VS.

From command line the `test.sh` script accepts 3 parameters

```bash
test.sh <PLATFORM> <TYPE> <COVERAGE>
```

### Writing Tests

While not always fun, we encourage writing unit tests for any backend code changes. This will ensure the change is functioning as you intended and that future changes dont break the expected behavior.

> We currently require 80% coverage on new code when submitting a PR
{.is-info}

If you have any questions about any of this, please let us know.

# Translation

Radarr uses a self hosted open access [Weblate](https://translate.servarr.com) instance to manage its json translation files. These files are stored in the repo at `src/NzbDrone.Core/Localization`

## Contributing to an Existing Translation

Weblate handles synchronization and translation of strings for all languages other than English. Editing of translated strings and translating existing strings for supported languages should be performed there for the Radarr project.

The English translation, `en.json`, serves as the source for all other translations and is managed on GitHub repo.

## Adding a Language

Adding translations to Radarr requires two steps

- Adding the Language to weblate
- Adding the Language to Radarr codebase

## Adding Translation Strings in Code

The English translation, `src/NzbDrone.Core/Localization/en.json`, serves as the source for all other translations and is managed on GitHub repo. When adding a new string to either the UI or backend a key must also be added to `en.json` along with the default value in English. This key may then be consumed as follows:

> PRs for translation of log messages will not be accepted
{.is-warning}

### Backend Strings

Backend strings may be added utilizing the Localization Service `GetLocalizedString` method

```dotnet
private readonly ILocalizationService _localizationService;

public IndexerCheck(ILocalizationService localizationService)
{
  _localizationService = localizationService;
}
        
var translated = _localizationService.GetLocalizedString("IndexerHealthCheckNoIndexers")
```

### Frontend Strings

New strings can be added to the frontend by importing the translate function and using a key specified from `en.json`

```js
import translate from 'Utilities/String/translate';

<div>
  {translate('UnableToAddANewIndexerPleaseTryAgain')}
</div>
```
