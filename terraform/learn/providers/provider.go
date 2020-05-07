package main

import (
	"github.com/hashicorp/terraform/helper/schema"
)

// Provider go style needs comments
func Provider() *schema.Provider {
	return &schema.Provider{
		ResourcesMap: map[string]*schema.Resource{},
	}
}
