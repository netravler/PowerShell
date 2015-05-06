Add-Type -AssemblyName System.Windows.Forms

# functions:

function processExceptions($ServiceArray,$ServiceException,$ServicesArray,$commandScript,$DC,$Let,$ProMig,$releaseUp,$IBB,$baseFolderNameIN)
{
	#
	# info: this routine is to be used for process exceptions.  Please make the replace clause universal
	#
	if ($ServiceArray[$Int][0] -eq $ServiceException)
		{
			for ($Int5 = 0; $Int5 -lt $ServicesArray[0].Length; $Int5++) 
			{
    			if ($ServicesArray[$Int5][0] -eq $ServiceException)
				{
					$whatamI5 = $ServicesArray[$Int5][1]
						
					$baseFolderNameProName = $baseFolderNameIN + "\" +$IBB + $releaseUp + $ProMig + $Let + "_" + $DC + ".txt"
		    		Out-File -FilePath $baseFolderNameProName -InputObject $whatamI5.replace("#DCDCDC#",$DC) -Append -NoClobber -Encoding ascii
            		$baseFolderNameProName = ''
				}
			}
		}
}

function processRelease($ChdListBoxPro, $ChdListBoxMig) # all the folder and plan generation happens here:)
{
	$buildServicePro = @()
	$buildServiceMig = @()
	
	if ($checkedBoxPro.Checked)
	{
	
   		# Production server folder creation
        # prep base folder and false root
        $baseFolderNamePro = "\\kcserver\release_pub\Defects\NewNTAPPWebAndWinServices\production\"
        $release = "defect" + $tbRelease.Text.Trim()
        $letterPart = $tbLetterPart.Text.Trim()
        $baseFolderNamePro += $release + "_P" + $letterPart

        $createThisDirectoryPro = $baseFolderNamePro
        New-Item $createThisDirectoryPro -type directory
		
        foreach ($checkedServicePro in $CheckedListBoxPro.CheckedItems)
            {
                $createThisDirectoryPro = $baseFolderNamePro + "\" + $checkedServicePro
                New-Item $createThisDirectoryPro -type directory
				
				# accummulate service name for build serivce process
				$buildServicePro += $checkedServicePro
            }

		# next build out plans backup/backout/implementation based on bbi/dc
		#
		# Ok folks I've introduced some ugly below because of secondary exception servers.
		# There will be a rewrite of this tool once we've un-kinked it and a new function will do 
		# all of the whacky handling in the future.
		$Counter = -1
		foreach ($matchCheckedPro in $buildServicePro)
		{
			#Find the index stupid way of doing it but this is a multi against a single search...
			for ($Int = 0; $Int -lt $NTAPPServicesPro.Length; $Int++)
			{
    			if ($NTAPPServicesPro[$Int][0] -eq $matchCheckedPro)
				{
					$whatamI1 = $NTAPPServicesBackup
					$whatamI2 = $NTAPPServicesBackout
					$whatamI3 = $NTAPPServicesImpl

					# univeral edit
					$whatamI1 = $whatamI1 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "#DCDCDC#", "BMO"
					$whatamI2 = $whatamI2 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "#DCDCDC#", "BMO"
					$whatamI3 = $whatamI3 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "#DCDCDC#", "BMO"

					# BMO
			        # place all file generation within this block!
			        $baseFolderNameProName = $baseFolderNamePro + "\" +	"BackUp" + $release + "_P" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameProName -InputObject $whatamI1 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
									
			        $baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameProName -InputObject $whatamI2 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
					
					# Place exception for NettellerHostService restore to BMOCSLAPP01/BMOCSLAPP02
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					if ($NTAPPServicesPro[$Int][0] -eq "NettellerHostService")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPBBO[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPBBO[$Int1][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionPBBO[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_BMO.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","BMO").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# CSL
					if ($NTAPPServicesPro[$Int][0] -eq "CSL")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPBBO[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPBBO[$Int1][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionPBBO[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_BMO.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","BMO").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}

			        $baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameProName -InputObject $whatamI3 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
					
					# Place exception for NettellerHostService copy out to BMOCSLAPP01/BMOCSLAPP02
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					if ($NTAPPServicesPro[$Int][0] -eq "NettellerHostService")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPB[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPB[$Int1][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionPB[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_BMO.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","BMO") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# CSL
					if ($NTAPPServicesPro[$Int][0] -eq "CSL")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPB[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPB[$Int1][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionPB[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_BMO.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","BMO") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# end exception
				
        			# LX
					
					# univeral edit
					$whatamI1 = $whatamI1 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "BMO", "LKS"
					$whatamI2 = $whatamI2 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "BMO", "LKS"
					$whatamI3 = $whatamI3 -replace "#SERVICELOCATION#",$NTAPPServicesPro[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Production" -replace "#FOLDERNAME#", $NTAPPServicesPro[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesPro[$Int][2] -replace "BMO", "LKS"
					
		        	# place all file generation within this block!
			        $baseFolderNameProName = $baseFolderNamePro + "\" +	"BackUp" + $release + "_P" + $letterPart + "_LX.txt"
			        Out-File -FilePath $baseFolderNameProName -InputObject $whatamI1 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
									
        			$baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_LX.txt"
			        Out-File -FilePath $baseFolderNameProName -InputObject $whatamI2 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
					
					# Place exception for NettellerHostService restore to LKSCSLAPP01/LKSCSLAPP02
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					if ($NTAPPServicesPro[$Int][0] -eq "NettellerHostService")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPLBO[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPLBO[$Int1][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionPLBO[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","LKS").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# CSL
					if ($NTAPPServicesPro[$Int][0] -eq "CSL")
					{
						for ($Int1 = 0; $Int1 -lt $NTAPPServicesExceptionPLBO[0].Length; $Int1++) 
						{
    					if ($NTAPPServicesExceptionPLBO[$Int1][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionPLBO[$Int1][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Backout" + $release + "_P" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","LKS").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}

        			$baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_LX.txt"
					Out-File -FilePath $baseFolderNameProName -InputObject $whatamI3 -Append -NoClobber -Encoding ascii
                    $baseFolderNameProName = ''
					
					# Place exception for NettellerHostService copy out to LKSCSLAPP04/LKSCSLAPP05
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					if ($NTAPPServicesPro[$Int][0] -eq "NettellerHostService")
					{
					for ($Int2 = 0; $Int2 -lt $NTAPPServicesExceptionPL[0].Length; $Int2++) 
						{
    					if ($NTAPPServicesExceptionPL[$Int2][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionPL[$Int2][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","LKS") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# CSL
					
					if ($NTAPPServicesPro[$Int][0] -eq "CSL")
					{
					for ($Int2 = 0; $Int2 -lt $NTAPPServicesExceptionPL[0].Length; $Int2++) 
						{
    					if ($NTAPPServicesExceptionPL[$Int2][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionPL[$Int2][1]
						
								$baseFolderNameProName = $baseFolderNamePro + "\" +	"Impl" + $release + "_P" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameProName -InputObject $whatamI4.replace("#DCDCDC#","LKS") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameProName = ''
							}
						}
					}
					
					# end exception
					
					# Place exception for NettellerHostService copy out to LKSCSLAPP04/LKSCSLAPP05
					
					# end exception
				}
			}
		}
		Invoke-Item \\kcserver\release_pub\Defects\NewNTAPPWebAndWinServices\production\
	}
	
	if ($checkedBoxMig.Checked)
	{
   		# Migration server folder creation
   		# prep base folder and false root
    	$baseFolderNameMig = "\\kcserver\release_pub\Defects\NewNTAPPWebAndWinServices\migration\"
    	$release = "defect" + $tbRelease.Text.Trim()
    	$letterPart = $tbLetterPart.Text.Trim()
    	$baseFolderNameMig += $release + "_M" + $letterPart

    	$createThisDirectoryMig = $baseFolderNameMig
    	New-Item $createThisDirectoryMig -type directory

    	# Migration server folder creation
    	foreach ($checkedServiceMig in $CheckedListBoxMig.CheckedItems)
            {
                $createThisDirectoryMig = $baseFolderNameMig + "\" + $checkedServiceMig
                New-Item $createThisDirectoryMig -type directory
				
				# accummulate service name for build serivce Migcess
				$buildServiceMig += $checkedServiceMig
            }

		# next build out plans backup/backout/implementation based on bbi/dc
		#
		# Ok folks I've introduced some ugly below because of secondary exception servers.
		# There will be a rewrite of this tool once we've un-kinked it and a new function will do 
		# all of the whacky handling in the future.
		$Counter = -1
		foreach ($matchCheckedMig in $buildServiceMig)
		{
			#Find the index stupid way of doing it but this is a multi against a single search...
			for ($Int = 0; $Int -lt $NTAPPServicesMig.Length; $Int++)
			{
    			if ($NTAPPServicesMig[$Int][0] -eq $matchCheckedMig)
				{
					#$Counter = $Int
					
					$whatamI1 = $NTAPPServicesBackup
					$whatamI2 = $NTAPPServicesBackout
					$whatamI3 = $NTAPPServicesImpl

					# univeral edit
					$whatamI1 = $whatamI1 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "#DCDCDC#", "BMO"
					$whatamI2 = $whatamI2 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "#DCDCDC#", "BMO"
					$whatamI3 = $whatamI3 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","BMONTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "#DCDCDC#", "BMO"

                    # BMO
			        # place all file generation within this block!
			        $baseFolderNameMigName = $baseFolderNameMig + "\" +	"BackUp" + $release + "_M" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI1 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''
									
			        $baseFolderNameMigName = $baseFolderNameMig + "\" +	"Backout" + $release + "_M" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI2 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''

			        $baseFolderNameMigName = $baseFolderNameMig + "\" +	"Impl" + $release + "_M" + $letterPart + "_BMO.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI3 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''
				
        			# LX
		        	# place all file generation within this block!
					$whatamI1 = $whatamI1 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "BMO", "LKS"
					$whatamI2 = $whatamI2 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "BMO", "LKS"
					$whatamI3 = $whatamI3 -replace "#SERVICELOCATION#",$NTAPPServicesMig[$Int][1] -replace "#ADMADM#","LKSNTADM01" -replace "#PROMIG#", "Migration" -replace "#FOLDERNAME#", $NTAPPServicesMig[$Int][0] -replace "#DATEDATE#", $backUpDate -replace "#SERVERTYPE#", $NTAPPServicesMig[$Int][2] -replace "BMO", "LKS"
					
			        $baseFolderNameMigName = $baseFolderNameMig + "\" +	"BackUp" + $release + "_M" + $letterPart + "_LX.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI1 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''
									
        			$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Backout" + $release + "_M" + $letterPart + "_LX.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI2 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''

					# Place exception for NettellerHostService copy out to LKSCSLAPP03 
					# at this time it only needs to be implemented in Lenexa
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					
					if ($NTAPPServicesMig[$Int][0] -eq "NettellerHostService")
					{
					for ($Int3 = 0; $Int3 -lt $NTAPPServicesExceptionMLBO[0].Length; $Int3++) 
						{
   						if ($NTAPPServicesExceptionMLBO[$Int3][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionMLBO[$Int3][1]
								
								$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Backout" + $release + "_M" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI4.replace("#DCDCDC#","LKS").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameMigName = ''
							}
						}
					}
					
					# CSL
					
					if ($NTAPPServicesMig[$Int][0] -eq "CSL")
					{
					for ($Int3 = 0; $Int3 -lt $NTAPPServicesExceptionMLBO[0].Length; $Int3++) 
						{
   						if ($NTAPPServicesExceptionMLBO[$Int3][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionMLBO[$Int3][1]
								
								$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Backout" + $release + "_M" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI4.replace("#DCDCDC#","LKS").replace("#DATEDATE#",$backUpDate) -Append -NoClobber -Encoding ascii
                    			$baseFolderNameMigName = ''
							}
						}
					}

        			$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Impl" + $release + "_M" + $letterPart + "_LX.txt"
			        Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI3 -Append -NoClobber -Encoding ascii
                    $baseFolderNameMigName = ''
					
					# Place exception for NettellerHostService copy out to LKSCSLAPP03 
					# at this time it only needs to be implemented in Lenexa
					# ok we're going to spin through the array.  If more of this has to be accoommidated
					# it will become a function.
					
					if ($NTAPPServicesMig[$Int][0] -eq "NettellerHostService")
					{
					for ($Int3 = 0; $Int3 -lt $NTAPPServicesExceptionML[0].Length; $Int3++) 
						{
   						if ($NTAPPServicesExceptionML[$Int3][0] -eq "NettellerHostService")
							{
								$whatamI4 = $NTAPPServicesExceptionML[$Int3][1]
								
								$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Impl" + $release + "_M" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI4.replace("#DCDCDC#","LKS") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameMigName = ''
							}
						}
					}
					
					# CSL
					
					if ($NTAPPServicesMig[$Int][0] -eq "CSL")
					{
					for ($Int3 = 0; $Int3 -lt $NTAPPServicesExceptionML[0].Length; $Int3++) 
						{
   						if ($NTAPPServicesExceptionML[$Int3][0] -eq "CSL")
							{
								$whatamI4 = $NTAPPServicesExceptionML[$Int3][1]
								
								$baseFolderNameMigName = $baseFolderNameMig + "\" +	"Impl" + $release + "_M" + $letterPart + "_LX.txt"
			        			Out-File -FilePath $baseFolderNameMigName -InputObject $whatamI4.replace("#DCDCDC#","LKS") -Append -NoClobber -Encoding ascii
                    			$baseFolderNameMigName = ''
							}
						}
					}
				}
			}
		}
		  Invoke-Item \\kcserver\release_pub\Defects\NewNTAPPWebAndWinServices\migration\
	}
}

# worker arrays:

$NTAPPServicesPro =     @(("AudioTelStmts", "AudioTelWebSvc", "NTAPP"),
                        ("BankInfoService", "BankInfoWebSvc", "NTAPP"),
                        ("CSL", "CSLWebSvc", "NTAPP"),
                        ("Echoservices", "EchoWebSvc", "NTAPP"),
                        ("ESIAuthService", "ESIAuthWebSvc", "NTAPP"),
                        ("GladiatorWebService", "GladiatorWebSvc", "NTAPP"),
                        ("GuaranteedPaymentService", "GuaranteedPaymentWinSvc", "NTAPP"),
                        ("Interbanktransferservice", "IBTWinSvc", "NTAPP"),
                        ("IpayWebService", "IpayWebSvc", "NTAPP"),
                        ("JXchangeService", "JxWebSvc", "NTAPP"),
                        ("MultifactorAuthService", "MfaWebSvc", "NTAPP"),
                        ("NettellerHelpService", "NTHelpWebSvc", "NTAPP"),
                        ("NettellerHostService", "NTHostWebSvc", "NTAPP"),
                        ("NotificationService", "NotificationWebSvc", "NTAPP"),
                        ("OfflineAggregator", "OffAggWebSvc", "NTAPP"),
                        ("OfflineService", "OfflineWebSvc", "NTAPP"),
                        ("PowerPayWebService", "PowerPayWebSvc", "NTAPP"),
                        ("RiskAuthenticationService", "RiskAuthWebSvc", "NTAPP"),
                        ("SharedService", "SharedWebSvc", "NTAPP"),
                        ("SmsWebService", "SmsWebSvc", "NTAPP"),
                        ("SMSWindowsService", "SmsWinSvc", "NTAPP"), 
                        ("WebAlertService", "WebAlertWinSvc", "NTAPP"),
						("EchoQueueHandler","EchoQueueWinSvc", "SSAPP"),
						("GladiatorService","GladiatorWinSvc", "SSAPP"),
						("HostQueryCaptureService","HostQryCaptureWinSvc", "SSAPP"),
						("NotificationQueueService","NotificationQueueWinSvc", "SSAPP"),
						("OfflineQueueService","OfflineQueueWinSvc", "SSAPP"),
						("OfflineRefreshService","OfflineRefreshWinSvc", "SSAPP"))


$NTAPPServicesMig =     @(("AudioTelStmts", "AudioTelWebSvc", "CMNTAPP"),
                        ("BankInfoService", "BankInfoWebSvc", "CMNTAPP"),
                        ("CSL", "CSLWebSvc", "CMNTAPP"),
                        ("Echoservices", "EchoWebSvc", "CMNTAPP"),
                        ("ESIAuthService", "ESIAuthWebSvc", "CMNTAPP"),
                        ("GladiatorWebService", "GladiatorWebSvc", "CMNTAPP"),
                        ("GuaranteedPaymentService", "GuaranteedPaymentWinSvc", "CMNTAPP"),
                        ("Interbanktransferservice", "IBTWinSvc", "CMNTAPP"),
                        ("IpayWebService", "IpayWebSvc", "CMNTAPP"),
                        ("JXchangeService", "JxWebSvc", "CMNTAPP"),
                        ("MultifactorAuthService", "MfaWebSvc", "CMNTAPP"),
                        ("NettellerHelpService", "NTHelpWebSvc", "CMNTAPP"),
                        ("NettellerHostService", "NTHostWebSvc", "CMNTAPP"),
                        ("NotificationService", "NotificationWebSvc", "CMNTAPP"),
                        ("OfflineAggregator", "OffAggWebSvc", "CMNTAPP"),
                        ("OfflineService", "OfflineWebSvc", "CMNTAPP"),
                        ("PowerPayWebService", "PowerPayWebSvc", "CMNTAPP"),
                        ("RiskAuthenticationService", "RiskAuthWebSvc", "CMNTAPP"),
                        ("SharedService", "SharedWebSvc", "CMNTAPP"),
                        ("SmsWebService", "SmsWebSvc", "CMNTAPP"),
                        ("SMSWindowsService", "SmsWinSvc", "NTAPP"), 
                        ("WebAlertService", "WebAlertWinSvc", "CMNTAPP"),
						("EchoQueueHandler","EchoQueueWinSvc", "CMSSAPP"),
						("GladiatorService","GladiatorWinSvc", "CMSSAPP"),
						("HostQueryCaptureService","HostQryCaptureWinSvc", "CMSSAPP"),
						("NotificationQueueService","NotificationQueueWinSvc", "CMSSAPP"),
						("OfflineQueueService","OfflineQueueWinSvc", "CMSSAPP"),
						("OfflineRefreshService","OfflineRefreshWinSvc", "CMSSAPP"))
 
# mig/pro plans				

$NTAPPServicesBackup =  @(("powershell ""Backup-#SERVICELOCATION# #ADMADM# -#PROMIG#"""))

$NTAPPServicesImpl =  @(("powershell ""Get-NTServer #DCDCDC# -servertype #SERVERTYPE# | Copy-#SERVICELOCATION# -folder #FOLDERNAME# -#PROMIG# -Release"""))

$NTAPPServicesBackout =  @(("powershell ""Get-NTServer #DCDCDC# -servertype #SERVERTYPE# | Restore-#SERVICELOCATION# -backupdate #DATEDATE# -#PROMIG#"""))

# migration exceptions
$NTAPPServicesExceptionML = @(("NettellerHostService","powershell ""Copy-NTHostWebSvc -name LKSCSLAPP03 -folder NettellerHostService -Migration -Log"""),
							("CSL","powershell ""Copy-CSLWebSvc -name LKSCSLAPP03 -folder CSL -Migration -Log"""))

$NTAPPServicesExceptionMLBO = @(("NettellerHostService","powershell ""Restore-NTHostWebSvc -name LKSCSLAPP03 -backupdate #DATEDATE# -Migration"""),
							("CSL","powershell ""Restore-CSLWebSvc -name LKSCSLAPP03 -backupdate #DATEDATE# -Migration"""))

#Production exceptions
$NTAPPServicesExceptionPB = @(("NettellerHostService","powershell ""Copy-NTHostWebSvc -name BMOCSLAPP01, BMOCSLAPP02 -folder NettellerHostService -Production -Log"""),
							("CSL","powershell ""Copy-CSLWebSvc -name BMOCSLAPP01,BMOCSLAPP02 -folder NettellerHostService -Production -Log"""))
							
$NTAPPServicesExceptionPBBO = @(("NettellerHostService","powershell ""Restore-NTHostWebSvc -name BMOCSLAPP01,BMOCSLAPP02 -backupdate #DATEDATE# -Production"""),
							("CSL","powershell ""Restore-CSLWebSvc -name BMOCSLAPP01,BMOCSLAPP02 -backupdate #DATEDATE# -Production"""))
							
$NTAPPServicesExceptionPL = @(("NettellerHostService","powershell ""Copy-NTHostWebSvc -name LKSCSLAPP04,LKSCSLAPP05 -folder NettellerHostService -Production -Log"""),
							("CSL","powershell ""Copy-CSLWebSvc -name LKSCSLAPP04,LKSCSLAPP05 -folder CSL -Production -Log"""))

$NTAPPServicesExceptionPLBO = @(("NettellerHostService","powershell ""Restore-NTHostWebSvc -name LKSCSLAPP04,LKSCSLAPP05 -backupdate #DATEDATE# -Production"""),
							("CSL","powershell ""Restore-CSLWebSvc -name LKSCSLAPP04,LKSCSLAPP05 -backupdate #DATEDATE# -Production"""))

# buildItem

$buildItem =           @((""))

# getDate

$backUpDate = Get-Date -format yyyyMMdd


# end worker arrays:


$Form = New-Object system.Windows.Forms.Form
$Form.Text = "NTAPP Deployment Plan Generator"
$Form.Size = New-Object System.Drawing.Size(900,500)

# checkedListBoxPro
$CheckedListBoxPro = New-Object System.Windows.Forms.CheckedListBox
$CheckedListBoxPro.Location = New-Object System.Drawing.Size(20,120)
$CheckedListBoxPro.size = New-Object System.Drawing.Size(300,300)
$CheckedListBoxPro.CheckOnClick = $true
#$CheckedListBoxPro.Items.Add("Select All") > $null

# checkboxloadPro:
for ($I = 0; $I -lt $NTAPPServicesPro.Length; $I++)
{
    $CheckedListBoxPro.Items.add($NTAPPServicesPro[$I][0]) > $null
}

$CheckedListBoxPro.ClearSelected()
$CheckedListBoxPro.Add_click({
    If($this.selecteditem -eq 'Select All'){
        For($i=1;$i -lt $CheckedListBoxPro.Items.Count; $i++){
            $CheckedListBoxPro.SetItemChecked($i,$true)
        }
    }
})
$Form.Controls.Add($CheckedListBoxPro)

# Label checkboxloadPro
$checkboxloadProlbl = New-Object System.Windows.Forms.Label
$checkboxloadProlbl.Location = New-Object System.Drawing.Size(120,100) 
$checkboxloadProlbl.Size = New-Object System.Drawing.Size(120,60)
$checkboxloadProlbl.Text = "Production"

$Form.Controls.Add($checkboxloadProlbl)

# checkedListBoxMig
$CheckedListBoxMig = New-Object System.Windows.Forms.CheckedListBox
$CheckedListBoxMig.Location = New-Object System.Drawing.Size(350,120)
$CheckedListBoxMig.size = New-Object System.Drawing.Size(300,300)
$CheckedListBoxMig.CheckOnClick = $true
#$CheckedListBoxMig.Items.Add("Select All") > $null

# chdkboxloadMig
for ($I = 0; $I -lt $NTAPPServicesMig.Length; $I++)
{
    $CheckedListBoxMig.Items.add($NTAPPServicesMig[$I][0]) > $null
}

$CheckedListBoxMig.ClearSelected()
$CheckedListBoxMig.Add_click({
    If($this.selecteditem -eq 'Select All'){
        For($i=1;$i -lt $CheckedListBoxMig.Items.Count; $i++){
            $CheckedListBoxMig.SetItemChecked($i,$true)
        }
    }
})
$Form.Controls.Add($CheckedListBoxMig)

# Label checkboxloadPro
$checkboxloadMiglbl = New-Object System.Windows.Forms.Label
$checkboxloadMiglbl.Location = New-Object System.Drawing.Size(460,100) 
$checkboxloadMiglbl.Size = New-Object System.Drawing.Size(120,60)
$checkboxloadMiglbl.Text = "Migration"

$Form.Controls.Add($checkboxloadMiglbl)

# checkedBoxMig
$checkedBoxMig = New-Object System.Windows.Forms.CheckBox
$checkedBoxMig.Location = New-Object System.Drawing.Size(700,125)
$checkedBoxMig.size = New-Object System.Drawing.Size(100,20)
$checkedBoxMig.Text = "Migration"

$Form.Controls.Add($checkedBoxMig)

# checkedBoxPro
$checkedBoxPro = New-Object System.Windows.Forms.CheckBox
$checkedBoxPro.Location = New-Object System.Drawing.Size(700,100)
$checkedBoxPro.size = New-Object System.Drawing.Size(100,20)
$checkedBoxPro.Text = "Production"

$Form.Controls.Add($checkedBoxPro)

# execute button
$b1 = New-Object System.Windows.Forms.Button
$b1.Location = New-Object System.Drawing.Size(20,20)
$b1.Size = New-Object System.Drawing.Size(75,53)
$b1.Text = 'Generate Plans'
$b1.Add_Click({ processRelease($CheckedListBoxPro, $CheckedListBoxMig) })

$Form.Controls.Add($b1)

# defect number
$tbRelease = New-Object System.Windows.Forms.TextBox 
$tbRelease.Location = New-Object System.Drawing.Size(120,20) 
$tbRelease.Size = New-Object System.Drawing.Size(260,20)
 
$Form.Controls.Add($tbRelease) 

# Label Release part
$tbReleaselbl = New-Object System.Windows.Forms.Label
$tbReleaselbl.Location = New-Object System.Drawing.Size(380,20) 
$tbReleaselbl.Size = New-Object System.Drawing.Size(260,20)
$tbReleaselbl.Text = "Defect number?"

$Form.Controls.Add($tbReleaselbl) 


# iteration letter or what have you
$tbletterPart = New-Object System.Windows.Forms.TextBox 
$tbletterPart.Location = New-Object System.Drawing.Size(120,40) 
$tbletterPart.Size = New-Object System.Drawing.Size(60,20)

$Form.Controls.Add($tbletterPart) 

# Label letter part
$tbletterPartlbl = New-Object System.Windows.Forms.Label
$tbletterPartlbl.Location = New-Object System.Drawing.Size(180,44) 
$tbletterPartlbl.Size = New-Object System.Drawing.Size(60,20)
$tbletterPartlbl.Text = "A.B.C?"

$Form.Controls.Add($tbletterPartlbl) 

$Form.ShowDialog()

exit
