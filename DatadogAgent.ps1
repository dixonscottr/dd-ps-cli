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
        [string]$Input2,

        [Parameter(Mandatory=$FALSE)]
        [string]$Input3,

        [Parameter(Mandatory=$FALSE)]
        [string]$Input4
    )

    <#
    for ($i=1; $i -le $PSBoundParameters.count; $i++) {
        Write-Output $i
        
        Write-Output $PSBoundParameters

        if($PSBoundParameters["Input" + $i]){
            Write-Output "There's a value"
            Write-Output $PSBoundParamters[$i]
        }
    }
    #>

    <# 
    foreach($boundparam in $PSBoundParameters.GetEnumerator()) {
        $Input2 = $Input2 + $boundparam.Value
    }
    #>

    $argList = @()

    if($Input2) {
        Write-Output "There is input2"
        $argList += $Input2
    }

    if($Input3) {
        Write-Output "There is input3"
        $argList += $Input3
    }

    if($Input4) {
        Write-Output "There is input4"
        $argList += $Input4
    }

    switch ( $Input1 ) {
        "agent" { AgentFunction $argList }
        "show" { ShowFunction $Input2 }
    }
}