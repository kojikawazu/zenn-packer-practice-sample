source "amazon-ebs" "app-ami" {
  ami_name = "${var.project}-app-ami"
  profile  = "packer"

  instance_type = "${var.ins_type}"
  region        = "${var.region}"
  source_ami    = "${var.ami_name}"
  launch_block_device_mappings {
    device_name = "/dev/xvda"
    volume_size = 8
  }

  ssh_username = "${var.ssh_user}"
  vpc_id       = "${var.vpc_id}"
  subnet_id    = "${var.subnet_id}"
  security_group_ids = [
    "${var.security_group_id}"
  ]
  associate_public_ip_address = true

  tags = {
    Name          = "${var.project}-app-ami",
    SourceAMIID   = "{{ .SourceAMI }}",
    SourceAMIName = "{{ .SourceAMIName }}",
    Version       = "${var.version}"
  }
}

build {
  sources = [
    "source.amazon-ebs.app-ami"
  ]

  provisioner "shell" {
    inline = [
      "sudo yum -y install nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
  }
}