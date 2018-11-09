function AgentFunction {
<#
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [switch]$Input
    )
#>

    $installPath = (Get-ItemProperty -Path HKLM:\SOFTWARE\Datadog\Datadog' 'Agent\ -Name InstallPath)."InstallPath"
    $installPath = $installPath + 'embedded\agent.exe'


    &$installPath 

    $PSBoundParameters
}