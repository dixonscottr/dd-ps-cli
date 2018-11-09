Import-module .\ShowFunction.ps1 -Force
Import-module .\AgentFunction.ps1 -Force

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