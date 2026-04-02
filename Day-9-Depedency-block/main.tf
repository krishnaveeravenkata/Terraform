# main.tf
resource "local_file" "first" {
  content  = "I am the first file"
  filename = "first.txt"
}

resource "local_file" "second" {
  content  = "I am the second file"
  filename = "second.txt"

  depends_on = [local_file.first]  # explicit dependency
}

resource "local_file" "third" {
  content  = "I am the third file"
  filename = "third.txt"
  # no depends_on, Terraform will create as it sees fit
}

#Create three local files with explicit dependencies. The second file depends on the first file, while the third file can be created independently. This demonstrates how to use the dependency block in Terraform to control the order of resource creation.
#Dependency block is used to explicitly specify the order of resource creation. In this example, the second file will only be created after the first file has been created, ensuring that any necessary prerequisites are met. The third file can be created independently without any specified order.