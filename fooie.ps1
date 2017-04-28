# fooie - will execute a foo against know systems 
# https://blogs.technet.microsoft.com/otto/2007/08/23/quick-and-dirty-web-site-monitoring-with-powershell/
# http://stackoverflow.com/questions/29217557/find-specific-sentence-in-a-web-page-using-powershell

clear

# various control strings
$nl = "`r`n"

$webClient = new-object System.Net.WebClient

function checkFoo ($fooMeYo)
{
	for ($Int = 0; $Int -lt $fooMeYo.Length; $Int++)
	{
		try
		{
			$output = $webClient.DownloadString($fooMeYo[$Int][1])
			$editLog.AppendText($fooMeYo[$Int][0] + $output.Substring($fooMeYo[$Int][2],$fooMeYo[$Int][3]).Replace("<br />"," ").Replace("<b",""))
			$editLog.AppendText($nl)
		}
		catch
		{
			$editLog.AppendText($fooMeYo[$Int][0] + "Error ")
			$editLog.AppendText($nl)
			continue 
		}
	}
}

# data arrays

$checkFoo = @(("Production NT: ","https://www.netteller.com/checkstatus/foo.aspx",45,55),
			("Migration NT: ","https://www2.netteller.com/checkstatus/foo.aspx",45,55),
			("ConfigAPP: ","https://configuration.netteller.com/checkstatus/foo.aspx",78,32),
			("BackOffice: ","https://backoffice.netteller.com/checkstatus/foo.aspx",45,55),
			("AirTeller: ","https://www.airteller.com/checkstatus/foo.aspx",45,55))

# getDate

$backUpDate = Get-Date -format yyyyMMdd

# end worker arrays:

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Fooie"
$Form.Size = New-Object System.Drawing.Size(600,220)

# execute button
$b1 = New-Object System.Windows.Forms.Button
$b1.Location = New-Object System.Drawing.Size(20,20)
$b1.Size = New-Object System.Drawing.Size(75,93)
$b1.Text = 'Run Fooie Again'
$b1.Add_Click({ $editLog.Text = ""; checkFoo $checkFoo })

$Form.Controls.Add($b1)

# edit log
$editLog = New-Object System.Windows.Forms.TextBox 
$editLog.Multiline = $true
$editLog.WordWrap = $false
$editLog.ScrollBars = "Both"
$editLog.BackColor = "LightGray"
$editLog.Location = New-Object System.Drawing.Size(110,20) 
$editLog.Size = New-Object System.Drawing.Size(460,120)
 
$Form.Controls.Add($editLog) 

$Form.ShowDialog()

exit