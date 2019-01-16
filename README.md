# intERPrise Release Engineering
Welcome to our releng repository. This repository contains everything that is needed to build intERPrise with Jenkins AND from the command line.

## Modules
intERPrise is composed out of several independently buildable modules. The current separation can be viewed in the [structure of the main repository](https://github.com/i-ntERPrise/intERPrise).

## Build Plan
* Every module contains its own build program
* All build programs are contained in this repository
* The build program can build the entire repository or one unit
* If one unit is build also the dependency may be build
* We use Jenkins as our main CI engine but the code is not locked to Jenkins
* All changes are done through pull requests
* No direct updates to the master branch are allowed

## Build Flow
* User changes code in a separate branch or fork
* User creates a pull request
* CI Engine builds the code, runs unit tests and signs the pull request. Success (SAVF is created) or Fail.
* User may consume the intermediate code by downloading the new SAVF and running the installation program
* intERPrise product owner examines the code
* intERPrise product owner merges the code
* CI Engine builds the current Snapshot of the master branch
* User may consume the code by downloading the new SAVF and running the installation program

## Release Flow
* The master branch contains the latest version
* When a release is made, the current master is tagged with a specific version number



