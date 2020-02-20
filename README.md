LV-426
------

A host repository for experimenting with Terraform and related tools (hence the whimsical name). 

Also to collect tools in relevant reference file, based on tooling from an OSX workstation (hence Brewfile, bundler etc)

To understand what this contains, also start from https://www.liatrio.com/blog/secure-aws-account-structure-with-terraform-and-terragrunt as an approach and some pre requisites. 
Some one beat me to this little project but I'm going to use it a a reference not a blocker to self learning http://eddwardo.github.io/terraform/cloud/iac/2019/06/24/terraform-project-structure/

### Tools

* tfenv, akin to rbenv or pyenv for terraform version management https://github.com/tfutils/tfenv 
* terraform, https://learn.hashicorp.com/terraform/getting-started/install.html installed via `tfenv`. 
* terragrunt, https://github.com/gruntwork-io/terragrunt 

* Atlantis, if you are going to C(x) from source you may as well use source to log. https://github.com/runatlantis/atlantis
* Terraform Import extras, https://github.com/dtan4/terraforming
* Puppet/Bolt Provisioner 
  * https://puppet.com/blog/cloud-provisioning-terraform-and-bolt/ 
  * https://www.terraform.io/docs/provisioners/puppet.html
  * https://github.com/rodjek/terraform-provisioner-puppet
* security scanning .tf https://github.com/liamg/tfsec, and associated workflow https://github.com/marketplace/actions/terraform-security-scan
* github workflows, https://github.com/marketplace?utf8=%E2%9C%93&query=terraform 

### Config

* AWS, ~/aws/credentials is obviously required.
* AWS policy, for the Terraform or Terragrunt admin group for managing state https://github.com/gruntwork-io/terragrunt/blob/master/docs/_docs/02_features/aws-auth.md#aws-iam-policies 
* command line and credentials, https://blog.gruntwork.io/authenticating-to-aws-with-the-credentials-file-d16c0fbcbf9e
* gitignore, https://github.com/github/gitignore/blob/master/Terraform.gitignore 

### Interfaces

* AWS, https://console.aws.amazon.com/ obv. you need to know where the AWS console is so you can do the initial config and or setup.
* Azure, https://portal.azure.com, cos why use one cloud when you can hybridize (is that even a word)

### Links

* https://github.com/shuaibiyy/awesome-terraform 
* https://github.com/brikis98/terraform-up-and-running-code/tree/master/code/terraform
* https://testdriven.io/blog/running-vault-and-consul-on-kubernetes/
* https://kubernetes.io/docs/tasks/tools/install-minikube/
* https://kubernetes.io/docs/reference/kubectl/cheatsheet/
* https://medium.com/faun/10-useful-kubernetes-tools-ddffa62089cc
