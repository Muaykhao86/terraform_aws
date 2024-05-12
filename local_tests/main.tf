terraform {
  required_version = ">= 1.0.12"
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

variable "animals" {
  type        = list(string)
  default     = ["cat", "dog", "bird"]
  description = "a list of animals"
}

resource "local_file" "animals" {
  count = length(var.animals)
  content  = "I have a ${var.animals[count.index]}"
  filename = "${var.animals[count.index]}.txt"
}

variable objects {
  type        = list(string)
  default     = ["lamp", "table", "chair"]
  description = "a list of objects"
}

resource "local_file" "objects" {
  for_each = toset(var.objects)
  content  = "I love ${each.key}"
  filename = "${each.key}.txt"
}