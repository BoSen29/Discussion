Get-UDDashboard | Stop-UDDashboard

$dashboard = New-UDDashboard -title "UD" -Content {
    #top anchor
    New-UDElement -Tag span -Id "firstAnchor"
    New-UDRow -Id "first" -Endpoint {
        foreach ($stuff in 1 .. 8 ) {
            New-UDMuButton -Text $stuff -Variant flat -OnClick {
                Select-UDElement -id "Row$stuff" -scrollToElement
                Show-UDToast "Row$stuff"
            }
        }
    }
    foreach ($stuff in 1 .. 8 ) {
        foreach ($stuff2 in 1 .. 20)    {
            New-UDElement -Tag "p" -id "Row$stuff" -Content {
                "Lorem Ipsum $stuff $stuff2"
            }
        }
        New-UDButton -Text "ToTop" -OnClick {
            Select-UDElement -id "firstAnchor" -ScrollToElement
            Show-UDToast "To the top!"
        } 
    }
}

Start-UDDashboard -Dashboard $dashboard -Port 8083
