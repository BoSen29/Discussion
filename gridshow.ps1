$dash = New-UDDashboard -Title "Test" -Content {
    New-UDInput -Title "Computer Lookup"  -Endpoint {
        param($user)
        $search = "*$user*"
    
        $session:griddata = [PSCustomObject]@{
            Name = "BoSen29"
            Description = "Dude"
        } | Select-Object Name, Description
        Sync-UDElement -id "GridContainer"
        New-UDInputAction -ClearInput           
    }
    New-UDElement -tag span -id "GridContainer" -Endpoint {
        if ($null -ne $session:griddata) {
            New-UDGrid -Title "Results" -id "ResultsGrid" -headers @("Computer Name", "Description") -properties @("Name","Description") -endpoint {
                $session:griddata |  Out-UDGridData
            }
        }

    }    
    
    New-UDButton -Text "RemoveMe" -OnClick {
        $session:griddata = $null
        Sync-UDElement -id "GridContainer"
    }
}
Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $dash
