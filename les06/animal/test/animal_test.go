package test

import (
	"fmt"
	"io/ioutil"
	"flag"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"golang.org/x/crypto/ssh"
)

var folder = flag.String("folder", "", "Folder ID in Yandex.Cloud")
var sshKeyPath = flag.String("ssh-key-pass", "", "Private ssh key for access to virtual machines")

func TestEndToEndDeploymentScenario(t *testing.T) {
    fixtureFolder := "../"

    test_structure.RunTestStage(t, "setup", func() {
		terraformOptions := &terraform.Options{
			TerraformDir: fixtureFolder,

			Vars: map[string]interface{}{
			"yc_folder":    *folder,
		    },
	    }

		test_structure.SaveTerraformOptions(t, fixtureFolder, terraformOptions)

		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
	    fmt.Println("Run some tests...")

	    terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)

        // test vmLinux ip existing
	    vmLinuxPublicIPAddress := terraform.Output(t, terraformOptions, "vm1_public_ip")

	    if vmLinuxPublicIPAddress == "" {
			t.Fatal("Cannot retrieve the public IP address value for the vm-linux.")
		}

		// test ssh connect
		key, err := ioutil.ReadFile(*sshKeyPath)
		if err != nil {
			t.Fatalf("Unable to read private key: %v", err)
		}

		signer, err := ssh.ParsePrivateKey(key)
		if err != nil {
			t.Fatalf("Unable to parse private key: %v", err)
		}

		sshConfig := &ssh.ClientConfig{
			User: "ubuntu",
			Auth: []ssh.AuthMethod{
				ssh.PublicKeys(signer),
			},
			HostKeyCallback: ssh.InsecureIgnoreHostKey(),
		}

		sshConnection, err := ssh.Dial("tcp", fmt.Sprintf("%s:22", vmLinuxPublicIPAddress), sshConfig)
		if err != nil {
			t.Fatalf("Cannot establish SSH connection to vm-linux public IP address: %v", err)
		}

		defer sshConnection.Close()

		sshSession, err := sshConnection.NewSession()
		if err != nil {
			t.Fatalf("Cannot create SSH session to vm-linux public IP address: %v", err)
		}

		defer sshSession.Close()

		err = sshSession.Run(fmt.Sprintf("ping -c 1 otus.ru"))
		if err != nil {
			t.Fatalf("Cannot ping otus.ru: %v", err)
		}
	})

	test_structure.RunTestStage(t, "teardown", func() {
		terraformOptions := test_structure.LoadTerraformOptions(t, fixtureFolder)
		terraform.Destroy(t, terraformOptions)
	})
}
