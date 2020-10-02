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

output "id" {
  value       = scaleway_k8s_cluster_beta.main.id
  description = "The ID of the cluster."
}

output "kubeconfig" {
  value       = scaleway_k8s_cluster_beta.main.kubeconfig
  description = "The Kubernetes configuration."
}

output "status" {
  value       = scaleway_k8s_cluster_beta.main.status
  description = "The status of the Kubernetes cluster."
}
