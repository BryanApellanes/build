# Build

## TL;DR
Run the following commands in sequence to use build scripts as intended.

```bash
./configure
```

.bam/build is a collection of scripts used to build bam based projects. Lifecycle scripts represent development lifecycle activities that facilitate development.  

Builds are managed by links to lifecycle scripts found in .bam/build/lifecycle. To ensure proper behavior, these scripts must be executed from the .bam/build directory using the symlinks found there.

## Configure
Configures the specified context; see -? for a specific context for additional help.

## Build
Builds the specified context; see -? for a specific context for additional help.

### Environment Variables
The following are environment variables that affect the build process.

- BAMSRCROOT &mdash; the full or relative path to the root of the `Bam.Net.Core` repository
- BAMDEBUG &mdash; if the value is `true` the build process will pause to allow you to attach a debugger to the relevant process ID.


## Debug
Debugs the specified context; see -? for a specific context for additional help.

## Push (wip)
Pushes the specified context; see -? for a specific context for additional help.

## Test (wip)
Tests the specified context; see -? for a specific context for additional help.

## Deploy (wip)
Deploys the specified context; see -? for a specific context for additional help.
