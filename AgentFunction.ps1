function AgentFunction {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [array]$argList
    )

    $installPath = (Get-ItemProperty -Path HKLM:\SOFTWARE\Datadog\Datadog' 'Agent\ -Name InstallPath)."InstallPath"
    $installPath = $installPath + 'embedded\agent.exe'

    for($i=0; $i -lt $argList.length; $i++){
    	if($i -eq 0) {
	    	$cmdString = $argList[$i] + " "
    	}
    	elseif($i -eq ($argList.length-1)){
    		$cmdString += $argList[$i]
    	} 
    	else {
    		$cmdString += $argList[$i] + " "
    	}

    }

    &$installPath $cmdString
}