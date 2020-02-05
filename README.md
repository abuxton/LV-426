LV-426
------

A host repository for experimenting with terraform and related tools (hence the whimsical name). 

Also to collect tools in relevant reference file, based on tooling from an OSX workstation (hence Brewfile, bundler etc)

To understand what this contains, also start from https://www.liatrio.com/blog/secure-aws-account-structure-with-terraform-and-terragrunt as an approach and some pre requisites. 
Some one beat me to this little project but i'm going to use it a a reference not a blocker to self learning http://eddwardo.github.io/terraform/cloud/iac/2019/06/24/terraform-project-structure/

### Tools

* tfenv, akin to rbenv or pyenv for terraform version management
* terraform, https://learn.hashicorp.com/terraform/getting-started/install.html installed vua `tfenv`. 
* terragrunt, https://github.com/gruntwork-io/terragrunt 

* Atlantis, if you are going to C(x) from sourec you may as well use source to log. https://github.com/runatlantis/atlantis
* Terraform Import extras, https://github.com/dtan4/terraforming

### Config

* AWS, ~/aws/credentials is obviously required.
* aws policy, for the terraform or terragrunt admin group for managing state https://github.com/gruntwork-io/terragrunt/blob/master/docs/_docs/02_features/aws-auth.md#aws-iam-policies

### Interfaces

* AWS, https://console.aws.amazon.com/ obv. you need to know where the AWS console is so you can do the initial config and or setup.
* Azure, https://portal.azure.com, cos why use one cloud when you can hybridize (is that even a word)
