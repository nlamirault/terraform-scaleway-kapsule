# Copyright (C) Nicolas Lamirault <nicolas.lamirault@gmail.com>
#
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
#
# SPDX-License-Identifier: Apache-2.0

resource "scaleway_k8s_cluster" "main" {
  name                        = var.name
  region                      = var.region
  description                 = format("%s. Created by Terraform", var.description)
  version                     = var.k8s_version
  cni                         = var.cni
  tags                        = var.tags
  feature_gates               = var.feature_gates
  admission_plugins           = var.admission_plugins
  delete_additional_resources = var.delete_additional_resources

  private_network_id = data.scaleway_vpc_private_network.this.id

  dynamic "autoscaler_config" {
    for_each = var.enable_cluster_autoscaler ? [1] : []

    content {
      disable_scale_down              = var.disable_scale_down
      scale_down_delay_after_add      = var.scale_down_delay_after_add
      scale_down_unneeded_time        = var.scale_down_unneeded_time
      estimator                       = var.estimator
      expander                        = var.expander
      ignore_daemonsets_utilization   = var.ignore_daemonsets_utilization
      balance_similar_node_groups     = var.balance_similar_node_groups
      expendable_pods_priority_cutoff = var.expendable_pods_priority_cutoff
    }
  }

  dynamic "auto_upgrade" {
    for_each = var.enable_auto_upgrade ? [1] : []

    content {
      enable                        = var.enable_auto_upgrade
      maintenance_window_start_hour = var.maintenance_window_start_hour
      maintenance_window_day        = var.maintenance_window_day
    }
  }

}
