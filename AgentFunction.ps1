function AgentFunction {
    param(
      [Parameter(Mandatory)]
      [ValidateNotNullOrEmpty()]
      [string]$Input2
    )
    Write-Output $Input2
}