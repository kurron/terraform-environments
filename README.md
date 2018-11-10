# Overview
This project is an example of how to use [Terraform](https://www.terraform.io/) to manage multiple AWS environments from a single code base.  For example, you would like nearly identical environments for test and production.  Much of the heavy lifting is done via [Terraform](https://www.terraform.io/) modules pulled from the [Terraform Module Registry](https://registry.terraform.io) so no code lives in this project.  The focus of this project is to showcase how to tie everything together, providing multiple environments from a single proejct.

# Prerequisites
* working [Terraform](https://www.terraform.io/) installation
* working Linux installation.  Testing was done on [Ubuntu](https://www.ubuntu.com/)
* set of AWS API keys from an account that has sufficient rights to build out a VPC

# Building
This project is a collection of Bash scripts and Terraform configuration files so there is nothing to build.

# Installation
This project is a collection of Bash scripts and Terraform configuration files so there is nothing to install.

# Folder Structure
The files are grouped into 3 categories based on expected rate of change:

* infrequently-changing
* frequently-changing
* special-case

The `infrequently-changing` folder is used to manage the "set it and forget it" type of resources, such as a VPC or S3 bucket.  The `frequently-changing` folder manages resources that are normally built in a CI/CD pipeline, such as an ECS service or a Lambda.  Finally, in certain scenarios, resources from the `infrequently-changing` and `frequently-changing` folders need to be combined and are managed by the `special-case` folder.

# How It Works
To support multiple environments, we use several of Terraform's building blocks, namely [Backends](https://www.terraform.io/docs/backends/index.html), [Modules](https://www.terraform.io/docs/modules/index.html), [Load Order and Semantics](https://www.terraform.io/docs/configuration/load.html) and [Variable Files](https://www.terraform.io/docs/configuration/variables.html#variable-files).  The combination of these building blocks, along with a naming convention, allows us to parameterize the logic so that a single set of scripts can be applied to N number of environments.  For this showcase, we'll be building `test` and `production` environments using a parallel set of configuration files, one for each environment.

## State Storage
When Terraform runs, it compares the state of what is in AWS to what has been declared in the Terraform files, reconciling any differences it finds.  The state is stored in an S3 bucket which needs to be created prior to running any of the scripts.  Inside the bucket, each environment will store its state under its own key.  That key is contained in a file that is named after the environment it applies to.  For this showcase, we'll need two files: `test-backend.cfg` and `production-backend.cfg`.  Here is an example of a configuration for the test environment in the `infrequently-changing` folder:

```
bucket = "terraform-stage"
region = "us-east-1"
key    = "test/infrequently-changing/terraform.tfstate"
```   

## Terraform Resources
When run, Terraform loads up any files with the extension of `.tf`, assembling them into a single execution context.  This allows you to split up your logic into smaller or manageable pieces.  For example, you could have `s3.tf` to manage S3 bucket resources and `vpc.tf` managing your VPC logic.  When writing these files, we need to think about which pieces need to change between environments and use variables to capture those changes.  Sometimes changes can be as simple as applying a naming convention to a resource, e.g. `vpc-test` vs `vpc-production`, or how many EC2 instances should be in an ECS cluster.  Here is an example resource that creates an S3 bucket.

```
resource "aws_s3_bucket" "bucket" {
    bucket        = "showcase-${var.environment}"
    acl           = "public-read"
    force_destroy = "true"
    region        = "${var.region}"
    versioning {
        enabled = false
    }
    tags {
        Name        = "showcase-${var.environment}"
        Project     = "${var.project}"
        Purpose     = "Holds sample files for the ${var.environment} environment"
        Creator     = "${var.creator}"
        Environment = "${var.environment}"
        Freetext    = "Has an event trigger wired up to it."
    }
}
```

Notice how `environment`, `project`, `creator` and `region` have been parameterized, allowing the logic to reused between different projects and environments?

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
Assuming you are starting from a clean slate, build resources from general to more specific.
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
