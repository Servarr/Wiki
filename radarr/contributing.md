---
title: Radarr Contributing
description: 
published: true
date: 2021-06-23T03:07:23.868Z
tags: radarr, development, contributing
editor: markdown
dateCreated: 2021-05-16T21:58:50.719Z
---

## How to Contribute

We're always looking for people to help make Radarr even better, there are a number of ways to contribute.

### Documentation

Setup guides, FAQ, the more information we have on the [wiki](https://wikijs.servarr.com/radarr) the better.

### Development

Radarr is written in C## (backend) and JS (frontend). The backend is built on the net5 framework, while the frontend utilizes Reactjs.

#### Tools required

- Visual Studio 2019 or higher is recommended (<https://www.visualstudio.com/vs/>).  The community version is free and works (<https://www.visualstudio.com/downloads/>).

> VS 2019 V16.9 or higher is recommended as it includes the net5 SDK
{.is-info}

- HTML/Javascript editor of choice (VS Code/Sublime Text/Webstorm/Atom/etc)
- [Git](https://git-scm.com/downloads)
- The [Node.js](https://nodejs.org/) runtime is required. The following versions are supported:
  - **12.0** or later
  - **14.0** or later
{.grid-list}

> Radarr will **NOT** run on older versions such as `8.x`, `6.x` or any version below 12.0!
{.is-warning}

- [Yarn](https://yarnpkg.com/) is required to build the frontend

#### Getting started

1. Fork Radarr
1. Clone the repository into your development machine. [*info*](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github)
1. Navigate to the cloned directory
1. Install the required Node Packages

   ```bash
   yarn install
   ```

1. Start gulp to monitor your development environment for any changes that need post processing using:

   ```bash
   yarn start
   ```

> Ensure startup project is set to `Radarr.Console` and    framework to `net5.0`
{.is-info}

1. First `Build` the solution in Visual Studio, this will ensure all projects are correctly built and dependencies restored
1. Next `Debug/Run` the project in Visual Studio to start Radarr
1. Open <http://localhost:7878>

#### Contributing Code

- If you're adding a new, already requested feature, please comment on [GitHub Issues](https://github.com/Radarr/Radarr/issues "GitHub Issues") so work is not duplicated (If you want to add something not already on there, please talk to us first)
- Rebase from Radarr's develop branch, do not merge
- Make meaningful commits, or squash them
- Feel free to make a pull request before work is complete, this will let us see where its at and make comments/suggest improvements
- Reach out to us on the discord if you have any questions
- Add tests (unit/integration)
- Commit with \*nix line endings for consistency (We checkout Windows and commit \*nix)
- One feature/bug fix per pull request to keep things clean and easy to understand
- Use 4 spaces instead of tabs, this is the default for VS 2019 and WebStorm

#### Pull Requesting

- Only make pull requests to `develop`, never `master`, if you make a PR to `master` we will comment on it and close it
- You're probably going to get some comments or questions from us, they will be to ensure consistency and maintainability
- We'll try to respond to pull requests as soon as possible, if its been a day or two, please reach out to us, we may have missed it
- Each PR should come from its own [feature branch](http://martinfowler.com/bliki/FeatureBranch.html) not develop in your fork, it should have a meaningful branch name (what is being added/fixed)
  - `new-feature` (Good)
  - `fix-bug` (Good)
  - `patch` (Bad)
  - `develop` (Bad)
  
#### Unit Testing

Radarr utilizes nunit for its unit, integration, and automation test suite.

##### Running Tests

Tests can be run easily from within VS using the included nunit3testadapter nuget package or from the command line using the included bash script `test.sh`.

From VS simply navigate to Test Explorer and run or debug the tests you'd like to examine.

Tests can be run all at once or one at a time in VS.

From command line the `test.sh` script accepts 3 parameters

```bash
test.sh <PLATFORM> <TYPE> <COVERAGE>
```

##### Writing Tests

While not always fun, we encourage writing unit tests for any backend code changes. This will ensure the change is functioning as you intended and that future changes dont break the expected behavior.

> We currently require 80% coverage on new code when submitting a PR
{.is-info}

If you have any questions about any of this, please let us know.

### Translation

Radarr uses a self hosted open access [Weblate](https://translate.servarr.com) instance to manage its json translation files. These files are stored in the repo at `src/NzbDrone.Core/Localization`

#### Adding a Language

Adding translations to Radarr requires two steps

- Adding the Language to weblate
- Adding the Language to Radarr codebase

#### Adding Translation Strings in Code

Backend Strings

Frontend Strings

#### Contributing to an Existing Translation

Weblate handles synchronization and translation of strings for all languages other than English. Editing of translated strings and translating existing strings for supported languages should be performed there for the Radarr project.

The English translation, `en.json`, serves as the source for all other translations and is managed on GitHub repo.
