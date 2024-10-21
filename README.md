# terraform-scaleway-kapsule

Terraform module which configure a Kubernetes cluster on Scaleway Kapsule

## Versions

Use Terraform `0.14+` and Terraform Provider Scaleway `2.0+`.

These types of resources are supported:

## Usage

```hcl

module "kubernetes" {
  source  = "nlamirault/kapsule/scaleway"
  version = "0.2.0"

  name              = var.name
  description       = var.description
  k8s_version       = var.k8s_version
  cni               = var.cni
  enable_dashboard  = var.enable_dashboard
  ingress           = var.ingress
  tags              = var.tags
  feature_gates     = var.feature_gates
  admission_plugins = var.admission_plugins

  enable_cluster_autoscaler     = var.enable_cluster_autoscaler
  scale_down_delay_after_add    = var.scale_down_delay_after_add
  scale_down_unneeded_time      = var.scale_down_unneeded_time
  estimator                     = var.estimator
  expander                      = var.expander
  ignore_daemonsets_utilization = var.ignore_daemonsets_utilization

  enable_auto_upgrade           = var.enable_auto_upgrade
  maintenance_window_start_hour = var.maintenance_window_start_hour
  maintenance_window_day        = var.maintenance_window_day

  node_pools = var.node_pools
}

```

With variables :

```hcl
name = "my-kapsule"
description = "Kubernetes on Kapsule"

k8s_version = "1.18"

cni = "cilium"

ingress = "nginx"

tags = ["terraform", "jarvis"]

feature_gates = []

admission_plugins = []

enable_cluster_autoscaler = true
disable_scale_down = false
scale_down_delay_after_add = "5m"
estimator = "binpacking"
expander = "random"
ignore_daemonsets_utilization = true
balance_similar_node_groups = true
expendable_pods_priority_cutoff = -5

enable_auto_upgrade           = true
maintenance_window_start_hour = 4
maintenance_window_day        = "monday"

node_pools = {
    "core" = {
      "node_type"           = "DEV1_M"
      "size"                = 1
      "min_size"            = 1
      "max_size"            = 1
      "autoscaling"         = true
      "autohealing"         = true
      "wait_for_pool_ready" = true
      "tags"                = ["prod", "core", "terraform"]
    },
    "ops" = {
      "node_type"           = "DEV1_M"
      "size"                = 1
      "min_size"            = 1
      "max_size"            = 1
      "autoscaling"         = true
      "autohealing"         = false
      "wait_for_pool_ready" = true
      "tags"                = [ "prod", "ops", "terraform" ]
    }
}
```

This module creates :

* a Kubernetes cluster

## Documentation

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_k8s_cluster.main](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_cluster) | resource |
| [scaleway_k8s_pool.pools](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_pool) | resource |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_admission_plugins"></a> [admission\_plugins](#input\_admission\_plugins) | The list of admission plugins to enable on the cluster. | `list(string)` | `[]` | no |
| <a name="input_balance_similar_node_groups"></a> [balance\_similar\_node\_groups](#input\_balance\_similar\_node\_groups) | (Defaults to false) Detect similar node groups and balance the number of nodes between them. | `bool` | `false` | no |
| <a name="input_cni"></a> [cni](#input\_cni) | The Container Network Interface (CNI) for the Kubernetes cluster. | `string` | `"cilium"` | no |
| <a name="input_delete_additional_resources"></a> [delete\_additional\_resources](#input\_delete\_additional\_resources) | Delete additional resources that were created in Kubernetes on cluster deletion | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the cluster | `string` | n/a | yes |
| <a name="input_disable_scale_down"></a> [disable\_scale\_down](#input\_disable\_scale\_down) | (Defaults to false) Disables the scale down feature of the autoscaler. | `bool` | `false` | no |
| <a name="input_enable_auto_upgrade"></a> [enable\_auto\_upgrade](#input\_enable\_auto\_upgrade) | (Optional) Set to true to enable Kubernetes patch version auto upgrades. ~> Important: When enabling auto upgrades, the version field take a minor version like x.y (ie 1.18). | `bool` | `false` | no |
| <a name="input_enable_cluster_autoscaler"></a> [enable\_cluster\_autoscaler](#input\_enable\_cluster\_autoscaler) | (Optional) Enables the Kubernetes cluster autoscaler. | `bool` | `false` | no |
| <a name="input_estimator"></a> [estimator](#input\_estimator) | (Defaults to binpacking) Type of resource estimator to be used in scale up. | `string` | `"binpacking"` | no |
| <a name="input_expander"></a> [expander](#input\_expander) | (Default to random) Type of node group expander to be used in scale up. | `string` | `"random"` | no |
| <a name="input_expendable_pods_priority_cutoff"></a> [expendable\_pods\_priority\_cutoff](#input\_expendable\_pods\_priority\_cutoff) | (Defaults to -10) Pods with priority below cutoff will be expendable. They can be killed without any consideration during scale down and they don't cause scale up. Pods with null priority (PodPriority disabled) are non expendable. | `string` | `"-10"` | no |
| <a name="input_feature_gates"></a> [feature\_gates](#input\_feature\_gates) | The list of feature gates to enable on the cluster. | `list(string)` | `[]` | no |
| <a name="input_ignore_daemonsets_utilization"></a> [ignore\_daemonsets\_utilization](#input\_ignore\_daemonsets\_utilization) | (Defaults to false) Ignore DaemonSet pods when calculating resource utilization for scaling down. | `bool` | `false` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | The version of the Kubernetes cluster. | `string` | n/a | yes |
| <a name="input_maintenance_window_day"></a> [maintenance\_window\_day](#input\_maintenance\_window\_day) | (Optional) The day of the auto upgrade maintenance window (monday to sunday, or any). Required if enable\_auto\_upgrade is true | `string` | `null` | no |
| <a name="input_maintenance_window_start_hour"></a> [maintenance\_window\_start\_hour](#input\_maintenance\_window\_start\_hour) | (Optional) The start hour (UTC) of the 2-hour auto upgrade maintenance window (0 to 23). Required if enable\_auto\_upgrade is true | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_node_pools"></a> [node\_pools](#input\_node\_pools) | Node pools configuration for Kubernetes cluster. | <pre>map(object({<br>    node_type           = string<br>    size                = number<br>    min_size            = number<br>    max_size            = number<br>    autoscaling         = bool<br>    autohealing         = bool<br>    wait_for_pool_ready = bool<br>    tags                = list(string)<br>  }))</pre> | `{}` | no |
| <a name="input_private_network_name"></a> [private\_network\_name](#input\_private\_network\_name) | The name of the private network of the cluster. | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | The region in which the cluster should be created. | `string` | n/a | yes |
| <a name="input_scale_down_delay_after_add"></a> [scale\_down\_delay\_after\_add](#input\_scale\_down\_delay\_after\_add) | (Defaults to 10m) How long after scale up that scale down evaluation resumes. | `string` | `"10m"` | no |
| <a name="input_scale_down_unneeded_time"></a> [scale\_down\_unneeded\_time](#input\_scale\_down\_unneeded\_time) | (Default to 10m) How long a node should be unneeded before it is eligible for scale down. | `string` | `"10m"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | The tags associated with the Kubernetes cluster. | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the cluster. |
| <a name="output_kubeconfig"></a> [kubeconfig](#output\_kubeconfig) | The Kubernetes configuration. |
| <a name="output_status"></a> [status](#output\_status) | The status of the Kubernetes cluster. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
