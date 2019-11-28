New-UDDashboard -Title "Test" -Content {
    if ( $session:showmismatch -match $true) {
        New-UDSwitch -Id "MismatchSwitch" -OnText "Mismatch" -OffText "All" -On -OnChange {
            if ($eventdata -match $true) {
                $session:showmismatch = $true
            }
            else {
                $session:showmismatch = $false
            }
            Sync-UDElement -Id "UserTable"
        }
    }
    else {
        New-UDSwitch -Id "MismatchSwitch" -OnText "Mismatch" -OffText "All" -OnChange {
            if ($eventdata -match $true) {
                $session:showmismatch = $true
            }
            else {
                $session:showmismatch = $false
            }
            Sync-UDElement -Id "UserTable"
        }
    }

    New-UDElement -Id "UserTable" -tag "UserTable" -Endpoint {
        if ( $session:showmismatch -ne $true) {
            New-UDGrid -id "UserTableTable" -Headers @('Company', 'Users') -Properties @('clientName', 'users') -pagesize 15 -Endpoint {
                $cache:usertable | ForEach-Object {
                    [PSCustomObject]@{
                        clientName = $_.clientName
                        users = $_.users
                    }
                } | Out-UDGridData
            }
        }
        else {
            New-UDGrid -id "Mismatchboi" -Headers @('Company', 'Users') -Properties @('clientName', 'users') -pagesize 15 -Endpoint {
                $cache:usertable | ForEach-Object {
                    [PSCustomObject]@{
                        clientName = $_.clientName
                        users = $_.users
                    }
                } | Out-UDGridData
            }
        }                                   
    }
}

