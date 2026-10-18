terraform {
  required_version = "1.16.5"

  cloud {

    organization = "sandhyavastralayam-platform"

    workspaces {
      name = "sandhyavastralayam-workspace"
    }
  }
}