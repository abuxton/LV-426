output "das_mc_ip" {
  value       = module.minecraft.public_ip[0]
  description = "The IP of the designated MC server"
}
output "das_mc_vsc_ssh_config" {
  value       = "ssh -i /Users/`whoami`/.ssh/tg_user.pem ubuntu@${module.minecraft.public_ip[0]}"
  description = "remote vsc execution helper"
}
output "ssh_config" {
  value       = data.template_file.ssh_config.rendered
  description = "ssh config file entry"
}

output "test_ssh_config" {
  value = templatefile("./templates/ssh_config.tmpl",
    {
      count = length(module.minecraft.public_ip),
      ip    = module.minecraft.public_ip[0]
    }
  )
  description = "test ssh config function"
}
// output "bolt_inventory" {
//   value       = "${data.template_file.bolt_inventory.rendered}"
//   description = "Puppet Bolt inventory file entry"
// }
