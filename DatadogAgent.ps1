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
    Write-Host $Input1 $Input2
}