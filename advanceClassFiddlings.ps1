Get-Process | Where-Object {$_.ws -gt 100mb}

clear; Get-Service net* | ForEach-Object {"Hello " + $_.Name}

clear; Get-ChildItem -path *.txt -Recurse | Where-Object {$_.length -gt 1kb} | Sort-Object -Property length | Format-Table -Property name, length;

clear; Get-Process -Name explorer

clear; (Get-Process).id

clear; (Get-EventLog -LogName System).TimeWritten.DayofWeek | Group-Object

clear; Get-PSProvider | Format-Table -Property Name

clear; Get-PSDrive | Sort-Object Name | Format-Table -Property Name, Free

clear; Get-Item hklm:\software\*

clear; Get-Content Env:\CommonProgramFiles

clear; Get-Content Env:*

clear; $Env:windir

clear; $Function:more

clear; $Variable:ref

clear; $Error

clear; $?

clear; $HOME

clear; $Host

clear; $PSHOME

clear; Get-Variable *

clear; $svcs = Get-Service *

clear; $svcs = Get-Service | Where-Object {$_.Status -ne 'Stopped'}

clear; 32..255 | ForEach-Object {Write-Host "Decimal: $_ = Character: $([Char]$_)"}

clear; [datetime]"04/14/2013"

