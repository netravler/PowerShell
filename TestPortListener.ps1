[int]$port=6666
[string]$IPAdress="127.0.0.1"
[switch]$Echo=$false

$listener = new-object System.Net.Sockets.TcpListener([System.Net.IPAddress]::Parse($IPAdress), $port)

$listener.start()

[byte[]]$bytes = 0..255|%{0}

write-host "Waiting for a connection on port $port..."
$client = $listener.AcceptTcpClient()

write-host "Connected from $($client.Client.RemoteEndPoint)"
$stream = $client.GetStream()

while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0)
{
    $bytes[0..($i-1)]|%{$_}
    if ($Echo){$stream.Write($bytes,0,$i)}
}

$client.Close()
$listener.Stop()
write-host "Connection closed."
