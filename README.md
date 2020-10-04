# terraform-scaleway-kapsule

Terraform module which configure a Kubernetes cluster on Scaleway Kapsule

## Versions

Use Terraform `0.13+` and Terraform Provider Scaleway `1.16+`.

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

### Providers

| Name | Version |
|------|---------|
| scaleway | ~> 1.16 |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| admission\_plugins | The list of admission plugins to enable on the cluster. | `list` | `[]` | no |
| balance\_similar\_node\_groups | (Defaults to false) Detect similar node groups and balance the number of nodes between them. | `bool` | `false` | no |
| cni | The Container Network Interface (CNI) for the Kubernetes cluster. | `string` | `"cilium"` | no |
| description | Description of the cluster | `string` | n/a | yes |
| disable\_scale\_down | (Defaults to false) Disables the scale down feature of the autoscaler. | `bool` | `false` | no |
| enable\_auto\_upgrade | (Optional) Set to true to enable Kubernetes patch version auto upgrades. ~> Important: When enabling auto upgrades, the version field take a minor version like x.y (ie 1.18). | `bool` | `false` | no |
| enable\_cluster\_autoscaler | (Optional) Enables the Kubernetes cluster autoscaler. | `bool` | `false` | no |
| enable\_dashboard | (Optional) Enables the Kubernetes dashboard. | `bool` | `false` | no |
| estimator | (Defaults to binpacking) Type of resource estimator to be used in scale up. | `string` | `"binpacking"` | no |
| expander | (Default to random) Type of node group expander to be used in scale up. | `string` | `"random"` | no |
| expendable\_pods\_priority\_cutoff | (Defaults to -10) Pods with priority below cutoff will be expendable. They can be killed without any consideration during scale down and they don't cause scale up. Pods with null priority (PodPriority disabled) are non expendable. | `string` | `"-10"` | no |
| feature\_gates | The list of feature gates to enable on the cluster. | `list(string)` | `[]` | no |
| ignore\_daemonsets\_utilization | (Defaults to false) Ignore DaemonSet pods when calculating resource utilization for scaling down. | `bool` | `false` | no |
| ingress | The ingress controller to be deployed on the Kubernetes cluster. | `string` | n/a | yes |
| k8s\_version | The version of the Kubernetes cluster. | `string` | n/a | yes |
| maintenance\_window\_day | (Optional) The day of the auto upgrade maintenance window (monday to sunday, or any). Required if enable\_auto\_upgrade is true | `string` | n/a | yes |
| maintenance\_window\_start\_hour | (Optional) The start hour (UTC) of the 2-hour auto upgrade maintenance window (0 to 23). Required if enable\_auto\_upgrade is true | `string` | n/a | yes |
| name | The name of the cluster | `string` | n/a | yes |
| node\_pools | Node pools configuration for Kubernetes cluster. | `map` | n/a | yes |
| region | The region in which the cluster should be created. | `any` | n/a | yes |
| scale\_down\_delay\_after\_add | (Defaults to 10m) How long after scale up that scale down evaluation resumes. | `string` | `"10m"` | no |
| scale\_down\_unneeded\_time | (Default to 10m) How long a node should be unneeded before it is eligible for scale down. | `string` | `"10m"` | no |
| tags | The tags associated with the Kubernetes cluster. | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| id | The ID of the cluster. |
| kubeconfig | The Kubernetes configuration. |
| status | The status of the Kubernetes cluster. |

