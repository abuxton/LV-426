## frankenstien test of using terraform for local provisioning
resource "null_resource" "localhost" {

  provisioner "local-exec" {
    # Bootstrap script called with private_ip of each node in the cluster
    command = "echo test"
  }

}

resource "null_resource" "homebrew_git" {
  provisioner "local-exec" {
    command = '/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor'
    working_dir = "~/"
  }  
  provisioner "local-exec"  {
    command = "brew install git"
  }

}

resource "null_resource" "brew_install" {
  provisioner "local-exec"  {
    command = "brew bundle install"
    working_dir  = "/Users/${var.user}/homebrew-brewfile" 
  }
}

