package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestActiveDirectoryAuthExample(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../examples/active-directory-auth",
	})

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)
}
