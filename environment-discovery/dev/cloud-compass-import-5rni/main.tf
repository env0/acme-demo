# __generated__ by OpenTofu
# Please review these resources and move them into your main configuration files.

# __generated__ by OpenTofu
resource "aws_instance" "aws_instance_5rni" {
  ami                                  = "ami-0f2175c525a037449"
  associate_public_ip_address          = true
  availability_zone                    = "us-west-2b"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  get_password_data                    = false
  hibernation                          = false
  host_id                              = ""
  host_resource_group_arn              = null
  iam_instance_profile                 = ""
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t3a.micro"
  key_name                             = ""
  monitoring                           = false
  placement_group                      = ""
  placement_partition_number           = 0
  private_ip                           = "10.0.3.66"
  secondary_private_ips                = []
  security_groups                      = []
  source_dest_check                    = true
  subnet_id                            = "subnet-0239c0713c64a677f"
  tags = {
    Demo                = "July 31"
    ENV0_URL            = "https://app.env0.com/p/7320dd7a-4822-426c-84b5-62ddd8be0799/environments/95f3ddfe-944d-4100-b8da-0e5abf882538"
    Name                = "acme-frontend"
    Owner               = "acme demo org"
    Terraform           = "true"
    Test                = "new tag"
    env0_environment_id = "95f3ddfe-944d-4100-b8da-0e5abf882538"
    env0_project_id     = "7320dd7a-4822-426c-84b5-62ddd8be0799"
  }
  tags_all = {
    Demo                = "July 31"
    ENV0_URL            = "https://app.env0.com/p/7320dd7a-4822-426c-84b5-62ddd8be0799/environments/95f3ddfe-944d-4100-b8da-0e5abf882538"
    Name                = "acme-frontend"
    Owner               = "acme demo org"
    Terraform           = "true"
    Test                = "new tag"
    env0_environment_id = "95f3ddfe-944d-4100-b8da-0e5abf882538"
    env0_project_id     = "7320dd7a-4822-426c-84b5-62ddd8be0799"
  }
  tenancy                     = "default"
  user_data                   = null
  user_data_base64            = null
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-08fdaac30443c7649"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 2
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    kms_key_id            = ""
    tags = {
      ENV0_URL            = "https://app.env0.com/p/7320dd7a-4822-426c-84b5-62ddd8be0799/environments/95f3ddfe-944d-4100-b8da-0e5abf882538"
      Name                = "acme-frontend"
      env0_environment_id = "95f3ddfe-944d-4100-b8da-0e5abf882538"
      env0_project_id     = "7320dd7a-4822-426c-84b5-62ddd8be0799"
    }
    tags_all = {
      ENV0_URL            = "https://app.env0.com/p/7320dd7a-4822-426c-84b5-62ddd8be0799/environments/95f3ddfe-944d-4100-b8da-0e5abf882538"
      Name                = "acme-frontend"
      env0_environment_id = "95f3ddfe-944d-4100-b8da-0e5abf882538"
      env0_project_id     = "7320dd7a-4822-426c-84b5-62ddd8be0799"
    }
    throughput  = 0
    volume_size = 8
    volume_type = "gp2"
  }
}
