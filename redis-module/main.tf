module "redis-develop" {
  source = "umotif-public/elasticache-redis/aws"
  version = "~> 3.0.0"

  name                  = "redis-develop"
  engine_version        = "6.x"
  node_type             = "cache.t2.small"
  number_cache_clusters = 2

  vpc_id        = "${data.terraform_remote_state.infrastructure.outputs.vpc_id}"
  subnet_ids    = "${data.terraform_remote_state.infrastructure.outputs.subnets_id_persistence}"
  allowed_cidrs = "${concat(data.terraform_remote_state.infrastructure.outputs.subnets_cidr_private)}"

  auth_token = "${data.external.s3_secrets.result.elasticache_redis_featureflag_password}"

  tags = {
    Platform        = "${var.project}"
    Environment     = "${var.environment}"
    Instrumentation = "Datadog"
  }
}
