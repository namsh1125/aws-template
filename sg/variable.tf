variable "backend_ports" {
  type        = list(number)
  description = "The list of ports the backend application server is listening on"
  default     = [8080]
}
