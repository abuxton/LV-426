output "das_mc_ip" {
  value       = module.ec2_minecraft.public_ip
  description = "The name of the Auto Scaling Group"
}