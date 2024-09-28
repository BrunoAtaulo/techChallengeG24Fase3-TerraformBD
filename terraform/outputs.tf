#outputs.tf
output "security_group_id" {
  value       = aws_security_group.rds_secgrp.id
}
output "db_instance_endpoint" {
  value       = aws_db_instance.sqltechchallengeDb.endpoint
}