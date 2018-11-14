function TestTraceAPI {
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$trace_host='127.0.0.1',
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]$trace_port=8126
    )

    $trace_endpoint = "v0.3/traces"
    $uri = "http://$trace_host" + ":" + "$trace_port/$trace_endpoint"

    $TRACE_ID = (Get-Random -Minimum 0 -Maximum 1000000)
    $SPAN_ID = (Get-Random -Minimum 0 -Maximum 1000000)

    $START = ([int64][double]::Parse((Get-Date -UFormat %s)) * 1000000000)
    Start-Sleep -s (Get-Random -Minimum 1 -Maximum 3)
    $DURATION = ([int64][double]::Parse((Get-Date -UFormat %s)) * 1000000000) - $START

    $Headers = @{"Content-Type" = "application/json"}

    # traces object data structure
    # $data = [[{
    #             "trace_id": $TRACE_ID,
    #             "span_id": $SPAN_ID,
    #             "name": "span_name",
    #             "resource": "/home",
    #             "service": "service_name",
    #             "type": "web",
    #             "start": $START,
    #             "duration": $DURATION
    #     }]]

    [System.Collections.ArrayList]$traces = @()
    [System.Collections.ArrayList]$trace = @()

    $span = @{
        "trace_id" = $TRACE_ID
        "span_id" = $SPAN_ID
        "name" = "span_name"
        "resource" = "/home"
        "service" = "service_name"
        "type" = "web"
        "start" = $START
        "duration" = $DURATION
    }
    $trace.Add($span) > $null
    $traces.Add($trace) > $null
    $traces.Add($trace) > $null

    Write-Output "Sending test trace to $uri"

    try {
        $response = Invoke-WebRequest -Method 'Post' -Uri $uri -ContentType 'application/json' -Body ($traces | ConvertTo-Json) -Headers $Headers
        if ($response.StatusCode -eq 200) {
            Write-Output "Trace succesfully sent"
        } else {
            Write-Output "Received status code: $response.StatusCode"
        }
    }
    catch {
        Write-Error $_
    }
}
