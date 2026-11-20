output "github_runner" {
  description = "Github runner module outputs"
  value = {
    webhook_endpoint = try(module.wrapper_github_runner.webhook_endpoint, {})
  }
}
