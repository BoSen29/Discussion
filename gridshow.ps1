New-UDInput -Title "Computer Lookup"  -Endpoint {
    param($user)
    $search = "*$user*"

    $session:griddata = (get-adcomputer -properties * -filter { Description -like $search } | Select-Object Name, Description) 
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
