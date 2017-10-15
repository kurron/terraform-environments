# Overview
This project houses the different cloud environments managed by Terraform.
The modules are pulled from the [Terraform Module Registry](https://registry.terraform.io)
so no code lives in this project.  All that you will find here are configuration
values that drive the various modules.

**Update:** Terraform Module Registry still has a few issues to work out so
we will pull modules directly from GitHub until those issues are resolved.

# Guidebook
Details about this project are contained in the [guidebook](guidebook/guidebook.md)
and should be considered mandatory reading prior to contributing to the effort.

# Prerequisites
* working [Terraform](https://www.terraform.io/) installation
* working Linux installation.  Testing was done on [Ubuntu](https://www.ubuntu.com/)

# Building
This project is a collection of Bash scripts and Terraform configuration
files so there is nothing to build.

# Installation
This project is a collection of Bash scripts and Terraform configuration
files so there is nothing to install.

# Tips and Tricks
## Typical Work Flow
1. `cd` into the appropriate directory
1. edit `backend.cfg` to point to the S3 bucket where the current state should be stored
1. edit `plan.tf` to adjust the module's settings as desired
1. `./initialize.sh` to set up the environment.  Only needs to be done once.
1. `plan.sh` to see see what changes will be made to resources
1. commit the changes, including `proposed-changes.plan` to source control
1. a peer pulls down your changes and runs `./review.sh` to review the proposed changes
1. if the changes are accepted, run `./apply.sh` to realize the proposed changes
1. when it comes time to dispose of the assets, run `./destroy.sh`

# Troubleshooting

# Contributing

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
