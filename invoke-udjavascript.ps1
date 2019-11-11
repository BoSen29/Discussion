Import-Module C:\temp\dev\universal-dashboard\src\output\UniversalDashboard.psm1

Get-UDDashboard | Stop-UDDashboard
Enable-UDLogging -filepath "C:\temp\dev\testdash\verbose.txt" -level "debug"
$dashboard = New-UDDashboard -title "Calendar" -Content {
    New-UDCard -Id "ButtonCard" -Title "Buttons" -titlealignment "center" -Content {

    }
    New-UDButton -Text "OtherGetDate" -OnClick {
        #Get-UDCalElement returns a preformatted DateTime object, instead of manually formatting it yourself.
        Invoke-UDJavaScript -jsscript "alert('hellobois');"
    }
}

Start-UDDashboard -Dashboard $dashboard -Port 8083
