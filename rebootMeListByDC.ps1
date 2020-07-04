#
# This script calls a custom cmdlt that will generate a report by DC and serverType
#
# ie (Get-NTserver -datacenter lks -serverType ASPWEB | select name | foreach { $_.Name } | sort name)
#
#	Author: Paul R Heintz ISG Release 
#
#	Revisions: 0.1
#
#

Add-Type -AssemblyName System.Windows.Forms

# working variables
$reportDate = Get-Date -Format yyyyMMdd_HHmm

$nl = "`r`n"

# functions

function rebootMeList ($serTypes)
{
	$DC = @("lks",
			"bmo")
			
	# blowout to an array
	$serverType = $serTypes -split " " 
			
	foreach ($dcLocation in $DC)
	{
		foreach ($SType in $serverType)
		{
			$outputListserverTypeByLocation = Get-NTserver -datacenter $dcLocation -serverType $SType | select name | foreach { $_.Name } | sort name 
			
			# ok take the array and send it to the txt file with headings containing location and serverType
			for ($I = 0; $I -lt $outputListserverTypeByLocation.Length; $I++)
			{
				$outLine += $outputListserverTypeByLocation[$I] + " " 
			}
			
			# add to $tbBoxReBoot
			$tbBoxReBoot.AppendText($SType + " " + $outLine + $nl) > $null
			
			$outLine = ""
		}
	}
}

# form info here:

$Form = New-Object system.Windows.Forms.Form
$Form.Text = "Boot Servers List Generator"
$Form.Size = New-Object System.Drawing.Size(600,500)

# ListBoxReBoot
$tbBoxReBoot = New-Object System.Windows.Forms.TextBox
$tbBoxReBoot.Location = New-Object System.Drawing.Size(20,120)
$tbBoxReBoot.size = New-Object System.Drawing.Size(300,300)
$tbBoxReBoot.Multiline = $true
$tbBoxReBoot.ScrollBars = "Vertical"

$Form.Controls.Add($tbBoxReBoot)

# execute button
$b1 = New-Object System.Windows.Forms.Button
$b1.Location = New-Object System.Drawing.Size(20,20)
$b1.Size = New-Object System.Drawing.Size(75,53)
$b1.Text = 'Generate List'
$b1.Add_Click({ rebootMeList $tbEnv.Text })

$Form.Controls.Add($b1)

# environment list
$tbEnv = New-Object System.Windows.Forms.TextBox 
$tbEnv.Location = New-Object System.Drawing.Size(120,20) 
$tbEnv.Size = New-Object System.Drawing.Size(260,20)
 
$Form.Controls.Add($tbEnv) 

# Label Release part
$tbEnvlbl = New-Object System.Windows.Forms.Label
$tbEnvlbl.Location = New-Object System.Drawing.Size(380,20) 
$tbEnvlbl.Size = New-Object System.Drawing.Size(260,20)
$tbEnvlbl.Text = "List seperated by a space"

$Form.Controls.Add($tbEnvlbl) 

$Form.ShowDialog()

exit
