output "created_file_path" {
  description = "The full path of the file Terraform created"
  value       = local_file.devops_log.filename
}

output "file_content" {
  description = "The content written into the managed file"
  value       = local_file.devops_log.content
}
