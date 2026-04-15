@echo off
setlocal enabledelayedexpansion
REM Hook: 리뷰 게이트 체크
REM PreToolUse: Write 에서 실행
REM 05-summary.md 생성 시 03-review.md + 04-verify.md 존재 확인
REM exit 1 = 차단, exit 0 = 통과

REM stdin에서 file_path 추출
set "INPUT="
for /f "delims=" %%i in ('more') do set "INPUT=!INPUT!%%i"

set "FILE_PATH="
for /f "tokens=2 delims=:" %%a in ('echo !INPUT! ^| findstr /i "file_path"') do (
    set "RAW=%%a"
    set "RAW=!RAW:"=!"
    set "RAW=!RAW: =!"
    set "RAW=!RAW:,=!"
    set "FILE_PATH=!RAW!"
)

if "!FILE_PATH!"=="" exit /b 0

REM 05-summary.md 생성 시에만 체크
echo !FILE_PATH! | findstr /i "05-summary.md" >nul 2>&1
if !errorlevel! neq 0 exit /b 0

REM 같은 태스크 폴더에서 확인
for %%f in ("!FILE_PATH!") do set "TASK_DIR=%%~dpf"

if not exist "!TASK_DIR!03-review.md" (
    echo BLOCKED: 리뷰^(03-review.md^)가 수행되지 않았습니다.
    echo → Step 4^(리뷰^)를 먼저 진행하세요.
    exit /b 1
)

if not exist "!TASK_DIR!04-verify.md" (
    echo BLOCKED: 검증^(04-verify.md^)이 수행되지 않았습니다.
    echo → Step 5^(검증^)를 먼저 진행하세요.
    exit /b 1
)

exit /b 0
