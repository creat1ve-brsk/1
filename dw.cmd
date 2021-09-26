setlocal enableextensions enabledelayedexpansion
@ECHO OFF
cd "%~dp0"
set filler={\n}{0F}################################################################################{#}
set LIST=
set LISTv=
for %%a in (*.torrent) do (
    set LIST=!LIST! "%%a"
    set LISTv=!LISTv!%filler%{0E}"%%a"
)
cecho {0A}{\n}{\n}%LIST%{\n}{\n}
cecho {0C}{\n}{\n}%LISTv%{\n}{\n}

rem echo %filler%

chcp 1251 >NUL
cecho {0B}{\n}{\n}{\n}{\n}Будет загружен следующий список торрент файлов:{0E}{\n}{\n}%LISTv%%filler%{0D}{\n}{\n}Нажмите любую кнопку для запуска aria2c{#}{\n}{\n}
rem echo %LIST%
rem echo "%LIST%"
pause >NUL
rem sleep 2s && "D:\AHKv2\scripts\shlak\webui-aria2-master\docs\index.html"
rem sleep 2s && "D:\AHKv2\scripts\shlak\webui-aria2-master\docs\index.html"
rem -j 5 -x 5 -s 5 -k 1M
rem start "" "%ComSpec%" /c npm node-server.js & pause
rem start "" "%ComSpec%" /c sleep 10s && "D:\AHKv2\scripts\shlak\webui-aria2-master\docs\index.html"
aria2c %LIST% -d "%CD%" --conf-path=aria2.conf --enable-rpc=true --rpc-listen-all=true --rpc-allow-origin-all=true -c
