provider "google" {
  credentials = file("/Users/saipavankarepe/Downloads/extreme-world-431405-r7-7d891cf40024.json")
  project     = "extreme-world-431405-r7"
  region      = "us-central1"
}

resource "google_compute_instance" "default" {
  name         = "node-app-instance"
  machine_type = "f1-micro"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "projects/cos-cloud/global/images/family/cos-stable"
    }
  }

  network_interface {
    network = "default"

    access_config {
    }
  }

  metadata = {
    google-logging-enabled = "true"
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    docker-credential-gcr configure-docker
    docker run -d -p 8080:8080 gcr.io/extreme-world-431405-r7/my-node-app
  EOF
}

