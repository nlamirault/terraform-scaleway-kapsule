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

#######################################################################
# Provider


#######################################################################
# Kubernetes cluster

variable name {
  description = "The name of the cluster"
  type        = string
}

variable k8s_version {
  type        = string
  description = "The version of the Kubernetes cluster."
}

variable cni {
  type        = string
  default     = "cilium"
  description = "The Container Network Interface (CNI) for the Kubernetes cluster."

  validation {
    condition     = contains(["cilium", "weave", "calico", "flannel"], var.cni)
    error_message = "Values can only be \"cilium\", \"weave\", \"calico\" or \"flannel\"."
  }
}

variable ingress {
  type        = string
  description = "The ingress controller to be deployed on the Kubernetes cluster."

  validation {
    condition     = contains(["nginx", "traefik", "traefik2", "none"], var.ingress)
    error_message = "Values can only be \"nginx\", \"treafik\" or \"traefik2\"."
  }
}

variable tags {
  type        = list(string)
  default     = []
  description = "The tags associated with the Kubernetes cluster."
}

variable feature_gates {
  default     = []
  description = "The list of feature gates to enable on the cluster."
}

variable admission_plugins {
  default     = []
  description = "The list of admission plugins to enable on the cluster."
}

variable region {
  default     = null
  description = "(Defaults to provider region) The region in which the cluster should be created."
}

variable autoscaler_config {
  default = null
  type = object({
    enabled                         = bool
    disable_scale_down              = bool
    scale_down_delay_after_add      = string
    scale_down_unneeded_time        = string
    estimator                       = string
    expander                        = string
    ignore_daemonsets_utilization   = bool
    balance_similar_node_groups     = bool
    expendable_pods_priority_cutoff = number
  })
  description = "The configuration options for the Kubernetes cluster autoscaler."
}

variable auto_upgrade {
  default = null
  type = object({
    enable                        = bool
    maintenance_window_start_hour = number
    maintenance_window_day        = string
  })
  description = "The auto upgrade configuration."
}

#######################################################################
# Node pools

variable "node_pools" {
  type = list
  default = [{
    node_type          = "GP1-XS"
    size               = 1
    min_size           = 1
    max_size           = 3
    autohealing        = true
    autoscaling        = false
    placement_group_id = null
    container_runtime  = "docker"
    tags               = []
  }]
  description = "Node pools configuration for Kubernetes cluster."
}
