variable "log_content" {
  description = "The content to write into the managed log file"
  type        = string
  default     = "Terraform managed this file on April 18, 2026."
}

variable "log_filename" {
  description = "The name of the output file Terraform will create"
  type        = string
  default     = "day12_check.txt"
}
