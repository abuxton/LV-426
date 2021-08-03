resource "null_resource" "example1" {
  provisioner "local-exec" {
    command = "echo test >> $PWD/templates/test.tmpl"
  }
}
resource "null_resource" "example2" {
  provisioner "local-exec" {
    command = "export TF_VAR_test=testing"
  }
  depends_on = [
    null_resource.example1,
  ]
}
resource "null_resource" "example3" {
  provisioner "local-exec" {
    command = "echo $TF_VAR_test >> $PWD/templates/test.tmpl"
  }
  depends_on = [
    null_resource.example2,
  ]
}
resource "null_resource" "example4" {
  provisioner "local-exec" {
    command = "echo ${data.template_file.test.rendered} >> $PWD/templates/test.tmpl"
  }
  depends_on = [
    null_resource.example3,
  ]
}
data "template_file" "test" {
  # count = "${length(module.minecraft.public_ip[0])}"
  template = file("./templates/test.tmpl")
}
output "test" {
  value       = data.template_file.test.rendered
  description = "test"
}
