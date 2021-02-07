$fileRoot = "C:\project_blue_green\"
$binaryRoot = "http://localhost:8081/artifactory/local-generic/"
function downloadLib {
             $results = ((Invoke-WebRequest "$($binaryRoot)").links).href
             echo $results
              foreach($r in $results) {

if ($r.endswith('/')) {
New-Item -ItemType directory -Path "$($fileRoot)$($r)"
downloadAllChildren "$($binaryRoot)$($r)" "$($fileRoot)$($r)"
   }
   else{
     downloadAllChildren "$($binaryRoot)" "$($fileRoot)"
}
    }
}
function downloadAllChildren {
    param([string]$source, [string]$dest)
    $results1 = ((Invoke-WebRequest "$source").links).href
	$user = "admin"
	$pass= "password"
	$secpasswd = ConvertTo-SecureString $pass -AsPlainText -Force
	$credential = New-Object System.Management.Automation.PSCredential($user, $secpasswd)
    foreach($s in $results1) {
        if(!$s.equals('../')){
            if ($s.endswith('/')) {
                New-Item -ItemType directory -Path "$($dest)$($s)"
                downloadAllChildren "$($source)$($s)" "$($dest)$($s)"
        }else {
            Invoke-WebRequest -Uri "$($source)$($s)"  -Credential $credential -OutFile "$($dest)$($s)"
            }
        }
    }
}
downloadLib
