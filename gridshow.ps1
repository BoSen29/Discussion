New-UDInput -Title "Computer Lookup"  -Endpoint {
    param($user)
    $search = "*$user*"

    $session:griddata = (get-adcomputer -properties * -filter { Description -like $search } | Select-Object Name, Description) 
    Sync-UDElement -id "ResultsGrid"
    New-UDInputAction -ClearInput           
}

New-UDGrid -Title "Results" -id "ResultsGrid" -headers @("Computer Name", "Description") -properties @("Name","Description") -endpoint {
    $session:griddata |  Out-UDGridData
}
