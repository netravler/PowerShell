
$ol = New-Object -comObject Outlook.Application

$environmentMigPro = ""

$mail = $ol.CreateItem(0)

$PrepSubject = "Defect #DEFECTDEFECT# -  #ENVENVEVN# for DotNet Build Please push part #PARTPART#"

$mail.Subject = $PrepSubject -replace "#DEFECTDEFECT#", $tbRelease.Text -replace "#PARTPART#", $tbletterPart.Text -replace "#ENVENVENV#", $evMigPro

$PrepBody = "Operations,

Please execute the following (Code is in the Defect #DEFECTDEFECT#):

1.	Run Part #PARTPART#_LX on LKSNTADM01, and run Part #PARTPART#_BMO on BMONTADM01
2.	No need to manually run the Migration Robots

This code will not be live until we verify the build comes up successfully.

Thank you,"

$mail.Body = $PrepBody -replace "#DEFECTDEFECT#", $tbRelease.Text -replace "#PARTPART#", $tbletterPart.Text

$mail.save()

$inspector = $mail.GetInspector
$inspector.Display()
