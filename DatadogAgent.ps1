Import-module .\ShowFunction.ps1 -Force
Import-module .\AgentFunction.ps1 -Force
Import-module .\TestDogstatsd.ps1 -Force

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
        [string]$Input2,

        [Parameter(Mandatory=$FALSE)]
        [string]$Input3,

        [Parameter(Mandatory=$FALSE)]
        [string]$Input4

    )

    $argList = @()
    if($Input2) {
        $argList += $Input2
    }
    if($Input3) {
        $argList += $Input3
    }
    if($Input4) {
        $argList += $Input4
    }

    switch ( $Input1 ) {
        "agent" { AgentFunction $argList }
        "show" { ShowFunction $Input2 }
        "testd" { TestDogstatsd }
    }
}