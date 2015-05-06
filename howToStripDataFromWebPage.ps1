# http://dollarunderscore.azurewebsites.net/?p=2651
# http://stackoverflow.com/questions/25940510/how-to-extract-specific-tables-from-html-file-using-native-powershell-commands
# https://technet.microsoft.com/library/hh849895.aspx

$Id = "MyPackageId"
$log = "c:\_paul\dumpFromTest.txt"

$PackageTrace = Invoke-WebRequest -Uri "http://flightaware.com/live/flight/N894JH" -UseBasicParsing

$PackageTrace.Content | Out-File "c:\_paul\testPackageTrace.txt"

$TraceItems = ((($PackageTrace.Content -split "<table class=`"prettyTable fullWidth`"")[1] -split "</TABLE>")[0]) -split "<tr class=" | Select-Object 

$TraceItems | Out-File "c:\_paul\testTraceItems.txt"

foreach ($TraceItem in $TraceItems) {
 
    $flightEvent = (($TraceItem -split "<td class=`"nowrap`"")[1] -split "</tr>")[0]
	
	$flightEvent | Out-File "c:\_paul\testflightEvent.txt" -Append -NoClobber 
 
    $returnObject = New-Object System.Object
    $returnObject | Add-Member -Type NoteProperty -Name flightEvent -Value $flightEvent
 
    Write-Output $returnObject | Out-File "c:\_paul\test.txt" -Append -NoClobber
	$returnObject
}
