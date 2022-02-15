#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
#SingleInstance, force
#MaxHotkeysPerInterval 500
SetKeyDelay 50, 50
Menu, Tray, Icon, shell32.dll, 134

;----------------------------------------------------------
; Pause - конвертация последнего слова или выделенного текста
; RCtrl+T - транслитерация выделенного текста
; RCtrl+B - транслитерация буфера обмена
;----------------------------------------------------------
log:=1 ; - вести дневник
logfile:="Logs\Keys\" A_MM "." A_YYYY ".txt" ; - файл дневника
block:="Far 3,SciTE,AlReader,GoldenDict,PotPlayer,MPC-BE" ; - фрагменты заголовков окон программ-исключений дневника
cliplog:=1 ; - сохранять текстовый буфер обмена
cliplength:=1000 ; - обрезать до ... символов
ignor:="</h,</p>" ; - комбинации символов, при наличии которых буфер игнорируется
fkey:="Tab,Backspace,Enter,NumpadEnter,Escape" ; - завершающие клавиши, отображаемые в дневнике (см. переменную endkey)
;----------------------------------------------------------
endkey:="{Pause}{Space}{Enter}{NumpadEnter}{Tab}{Backspace}{Escape}{LControl}{RControl}{LAlt}{RAlt}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{Capslock}{Numlock}{PrintScreen}"
Eng=qwertyuiop[]asdfghjkl;'zxcvbnm,.QWERTYUIOP{}ASDFGHJKL:"ZXCVBNM<>
Rus=йцукенгшщзхъфывапролджэячсмитьбюЙЦУКЕНГШЩЗХЪФЫВАПРОЛДЖЭЯЧСМИТЬБЮ

if log
{
    SplitPath logfile, , dir
    FileCreateDir % dir
}
clip_old:=Clipboard

Loop
{
    WinGetTitle t, A
    Input text, i v, % endkey
    StringLen count, text
    e:=ErrorLevel
    if e=Endkey:Pause
        Translate()
    Log()
}

~LButton::
~RButton::
~MButton::
    Input
return

Translate()
{
    global
    clip:=Clipboard
    if (count>0)
        Send {BS %count%}
    else
    {
        Send ^{Ins}
        ClipWait 0.3
        if ! Errorlevel
        {
            Send {Del}
            text:=Clipboard
        }
        else
        {
            Tooltip Отмена невозможна, % A_CaretX,% A_CaretY
            Sleep 500
            ToolTip
            goto end
        }
    }
    r:=""
    Loop, parse,text
    {
        SendMessage, 0x50,, 0x4090409,, A ; Eng
        p := InStr(Eng, A_LoopField, true)
        if p > 0
            r := r . SubStr(Rus, p, 1)
        else
        {
            SendMessage, 0x50,, 0x4190419,, A ; Rus
            p := InStr(Rus, A_LoopField, true)
            if p > 0
                r := r . SubStr(Eng, p, 1)
            else
                r := r . A_LoopField
        }
    }
    PostMessage, 0x50, 2, 0,, A
    Send % r
end:
    text:=r
    Clipboard:=clip
return
}

Log()
{
    global
    if ! log
        return
    if t contains % block
        return
    if (count>0)
    {
        if (t<>tlast)
        {
            FileAppend % "`n`n" A_DD "." A_MM "." A_YYYY " " A_Hour ":" A_Min " (" t ")`n", % logfile
            tlast:=t
        }
        if e contains EndKey
            StringTrimLeft e, e, 7
        k:=" "
        if e contains % fkey
            k:=" {" e "} "
        if e contains Enter
            k:=k "`n"
        if e=NewInput
            k:=" {Click} "
        FileAppend % text . k , % logfile
    }
    cl:=Clipboard
    if ((cl<>clip_old) && (cl<>""))
    {
        if cl contains % ignor
            return
        StringLen l, cl
        end:=""
        if (l>cliplength)
            end:=" {...}"
        StringLeft cl, cl, % cliplength
        FileAppend % "`n`n### Clipboard (" t ")`n" cl . end "`n###`n", % logfile

    }
    clip_old:=cl
return
}

;------ Translit ------
>^vk42::
    Translit()
    MsgBox, 64, Translit, Текст в буфере!, 1
return

>^vk54::
    Translit()
    Send {Del}
    Sleep 200
    Send ^{vk56}
return

Translit()
{
    KeyWait RCtrl
    ClipBoard := ""
    Send ^{Ins}
    ClipWait 2
    x:=ClipBoard

    StringReplace, x, x, а , a , All
    StringReplace, x, x, б , b , All
    StringReplace, x, x, в , v , All
    StringReplace, x, x, г , g , All
    StringReplace, x, x, д , d , All
    StringReplace, x, x, е , e , All
    StringReplace, x, x, ё , yo , All
    StringReplace, x, x, ж , zh , All
    StringReplace, x, x, з , z , All
    StringReplace, x, x, и , i , All
    StringReplace, x, x, й , j , All
    StringReplace, x, x, к , k , All
    StringReplace, x, x, л , l , All
    StringReplace, x, x, м , m , All
    StringReplace, x, x, н , n , All
    StringReplace, x, x, о , o , All
    StringReplace, x, x, п , p , All
    StringReplace, x, x, р , r , All
    StringReplace, x, x, с , s , All
    StringReplace, x, x, т , t , All
    StringReplace, x, x, у , u , All
    StringReplace, x, x, ф , f , All
    StringReplace, x, x, х , kh , All
    StringReplace, x, x, ц , ts , All
    StringReplace, x, x, ч , ch , All
    StringReplace, x, x, ш , sh , All
    StringReplace, x, x, щ , shh , All
    StringReplace, x, x, ъ , " , All
    StringReplace, x, x, ы , y , All
    StringReplace, x, x, ь , ' , All
    StringReplace, x, x, э , eh , All
    StringReplace, x, x, ю , yu , All
    StringReplace, x, x, я , ya , All

    StringReplace, x, x, А , A , All
    StringReplace, x, x, Б , B , All
    StringReplace, x, x, В , V , All
    StringReplace, x, x, Г , G , All
    StringReplace, x, x, Д , D , All
    StringReplace, x, x, Е , E , All
    StringReplace, x, x, Ё , Yo , All
    StringReplace, x, x, Ж , Zh , All
    StringReplace, x, x, З , Z , All
    StringReplace, x, x, И , I , All
    StringReplace, x, x, Й , J , All
    StringReplace, x, x, К , K , All
    StringReplace, x, x, Л , L , All
    StringReplace, x, x, М , M , All
    StringReplace, x, x, Н , N , All
    StringReplace, x, x, О , O , All
    StringReplace, x, x, П , P , All
    StringReplace, x, x, Р , R , All
    StringReplace, x, x, С , S , All
    StringReplace, x, x, Т , T , All
    StringReplace, x, x, У , U , All
    StringReplace, x, x, Ф , F , All
    StringReplace, x, x, Х , Kh , All
    StringReplace, x, x, Ц , Ts , All
    StringReplace, x, x, Ч , Ch , All
    StringReplace, x, x, Ш , Sh , All
    StringReplace, x, x, Щ , Shh , All
    StringReplace, x, x, Ъ , " , All
    StringReplace, x, x, Ы , Y , All
    StringReplace, x, x, Ь , ' , All
    StringReplace, x, x, Э , Eh , All
    StringReplace, x, x, Ю , Yu , All
    StringReplace, x, x, Я , Ya , All

return Clipboard:=x
}