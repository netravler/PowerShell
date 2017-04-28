# https://blogs.msdn.microsoft.com/powershell/2009/01/10/get-usb-using-wmi-association-classes-in-powershell/
# https://blogs.technet.microsoft.com/heyscriptingguy/2013/08/27/powertip-show-attached-usb-drives-with-powershell/
# http://www.leeholmes.com/blog/2010/03/02/responding-to-usb-devices-in-powershell/

function Get-USB {
           
    #.Synopsis
    #    Gets USB devices attached to the system
    #.Description
    #    Uses WMI to get the USB Devices attached to the system
    #.Example
    #    Get-USB
    #.Example
    #    Get-USB | Group-Object Manufacturer  
    Get-WmiObject Win32_USBControllerDevice | Foreach-Object { [Wmi]$_.Dependent }
	#GET-WMIOBJECT win32_diskdrive | Where { $_.InterfaceType –eq ‘USB’ }

}

clear

Get-USB
