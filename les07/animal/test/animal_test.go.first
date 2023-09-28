package test

import (
	"fmt"
	"flag"
	"testing"
	"time"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

var folder = flag.String("folder", "", "Folder ID in Yandex.Cloud")

func TestEndToEndDeploymentScenario(t *testing.T) {

	terraformOptions := &terraform.Options{
			TerraformDir: "../",

			Vars: map[string]interface{}{
			"yc_folder":    *folder,
		    },
	}

	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	fmt.Println("Finish infra.....")

    time.Sleep(30 * time.Second)

    fmt.Println("Destroy infra.....")
}
