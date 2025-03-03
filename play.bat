@echo off
setlocal enabledelayedexpansion

:: Nastavte cestu k playlist.txt
set "playlist_file=playlist.txt"

:: Predvolené rozlíšenie je 720p
set "resolution=720p"

:: Skontrolujte, či bol zadaný argument (rozlíšenie)
if not "%~1"=="" set "resolution=%~1"

:: Overte, či je rozlíšenie platné (podporované hodnoty: 1080p, 720p, 480p)
if /i not "%resolution%"=="1080p" if /i not "%resolution%"=="720p" if /i not "%resolution%"=="480p" (
    echo Neplatne rozlisenie: %resolution%
    echo Podporovane rozlisenia: 1080p, 720p, 480p
    exit /b 1
)

:: Skontrolujte, či bol zadaný argument pre priečinok
set "video_folder="
if not "%~2"=="" set "video_folder=%~2"

:: Ak bol zadaný priečinok, skontrolujte jeho existenciu
if not "%video_folder%"=="" if not exist "%video_folder%" (
    echo Priečinok "%video_folder%" neexistuje!
    exit /b 1
)

:: Nastavenie parametrov podľa rozlíšenia
if /i "%resolution%"=="1080p" (
    set "bitrate=8000k"
    set "maxrate=8000k"
    set "bufsize=16000k"
    set "scale=-s 1920x1080"
) else if /i "%resolution%"=="720p" (
    set "bitrate=3000k"
    set "maxrate=3000k"
    set "bufsize=6000k"
    set "scale=-s 1280x720"
) else if /i "%resolution%"=="480p" (
    set "bitrate=1500k"
    set "maxrate=1500k"
    set "bufsize=3000k"
    set "scale=-s 854x480"
)

:: Začnite vytvárať príkaz pre ffmpeg s viacerými vstupmi
set "ffmpeg_command=ffmpeg -re -hwaccel cuda"

:: Vytvorte dočasný súbor pre zoznam vstupov
set "input_list=input_files.txt"
if exist %input_list% del %input_list%

:: Ak bol zadaný priečinok, vyhľadaj súbory a ulož ich do input_files.txt
if not "%video_folder%"=="" (
    for %%F in ("%video_folder%\*.mov" "%video_folder%\*.mkv" "%video_folder%\*.mp4" "%video_folder%\*.avi") do (
        echo file '%%F' >> %input_list%
    )
) else (
    :: Ak priečinok nebol zadaný, načítaj súbory z playlist.txt
    for /f "tokens=*" %%a in (%playlist_file%) do (
        echo file '%%a' >> %input_list%
    )
)

:: Skontroluj, či sa do input_files.txt pridali nejaké súbory
if not exist %input_list% (
    echo Ziadne platne video subory na streamovanie!
    exit /b 1
)

:: Zobrazte použité video súbory
echo Pouzite video subory:
type %input_list%
pause


:: Nastavenie príkazu ffmpeg podľa rozlíšenia
set "ffmpeg_command=!ffmpeg_command! -f concat -safe 0 -i %input_list% -c:v h264_nvenc -preset p1 -b:v %bitrate% -maxrate %maxrate% -bufsize %bufsize% -pix_fmt yuv420p -g 60 -keyint_min 60 -r 60 -profile:v main %scale% -c:a aac -b:a 128k -ar 48000 -ac 2 -f flv rtmp://rtmp.stream.homelab.quickbiteschronicles.com/live/test"

:: Spustite ffmpeg príkaz
echo Spustenie ffmpeg príkazu s rozlíšením %resolution%:
echo !ffmpeg_command!
!ffmpeg_command!

:: Odstráňte dočasný súbor
del %input_list%

endlocal
