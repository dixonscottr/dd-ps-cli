<#
.SYNOPSIS
    use the Datadog Agent commands
.DESCRIPTION
    Powershell cmdlet
.PARAMETER Input1
    agent or show
.PARAMETER Input2
    subcommand
#>

function DatadogAgent {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Input1,

        [Parameter(Mandatory)]
        [ValidateNotNullOrEmpty()]
        [string]$Input2

    )
    switch ( $Input1 ) {
        "agent" { AgentFunction $Input2 }
        "show" { ShowFunction $Input2 }
    }
}

function AgentFunction {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string]$Input2
    )
    Write-Output $Input2
}

function ShowFunction {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string]$Input2
    )
    
    if ($Input2 -eq "datadog.yaml") {
        OpenFileExplorer (GetProgramDataPath)
    }  else {
        OpenFileExplorer (GetPDAgentPaths $Input2)
    }
}

function GetProgramDataPath {
    $RepoPath = (Get-ItemProperty -Path HKLM:\SOFTWARE\Datadog\Datadog' 'Agent\ -Name TufMetaPath)."TufMetaPath"
    $RepoCharLocation = $RepoPath.IndexOf("repositories\")
    $ProgramDataPath = $RepoPath.Substring(0,$RepoCharLocation)
    return $ProgramDataPath
}

function OpenFileExplorer {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string]$Path
    )
    if (Test-Path $Path) {
        Write-Output "Opening directory in file explorer: $Path"
        Invoke-Item $Path
    } else {
        Write-Output "This path does not exist: $Path"
    }
}

function GetPDAgentPaths {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string]$Path
    )
    $GetProgramDataPath = GetProgramDataPath
    return "$GetProgramDataPath\$Path"
}
