@echo off

REM バッチファイルの実行時刻を取得する
setlocal enabledelayedexpansion
set EXEC_DATE=%date:~-10,4%%date:~-5,2%%date:~-2,2%
set EXEC_TIME=%time: =0%
set EXEC_TIME=%EXEC_TIME:~0,2%%EXEC_TIME:~3,2%%EXEC_TIME:~6,2%

REM 一時ファイル用のパスを作成する
set EVENTLOG_LIST=%~dp0\eventlog_%EXEC_DATE%%EXEC_TIME%.list
if exist %EVENTLOG_LIST% ( del %EVENTLOG_LIST% )

REM 全てのイベントログの名前をファイルに出力する
wevtutil el > %EVENTLOG_LIST%
if not "%ERRORLEVEL%" == "0" (
  echo ERROR: Failed to get event list : %EVENTLOG_LIST%
  exit /b 1
)

REM ファイルを参照して、イベントログをクリアする
for /f "delims=" %%a in (%EVENTLOG_LIST%) do (
  wevtutil cl "%%a"
  if not "%ERRORLEVEL%" == "0" (
    echo ERROR: Failed to clear event log : "%%a"
    if exist %EVENTLOG_LIST% ( del %EVENTLOG_LIST% )
    exit /b 1
  )
)

REM 一時ファイルを削除する
if exist %EVENTLOG_LIST% ( del %EVENTLOG_LIST% )

exit /b 0