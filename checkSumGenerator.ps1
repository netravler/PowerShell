# http://stackoverflow.com/questions/2143460/methods-to-convert-c-sharp-code-to-a-powershell-script

$Csharp = @"
using System;

namespace NMEA
{
	public class Checksum
	{
	        public static string getChecksum(string sentence)
	        {
	            //Start with first Item
	            int checksum = Convert.ToByte(sentence[sentence.IndexOf('$') + 1]);
	            // Loop through all chars to get a checksum
	            for (int i = sentence.IndexOf('$') + 2; i < sentence.IndexOf('*'); i++)
	            {
	                // No. XOR the checksum with this character's value
	                checksum ^= Convert.ToByte(sentence[i]);
	            }
	            // Return the checksum formatted as a two-character hexadecimal
	            return checksum.ToString("X2");
	        }
	}
}
"@

clear

Add-Type -TypeDefinition $Csharp  

$whatDidIGet = [NMEA.Checksum]::getChecksum("$PICOA,08,90,POM,0*")

Write-Host $whatDidIGet
