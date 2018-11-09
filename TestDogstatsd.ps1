function TestDogstatsd {
    param(
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$dsd_host='127.0.0.1',
        
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [int]$dsd_port=8125
    )

    $UdpClient = New-Object System.Net.Sockets.UdpClient($dsd_host, $dsd_port)

    $Datagram = "test_metric:5|g|test:yes"

    $Data = [System.Text.Encoding]::ASCII.GetBytes($Datagram)

    Write-Output "Sending $Data to $dsd_host\:$dsd_port "$sent

    try {
      $data_length = $UdpClient.Send($Data,$Data.length)
      Write-Output "Sent $data_length bytes"
      $UdpClient.Close()
      }  catch {
          Write-Error $_
      }  finally {
          $UdpClient.Dispose()
      }
}




