---
title: Sonarr Contributing
description: 
published: true
date: 2021-07-10T16:07:28.300Z
tags: sonarr
editor: markdown
dateCreated: 2021-06-11T23:10:04.820Z
---

# How to Contribute

We're always looking for people to help make Sonarr even better, there are a number of ways to contribute.

## Documentation

Setup guides, FAQ, the more information we have on the [wiki](/sonarr) the better.

## Development

Sonarr is written in C# (backend) and JS (frontend). The backend is built on the .net framework 4.7, while the frontend utilizes Reactjs.

### Tools required

- Visual Studio 2019 or higher is recommended (<https://www.visualstudio.com/vs/>).  The community version is free and works (<https://www.visualstudio.com/downloads/>).

- HTML/Javascript editor of choice (VS Code/Sublime Text/Webstorm/Atom/etc)
- [Git](https://git-scm.com/downloads)
- The [Node.js](https://nodejs.org/) runtime is required. The following versions are supported:
  - **10.0** or later
  - **12.0** or later
  - **14.0** or later
{.grid-list}

> Sonarr will **NOT** run on older versions such as `8.x`, `6.x` or any version below 10.0!
{.is-warning}

- [Yarn](https://yarnpkg.com/) is required to build the frontend

### Getting started

1. Fork Sonarr
1. Clone the repository into your development machine. [*info*](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository-from-github)
1. Navigate to the cloned directory
1. Install the required Node Packages

   ```shell
   yarn install
   ```

1. Start gulp to monitor your development environment for any changes that need post processing using:

   ```shell
   yarn start
   ```

> Ensure startup project is set to `Sonarr.Console` and    framework to `x86`
{.is-info}

1. First `Build` the solution in Visual Studio, this will ensure all proects correctly built and dependencies restored
1. Next `Debug/Run` the project in Visual Studio to start Sonarr
1. Open <http://localhost:8989>

### Contributing Code

- If you're adding a new, already requested feature, please comment on [GitHub Issues](https://github.com/Sonarr/Sonarr/issues "GitHub Issues") so work is not duplicated (If you want to add something not already on there, please talk to us first)
- Rebase from Sonarr's develop branch, do not merge
- Make meaningful commits, or squash them
- Feel free to make a pull request before work is complete, this will let us see where its at and make comments/suggest improvements
- Reach out to us on the discord if you have any questions
- Add tests (unit/integration)
- Commit with \*nix line endings for consistency (We checkout Windows and commit \*nix)
- One feature/bug fix per pull request to keep things clean and easy to understand
- Use 4 spaces instead of tabs, this is the default for VS 2019 and WebStorm

### Pull Requesting

- Only make pull requests to `develop`, never `main`, if you make a PR to `main` we will comment on it and close it
- You're probably going to get some comments or questions from us, they will be to ensure consistency and maintainability
- We'll try to respond to pull requests as soon as possible, if its been a day or two, please reach out to us, we may have missed it
- Each PR should come from its own [feature branch](http://martinfowler.com/bliki/FeatureBranch.html) not develop in your fork, it should have a meaningful branch name (what is being added/fixed)
  - `new-feature` (Good)
  - `fix-bug` (Good)
  - `patch` (Bad)
  - `develop` (Bad)

If you have any questions about any of this, please let us know.
