# https://gallery.technet.microsoft.com/scriptcenter/Script-Generator-for-36041cee
#
# Author: Paul R. Heintz x431010 ISG Release JHA
#
#
# SOW: Ok this is a demo program that will generate a form and fields based upon a database 
#      query.  For the exercise we will feed the monster via a series of arrays.  You can only 
#	   utilize a single form at a time.  There are limitations to this goodness...:(
#

# required assemblies
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.IO.Compression.FileSystem

# seed arrays

Clear

# this will be a 4D array (form name, Size, Width, color)
$formMake = @(("TestOne", "800", "400", "lightblue"),
				("TestTwo", "800", "300", "lightblue"),
				("TestThree", "800", "200", "lightblue"))

# FORM CONTROL

for ($Int3 = 0; $Int3 -lt $formMake.Length; $Int3++) 
{
	$Form = New-Object system.Windows.Forms.Form
	$Form.Text = $formMake[$Int3][0]
	$Form.Size = New-Object System.Drawing.Size($formMake[$Int3][1],$formMake[$Int3][2])
	$Form.BackColor = $formMake[$Int3][3]
	$Form.ShowDialog()
}

# getDate

$backUpDate = Get-Date -format yyyyMMdd

exit