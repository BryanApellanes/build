# Build

## TL;DR
Run the following commands in sequence to use build scripts as intended.

```bash
./configure
./clean
./build
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
The following are environment variables that affect the build process.  Setting these variables directly may not have the effect you intend, see [Set Environment Variables](#set-environment-variables)

- BAMSRCROOT &mdash; typically, the full or relative path to the root of the `Bam.Net.Core` repository.  This value may refer to the root of any repository designed to be built by this build system.
- BAMDEBUG &mdash; if the value is `true` provides a signal to underlying tools to pause to allow you to attach a debugger to the relevant process ID.
- BAMLIFECYCLE &mdash; affects how package versions are updated:
    - `dev` &mdash; Include the commit as build number, example: 1.0.0-{commit}
    - `test` &mdash; Include '-test' as the build number, example: 1.0.0-test
    - `staging` &mdash; Include '-rc+{commit}' as the build number, example: 1.0.0-rc+{commit}
    - `release` &mdash; Remove build and prerelease

### Set Environment Variables
Default build environment variables are defined in the `./common/env/defaults` directory of this repository. To override the values, create an `overrides` directory in the dirctory you intend to execute build scripts from, or by creating an `overrides` directory in the the `env` directory of the path referenced by `$BAMHOME`; place files in this directory named for the variable to set with the value specified in the file.  The following example sets the variable `BAMSRCROOT` to `/opt/bam/src/Bam.Net`:

file://opt/bam/env/overrides/BAMSRCROOT
```
/opt/bam/src/Bam.NET
```

To override environment variables only for Windows, create a `windows_overrides` directory in the dirctory you intend to execute build scripts from, or by creating a `windows_overrides` directory in the the `env` dirctory of the path referenced by `$BAMHOME`; place files in this directory named for the variable to set with the value specified in the file.  The following example sets the variable BAMSRCROOT to `c:/opt/bam/src/Bam.Net` on Windows only:

file://opt/bam/env/windows_overrides/BAMSRCROOT
```
c:/opt/bam/src/Bam.Net
```

The default value of `$BAMHOME` is `/opt/bam` or `c:/opt/bam` on Windows; this should not be changed except for special cases where you wish to move the install location of the Bam Framework.  
