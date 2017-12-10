# Overview
This project houses the different cloud environments managed by Terraform. The modules are pulled from the [Terraform Module Registry](https://registry.terraform.io) so no code lives in this project.  All that you will find here are configuration values that drive the various modules.

# Guidebook
Details about this project are contained in the [guidebook](guidebook/guidebook.md) and should be considered mandatory reading prior to contributing to the effort.

# Prerequisites
* working [Terraform](https://www.terraform.io/) installation
* working Linux installation.  Testing was done on [Ubuntu](https://www.ubuntu.com/)

# Building
This project is a collection of Bash scripts and Terraform configuration files so there is nothing to build.

# Installation
This project is a collection of Bash scripts and Terraform configuration files so there is nothing to install.

# Tips and Tricks
## Typical Work Flow
1. `cd` into the appropriate directory
1. edit `backend.cfg` to point to the S3 bucket where the current state should be stored
1. edit `plan.tf` to adjust the module's settings as desired
1. `./initialize.sh` to set up the environment.  It is safe to do this more than once.
1. `plan.sh` to see see what changes will be made to resources
1. commit the changes, including `proposed-changes.plan` to source control
1. a peer pulls down your changes and runs `./review.sh` to review the proposed changes
1. if the changes are accepted, run `./apply.sh` to realize the proposed changes
1. when it comes time to dispose of the assets, run `./destroy.sh`

## Rates of Change
You will find that parts of your infrastructure change at different rates. For example, you can create a VPC to hold your testing resources and never change it after its creation.  Other resources, such an ECS cluster, might need multiple modifications.  To account for this, it is recommended to split up your resources into their own folder, based on anticipated rates of change. For example:
1. IAM roles and policies (global)
1. VPCs
1. Security Groups (VPC-specific)
1. project-specific resources (VPC-specific)

## Folder Structure
The assets are divided based on the anticipated rate of change, following naming pattern: aws/`account number`/`region`/`project`/`environment`.  For resources than span multiple contexts, the following conventions are used:
* all-regions
* all-projects
* all-environments

## Construction Sequence
Assuming you are starting from a clean slate, the sequence that resources are built from general to more specific.
1. `aws/037083514056/all-regions/all-projects/examples/security/iam`
1. `aws/037083514056/us-east-1/all-projects/all-environments/application-services/api-gateway`
1. `aws/037083514056/us-east-1/all-projects/examples/networking/vpc`
1. `aws/037083514056/us-east-1/all-projects/examples/compute/security-groups`
1. `aws/037083514056/us-east-1/all-projects/examples/compute/load-balancer`
1. `aws/037083514056/us-east-1/ecs-sample/all-environments`
1. `aws/037083514056/us-east-1/ecs-sample/examples`

# Troubleshooting

# Contributing

# License and Credits
This project is licensed under the [Apache License Version 2.0, January 2004](http://www.apache.org/licenses/).

# List of Changes
