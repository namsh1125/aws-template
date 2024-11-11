output "keypair_name" {
  description = "EC2 Key Pair 이름"
  value       = aws_key_pair.keypair.key_name
}