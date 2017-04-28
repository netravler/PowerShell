Clear

Function Read-Text 
{
	Param($Fore, [String]$Text, $moreparameters)
	If ($Fore)
		{
		[console]::ForegroundColor = $Fore
		}
	Read-Host $Text $moreparameters
	[console]::ResetColor()
}

$test = Read-Text "white" "test:" ""
$test = Read-Text "yellow" "test:" ""
$test = Read-Text "green" "test:" ""
$test = Read-Text "blue" "test:" ""