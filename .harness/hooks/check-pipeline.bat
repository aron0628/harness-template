@echo off
setlocal enabledelayedexpansion
REM Hook: 파이프라인 진행 상태 체크
REM PreToolUse: Write, Edit 에서 실행
REM 소스코드 수정 시 활성 태스크 폴더 + plan 승인 여부 확인
REM exit 1 = 차단, exit 0 = 통과

set "HOOK_DIR=%~dp0"
for %%i in ("%HOOK_DIR%..\..\") do set "PROJECT_ROOT=%%~fi"
set "PLANS_DIR=%PROJECT_ROOT%docs\plans\active"

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

REM 파이프라인/문서/설정 파일은 체크 제외
echo !FILE_PATH! | findstr /i "docs\ .harness\ .claude\ CLAUDE.md ARCHITECTURE.md README.md" >nul 2>&1
if !errorlevel! equ 0 exit /b 0

REM 소스코드 파일만 체크
echo !FILE_PATH! | findstr /i "\.java \.groovy \.jsp \.js \.css \.xml \.properties \.yaml \.yml \.sql" >nul 2>&1
if !errorlevel! neq 0 exit /b 0

REM 활성 태스크 폴더 확인
set "ACTIVE_COUNT=0"
if exist "%PLANS_DIR%" (
    for /d %%d in ("%PLANS_DIR%\*") do set /a ACTIVE_COUNT+=1
)

if !ACTIVE_COUNT! equ 0 (
    echo BLOCKED: 활성 태스크 폴더가 없습니다. 파이프라인을 먼저 시작하세요.
    echo.
    echo → .harness\pipeline\README.md를 읽고 Step 1^(분석^)부터 시작하세요.
    echo → 태스크 폴더 생성: docs\plans\active\{YYYYMMDD}-{설명}\
    echo.
    echo 파이프라인 불필요 시: 빈 태스크 폴더를 생성하고 00-input.md에 사유를 기록하세요.
    exit /b 1
)

REM 가장 최근 태스크 폴더 찾기
set "LATEST_TASK="
for /d %%d in ("%PLANS_DIR%\*") do set "LATEST_TASK=%%d"

if "!LATEST_TASK!"=="" exit /b 0

REM 02-plan.md 존재 및 APPROVED 마커 확인
set "PLAN_FILE=!LATEST_TASK!\02-plan.md"

if not exist "!PLAN_FILE!" (
    echo BLOCKED: 계획^(02-plan.md^)이 아직 작성되지 않았습니다.
    echo → Step 1^(분석^) 완료 후 Step 2^(계획^)를 먼저 진행하세요.
    exit /b 1
)

findstr /i "APPROVED" "!PLAN_FILE!" >nul 2>&1
if !errorlevel! neq 0 (
    echo BLOCKED: 계획이 아직 승인되지 않았습니다.
    echo → 02-plan.md를 사용자에게 제시하고 승인을 받으세요.
    exit /b 1
)

REM 선행 작업 미완료 체크
findstr /c:"- [ ]" "!PLAN_FILE!" >nul 2>&1
if !errorlevel! equ 0 (
    findstr /i "선행" "!PLAN_FILE!" >nul 2>&1
    if !errorlevel! equ 0 (
        echo BLOCKED: 선행 수동 작업이 아직 완료되지 않았습니다.
        echo → 02-plan.md의 선행 작업 섹션에서 미완료 항목을 확인하세요.
        exit /b 1
    )
)

exit /b 0
