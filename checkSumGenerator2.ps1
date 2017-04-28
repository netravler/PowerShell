function CheckSum([string] $sentence)
{
	            # Start with first Item
				Write-Host $sentence
				write-host $sentence.IndexOf("$")								
				
	            [int] $checksum = [System.Convert]::ToByte($sentence[$sentence.IndexOf("$") + 1]);
	            #[int] $checksum = [System.Convert]::ToByte($sentence[$sentence.IndexOf('$')]);

				Write-Host $checksum
	            # Loop through all chars to get a checksum
				
				for ($i = $sentence.IndexOf('$') + 1; $i -lt $sentence.IndexOf("*"); $i++)
	            {
					Write-Host $sentence[$i]

	                # No. XOR the checksum with this character's value
	                $checksum = $checksum -bxor [System.Convert]::ToByte($sentence[$i]);
	            }
	            # Return the checksum formatted as a two-character hexadecimal
	            return $Checksum;
}

clear 

$output = Checksum 'GPRMC,155123.000,A,4043.8432,N,07359.7653,W,0.15,83.25,200407,,'

Write-Host $output