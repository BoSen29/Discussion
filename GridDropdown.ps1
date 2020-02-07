New-UDPage -Name "Utilization Metrics Testing" -AuthorizedRole "Administrator" -Content {
    New-UDCard -Title "Pick a Server to Monitor" -Content {
      #$strCategory = "computer" 
      $strOperatingSystem = "Windows*Server*" 
      $objDomain = New-Object System.DirectoryServices.DirectoryEntry("LDAP://DC=domain,DC=local,DC=com") 
      $objSearcher = New-Object System.DirectoryServices.DirectorySearcher 
      $objSearcher.SearchRoot = $objDomain 
      $objSearcher.Filter = ("OperatingSystem=$strOperatingSystem") 
      $colProplist = "name" 
      foreach ($i in $colPropList){$objSearcher.PropertiesToLoad.Add($i)} 
      $colResults = $objSearcher.FindAll() 
      $ServerList = @() 
      foreach ($objResult in $colResults) 
      { 
          $objComputer = $objResult.Properties;  
          $ServerList += $objComputer.name 
      }
      New-UDSelect -Label "Server Select" -Option {
          foreach ($serv in $ServerList){
              New-UDSelectOption -Name "$serv" -Value "$serv"
          }
      } -OnChange {
          #Show-UDToast -Message $EventData ##Testing
          $Session:activeServer = [string]$Server
          Sync-UDElement -Id "Syncable"          
      }
      New-UDElement -Tag span -Id "Syncable" -Endpoint {
          if ($Session:activeServer) {
            New-UDGrid -Title "Disk Statistics for $($Session:activeServer)" -Headers @("Drive", "Total size (GB)", "Free Space (GB)", "Free Space (%)","Name") -Properties @("Drive","Total_Size_GB","Free_Space_GB","Free_Space_percent","volumename") -Endpoint{
                $Disks = Get-wmiobject  Win32_LogicalDisk -computername "$($Session:activeServer).as.tamu.edu" -filter "DriveType= 3" 
                $GridData = @()
                foreach ($objdisk in $Disks){   
                    $total="{0:N0}" -f ($objDisk.Size/1GB)  
                    $free=($objDisk.FreeSpace/1GB)  
                    $freePercent="{0:P0}" -f ([double]$objDisk.FreeSpace/[double]$objDisk.Size)  
                    $GridObject = New-Object PSObject -Property @{Drive = $objDisk.DeviceID; Total_Size_GB = 
                    $total; Free_Space_GB = $free; Free_Space_percent = $freePercent; volumename = $objdisk.VolumeName}
                    $GridData += $GridObject
                } 
                $GridData | Out-UDGridData 
            } 
          }
      }
    }
  }
