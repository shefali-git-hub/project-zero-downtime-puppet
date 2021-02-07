# == Class: class_name
#
class profile::project::build {

 exec {'ArtifactoryInstall':

	path    => 'C:\\Windows\\System32\\WindowsPowerShell\\v1.0',
	command => 'powershell C:\Application\Provisioning\modules\project_automation\files\downloadArtifactory.ps1',
    timeout => 1800
    }
}
