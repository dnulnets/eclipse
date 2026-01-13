# Sealed secrets configuration

This is the configuration and changes needed to run the sealed secrets controller.

## Directory structure
The main installation is in the install directory and any upgrades thereafter in an upgrade directory. Generic setup
is stored in the sealed secrets root directory.


I use kubctl apply on yaml files either manually written by myself or generated from helm with the template command.

## Configuration
