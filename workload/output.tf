output "static_site" {
  description = "Static site module outputs"
  value       = try(module.wrapper_static_site.static_site, "")
}

output "ecs_service" {
  description = "ECS service module outputs"
  value       = try(module.wrapper_ecs_service.container_module, "")
}
