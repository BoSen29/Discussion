$Theme = New-UDTheme -Name "test" -Definition @{'label > span' = @{'background-color' = 'blue'}}

$dashboard = New-UDDashboard -title "UDBOI" -Content {
    New-UDCard -Id "Card" -Title "Buttons" -titlealignment "right" -Content {
        New-UDRadio -WithGap -Label "Hi" -Group 1
        New-UDRadio -WithGap -Label "Hi1" -Group 1
        New-UDRadio -WithGap -Label "Hi2" -Group 1
    }

} -theme $Theme

Start-UDDashboard -Dashboard $dashboard -Port 8083
