package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestWebAppWithContainerRegistry(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/webapp-with-container-registry",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
