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
| auto\_upgrade | The auto upgrade configuration. | <pre>object({<br>    enable                        = bool<br>    maintenance_window_start_hour = number<br>    maintenance_window_day        = string<br>  })</pre> | n/a | yes |
| autoscaler\_config | The configuration options for the Kubernetes cluster autoscaler. | <pre>object({<br>    enabled                         = bool<br>    disable_scale_down              = bool<br>    scale_down_delay_after_add      = string<br>    scale_down_unneeded_time        = string<br>    estimator                       = string<br>    expander                        = string<br>    ignore_daemonsets_utilization   = bool<br>    balance_similar_node_groups     = bool<br>    expendable_pods_priority_cutoff = number<br>  })</pre> | n/a | yes |
| cni | The Container Network Interface (CNI) for the Kubernetes cluster. | `string` | `"cilium"` | no |
| feature\_gates | The list of feature gates to enable on the cluster. | `list` | `[]` | no |
| ingress | The ingress controller to be deployed on the Kubernetes cluster. | `string` | n/a | yes |
| k8s\_version | The version of the Kubernetes cluster. | `string` | n/a | yes |
| name | The name of the cluster | `string` | n/a | yes |
| node\_pools | Node pools configuration for Kubernetes cluster. | `list` | <pre>[<br>  {<br>    "autohealing": true,<br>    "autoscaling": false,<br>    "container_runtime": "docker",<br>    "max_size": 3,<br>    "min_size": 1,<br>    "node_type": "GP1-XS",<br>    "placement_group_id": null,<br>    "size": 1,<br>    "tags": []<br>  }<br>]</pre> | no |
| region | (Defaults to provider region) The region in which the cluster should be created. | `any` | n/a | yes |
| tags | The tags associated with the Kubernetes cluster. | `list(string)` | `[]` | no |

### Outputs

| Name | Description |
|------|-------------|
| id | The ID of the cluster. |
| kubeconfig | The Kubernetes configuration. |
| status | The status of the Kubernetes cluster. |
