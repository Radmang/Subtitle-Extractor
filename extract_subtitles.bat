@echo off
setlocal enabledelayedexpansion

REM Loop until the user chooses to exit
:loop

REM Clear the console
cls

REM Prompt the user to enter the directory path
set /p "directory=Enter the directory path (or type 'q' to quit): "

REM Check if the user wants to exit
if /I "%directory%"=="q" goto :eof

REM List of video file extensions to process
set "extensions=.mp4 .avi .mkv"

REM Iterate over each video file with the specified extensions in the directory
for %%F in ("%directory%\*") do (
    REM Check if the file extension is in the allowed list
    set "ext=%%~xF"
    if "!extensions:%%~xF=!" neq "!extensions!" (
        REM Extract the filename without the extension
        set "filename=%%~nF"

        REM Run FFmpeg command to extract subtitles and convert to SRT format
        ffmpeg -i "%%F" -map 0:s:0 -c:s srt "!directory!\!filename!.srt"
    )
)

REM Go back to the beginning of the loop
goto :loop