#!/bin/bash
# Hook: 리뷰 게이트 체크
# PreToolUse: Write 에서 실행
# 05-summary.md 생성 시 03-review.md + 04-verify.md 존재 확인
# exit 1 = 차단, exit 0 = 통과

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"//')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if ! echo "$FILE_PATH" | grep -q "05-summary.md"; then
  exit 0
fi

TASK_DIR=$(dirname "$FILE_PATH")
REVIEW_FILE="$TASK_DIR/03-review.md"
VERIFY_FILE="$TASK_DIR/04-verify.md"

if [ ! -f "$REVIEW_FILE" ]; then
  echo "BLOCKED: 리뷰(03-review.md)가 수행되지 않았습니다."
  echo ""
  echo "→ Step 4(리뷰)를 먼저 진행하세요."
  exit 1
fi

if [ ! -f "$VERIFY_FILE" ]; then
  echo "BLOCKED: 검증(04-verify.md)이 수행되지 않았습니다."
  echo ""
  echo "→ Step 5(검증)를 먼저 진행하세요."
  exit 1
fi

exit 0
