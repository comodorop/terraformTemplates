output "replication_group_primary_id" {
  value = "${module.redis-develop.this_replication_group_id}"
}

#output "replication_group_primary_endpoint_address" {
#  value = "${module.redis-develop.this_replication_group_primary_endpoint_address}"
#}

output "replication_group_member_clusters_develop" {
  value = "${module.redis-develop.this_replication_group_member_clusters}"
}
