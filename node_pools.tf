# Copyright (C) 2020 Nicolas Lamirault <nicolas.lamirault@gmail.com>

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

resource "scaleway_k8s_pool_beta" "pools" {
  for_each = var.node_pools

  cluster_id = scaleway_k8s_cluster_beta.main.id

  name                = each.key
  node_type           = each.value.node_type
  size                = each.value.size
  min_size            = lookup(each.value, "min_size", local.min_size)
  max_size            = lookup(each.value, "max_size", each.value.size)
  tags                = lookup(each.value, "tags", local.tags)
  placement_group_id  = lookup(each.value, "placement_group_id", null)
  autoscaling         = lookup(each.value, "autoscaling", false)
  autohealing         = lookup(each.value, "autohealing", false)
  container_runtime   = lookup(each.value, "container_runtime", "docker")
  region              = lookup(each.value, "region", null)
  wait_for_pool_ready = lookup(each.value, "wait_for_pool_ready", false)
}
