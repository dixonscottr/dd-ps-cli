Import-module .\CheckAdmin.ps1 -Force

function AgentFunction {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [array]$argList
    )
    $isAdmin = Check-Admin

    if (!$isAdmin) {
        Write-Output "You are not in an Admin shell, Agent commands may not work."
    }

    <# Assign the installed path of agent.exe #>
    $installPath = (Get-ItemProperty -Path HKLM:\SOFTWARE\Datadog\Datadog' 'Agent\ -Name InstallPath)."InstallPath"
    $installPath = $installPath + 'embedded\agent.exe'

    <# Loop through input of command line args #>
    for($i=0; $i -lt $argList.length; $i++){
    	if(($i -eq 0) -And ($i -ne ($argList.length-1))) {
	    	$cmdString = $argList[$i] + " "
    	}
    	elseif($i -eq ($argList.length-1)){
    		$cmdString += $argList[$i]
    	} 
    	else {
    		$cmdString += $argList[$i] + " "
    	}

    }

    <# execute Agent! #>
    &$installPath $cmdString.split()
}