@echo off
setlocal enabledelayedexpansion
REM Hook: 보호 파일 수정 차단 (FRM-01~11)
REM PreToolUse: Write, Edit 에서 실행
REM exit 1 = 차단, exit 0 = 통과

set "HOOK_DIR=%~dp0"
set "PROTECTED_LIST=%HOOK_DIR%protected-files.txt"

REM stdin에서 file_path 추출
set "INPUT="
for /f "delims=" %%i in ('more') do set "INPUT=!INPUT!%%i"

REM file_path 파싱
set "FILE_PATH="
for /f "tokens=2 delims=:" %%a in ('echo !INPUT! ^| findstr /i "file_path"') do (
    set "RAW=%%a"
    set "RAW=!RAW:"=!"
    set "RAW=!RAW: =!"
    set "RAW=!RAW:,=!"
    set "FILE_PATH=!RAW!"
)

if "!FILE_PATH!"=="" exit /b 0

REM protected-files.txt 확인
if not exist "%PROTECTED_LIST%" exit /b 0

for /f "usebackq eol=# tokens=*" %%p in ("%PROTECTED_LIST%") do (
    set "PATTERN=%%p"
    if not "!PATTERN!"=="" (
        echo !FILE_PATH! | findstr /i "!PATTERN!" >nul 2>&1
        if !errorlevel! equ 0 (
            echo BLOCKED: 이 파일은 수정 금지입니다 ^(harness FRM 규칙 위반^)
            echo 대상: !FILE_PATH!
            echo 매칭 패턴: !PATTERN!
            echo → .harness\pipeline\rules.md의 프레임워크 보호 섹션을 확인하세요.
            exit /b 1
        )
    )
)

exit /b 0
