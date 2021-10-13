for /f "usebackq tokens=*" %%a in (`"%job%"`) do @cecho {0A}%%a{\n}{0B}&&"%%a" -version
pause