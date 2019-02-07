$ComputerName = 'test'
slmgr.vbs $ComputerName /dli #show current license information
#slmgr.vbs $ComputerName /dlv #show current license more information
#slmgr.vbs $ComputerName /xpr #shows expiration date of current license state if Windows is not permanently activated
#slmgr.vbs $ComputerName /ato #activate Windows license 
#slmgr.vbs $ComputerName /rearm #reset the licensing status and activation state of the machine
#slmgr.vbs $ComputerName /ipk <xxxxx-xxxxx-xxxxx-xxxxx-xxxxx> #enter a new or replace and change the current product key 
#slmgr.vbs $ComputerName /skms activationservername:port #set the KMS server and the port used for KMS activation for Windows 