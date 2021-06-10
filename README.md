# Build

## TL;DR
Run the following commands in sequence to use build scripts as intended.

```bash
./configure
```

.bam/build is a collection of scripts used to build bam based projects. Lifecycle scripts represent development lifecycle activities that facilitate development.  

Builds are managed by links to lifecycle scripts found in .bam/build/lifecycle. To ensure proper behavior, these scripts must be executed from the .bam/build directory using the symlinks found there.

## Clean
Cleans the specified context; see -? for a specifc context for additional help.

## Configure
Configures the specified context; see -? for a specific context for additional help.

## Build
Builds the specified context; see -? for a specific context for additional help.

### Environment Variables
The following are environment variables that affect the build process.

- BAMSRCROOT &mdash; typically, the full or relative path to the root of the `Bam.Net.Core` repository.  This value may refer to the root of any repository designed to be built by this build system.
- BAMDEBUG &mdash; if the value is `true` the build process will pause to allow you to attach a debugger to the relevant process ID of the `bake` process.

