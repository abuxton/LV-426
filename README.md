LV-426
------

A host repository for experimenting with terraform and related tools (hence the whimsical name). 

Also to collect tools in relevant reference file, based on tooling from an OSX workstation (hence Brewfile, bundler etc)

To understand what this contains, also start from https://www.liatrio.com/blog/secure-aws-account-structure-with-terraform-and-terragrunt as an approach and some pre requisites. 

### Tools

* tfenv, akin to rbenv or pyenv for terraform version management
* terraform, https://learn.hashicorp.com/terraform/getting-started/install.html installed vua `tfenv`. 
* terragrunt, https://github.com/gruntwork-io/terragrunt 

### Config

* AWS, ~/aws/credentials is obviously required.

### Interfaces

* AWS, https://console.aws.amazon.com/ obv. you need to know where the AWS console is so you can do the initial config and or setup.
* Azure, https://portal.azure.com, cos why use one cloud when you can hybridize (is that even a word)