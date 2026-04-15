#!/bin/bash
# Hook: 파이프라인 진행 상태 체크
# PreToolUse: Write, Edit 에서 실행
# 소스코드 수정 시 활성 태스크 폴더 + plan 승인 여부 확인
# exit 1 = 차단, exit 0 = 통과

HOOK_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$HOOK_DIR/../.." && pwd)"
PLANS_DIR="$PROJECT_ROOT/docs/plans/active"

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"//')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# 파이프라인/문서/설정 파일은 체크 제외
if echo "$FILE_PATH" | grep -qE '(docs/|\.harness/|\.claude/|CLAUDE\.md|ARCHITECTURE\.md|README\.md)'; then
  exit 0
fi

# 소스코드 파일만 체크
if ! echo "$FILE_PATH" | grep -qE '\.(java|groovy|py|ts|tsx|js|jsx|go|rs|rb|php|swift|kt|scala|c|cpp|h|hpp|cs|jsp|vue|svelte|css|scss|xml|properties|yaml|yml|sql|graphql)$'; then
  exit 0
fi

# 활성 태스크 폴더 확인
ACTIVE_TASKS=$(find "$PLANS_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')

if [ "$ACTIVE_TASKS" -eq 0 ]; then
  echo "BLOCKED: 활성 태스크 폴더가 없습니다. 파이프라인을 먼저 시작하세요."
  echo ""
  echo "→ .harness/pipeline/README.md를 읽고 Step 1(분석)부터 시작하세요."
  echo "→ 태스크 폴더 생성: docs/plans/active/{YYYYMMDD}-{설명}/"
  echo ""
  echo "파이프라인 불필요 시 (단순 수정): 빈 태스크 폴더를 생성하고 00-input.md에 사유를 기록하세요."
  exit 1
fi

LATEST_TASK=$(ls -dt "$PLANS_DIR"/*/ 2>/dev/null | head -1)

if [ -z "$LATEST_TASK" ]; then
  exit 0
fi

PLAN_FILE="$LATEST_TASK/02-plan.md"

if [ ! -f "$PLAN_FILE" ]; then
  echo "BLOCKED: 계획(02-plan.md)이 아직 작성되지 않았습니다."
  echo "현재 태스크: $(basename "$LATEST_TASK")"
  echo ""
  echo "→ Step 1(분석) 완료 후 Step 2(계획)를 먼저 진행하세요."
  exit 1
fi

if ! grep -q "APPROVED" "$PLAN_FILE"; then
  echo "BLOCKED: 계획이 아직 승인되지 않았습니다."
  echo "현재 태스크: $(basename "$LATEST_TASK")"
  echo ""
  echo "→ 02-plan.md를 사용자에게 제시하고 승인을 받으세요."
  exit 1
fi

if grep -A50 "선행 작업" "$PLAN_FILE" 2>/dev/null | grep -q '\- \[ \]'; then
  echo "BLOCKED: 선행 수동 작업이 아직 완료되지 않았습니다."
  echo "현재 태스크: $(basename "$LATEST_TASK")"
  echo ""
  echo "→ 02-plan.md의 '선행 작업' 섹션에서 미완료 항목을 확인하세요."
  exit 1
fi

exit 0
