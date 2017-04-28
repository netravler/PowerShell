# get calendar info from a specific cal 
# Original Author: Paul Heintz, ISG Release

# helpful links
#
# https://blogs.technet.microsoft.com/heyscriptingguy/2011/05/24/use-powershell-to-export-outlook-calendar-information/
# https://social.technet.microsoft.com/Forums/scriptcenter/en-US/24450bf0-b9f6-43a6-a3df-e381141fc183/how-to-powershell-to-extract-ms-outlook-calendar-events-and-reformat-them-into-vcal-format?forum=ITCG

# api you need!!!
# https://www.microsoft.com/en-us/download/details.aspx?id=42022

$EWSServicePath = 'C:\Program Files (x86)\Microsoft\Exchange\Web Services\2.1\Microsoft.Exchange.WebServices.dll'
Import-Module $EWSServicePath

clear

Function Get-OutlookCalendar2
{
	Add-type -assembly "Microsoft.Office.Interop.Outlook" | out-null
	$olFolders = "Microsoft.Office.Interop.Outlook.OlDefaultFolders" -as [type] 
	$outlook = new-object -comobject outlook.application
	$namespace = $outlook.GetNameSpace("MAPI")

	$folder = $namespace.getDefaultFolder($olFolders::olFolderCalendar)
	$folder.items | %{$_.SaveAs("p:\$($_.Subject).vcs",7)}
}

Function Get-OutlookCalendarSym

{  

	Add-type -assembly "Microsoft.Office.Interop.Outlook" | out-null
	#$olFolders = "Microsoft.Office.Interop.Outlook.OlDefaultFolders" -as [type]
	$outlook = new-object -comobject outlook.application
	$namespace = $outlook.GetNameSpace("MAPI")
	$folder = $namespace.Session.GetDefaultFolder(18)
	Write-Host $folder
	$folder.folders.Item("\\Public Folders - PHeintz@jackhenry.com\Favorites").items | Select-Object -Property Subject, Start, Duration, Location |
	where-object { $_.start -gt [datetime]"5/10/2016" -AND $_.start -lt [datetime]"10/17/2016" } | sort-object Duration

} 


Function Get-OutlookCalendar

{  

	Add-type -assembly “Microsoft.Office.Interop.Outlook” | out-null
	$olFolders = “Microsoft.Office.Interop.Outlook.OlDefaultFolders” -as [type]
	$outlook = new-object -comobject outlook.application
	$namespace = $outlook.GetNameSpace("MAPI")
	$folder = $namespace.getDefaultFolder($olFolders::olFolderCalendar)
	$folder.items | Select-Object -Property Subject, Start, Duration, Location |
	where-object { $_.start -gt [datetime]"5/10/2016" -AND $_.start -lt [datetime]"10/17/2016" } | sort-object Duration

} 

#Get-OutlookCalendarSym | Write-Host 

Get-OutlookAppointments | Write-Host




#    where-object { $_.start -gt [datetime]”5/10/2016″ -AND $_.start -lt `

#    [datetime]”5/17/2016″ } | sort-object Duration