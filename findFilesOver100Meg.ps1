Get-ChildItem c:\ -Recurse | Where-Object {$_.Length -gt 100MB}
