package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestContainerAppExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/container-app",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
