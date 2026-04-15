@echo off
setlocal enabledelayedexpansion
REM Hook: 스텝 간 산출물 체인 게이트
REM PreToolUse: Write 에서 실행
REM 각 스텝의 산출물 작성 시 이전 스텝 산출물이 존재하는지 확인
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

REM plans/active 내의 파이프라인 산출물만 체크
echo !FILE_PATH! | findstr /i "docs\plans\active\" >nul 2>&1
if !errorlevel! neq 0 exit /b 0

for %%f in ("!FILE_PATH!") do (
    set "TASK_DIR=%%~dpf"
    set "FILENAME=%%~nxf"
)

REM 02-plan.md 작성 시 → 01-analysis.md 필요
if "!FILENAME!"=="02-plan.md" (
    if not exist "!TASK_DIR!01-analysis.md" (
        echo BLOCKED: 분석^(01-analysis.md^)이 아직 작성되지 않았습니다.
        echo → Step 1^(분석^)을 먼저 완료하세요.
        echo → .harness\pipeline\steps\01-analyze.md 지침을 따르세요.
        exit /b 1
    )
)

REM 03-review.md 작성 시 → 02-plan.md APPROVED 필요
if "!FILENAME!"=="03-review.md" (
    if not exist "!TASK_DIR!02-plan.md" (
        echo BLOCKED: 계획^(02-plan.md^)이 아직 작성되지 않았습니다.
        echo → Step 2^(계획^)를 먼저 완료하세요.
        exit /b 1
    )
    findstr /i "APPROVED" "!TASK_DIR!02-plan.md" >nul 2>&1
    if !errorlevel! neq 0 (
        echo BLOCKED: 계획^(02-plan.md^)이 아직 승인되지 않았습니다.
        echo → 사용자에게 계획 승인을 받으세요.
        exit /b 1
    )
)

REM 04-verify.md 작성 시 → 03-review.md 필요
if "!FILENAME!"=="04-verify.md" (
    if not exist "!TASK_DIR!03-review.md" (
        echo BLOCKED: 리뷰^(03-review.md^)가 아직 수행되지 않았습니다.
        echo → Step 4^(리뷰^)를 먼저 완료하세요.
        echo → Claude 자체 리뷰 + Codex 리뷰 수행 후 진행하세요.
        exit /b 1
    )
)

REM 05-summary.md 작성 시 → 03-review.md + 04-verify.md 필요
if "!FILENAME!"=="05-summary.md" (
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
)

exit /b 0
