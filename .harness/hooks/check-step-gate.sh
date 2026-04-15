#!/bin/bash
# Hook: 스텝 간 산출물 체인 게이트
# PreToolUse: Write 에서 실행
# 각 스텝의 산출물 작성 시 이전 스텝 산출물 존재 확인
# exit 1 = 차단, exit 0 = 통과

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"//')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if ! echo "$FILE_PATH" | grep -q "docs/plans/active/"; then
  exit 0
fi

TASK_DIR=$(echo "$FILE_PATH" | sed 's|\(docs/plans/active/[^/]*/\).*|\1|')
FILENAME=$(basename "$FILE_PATH")

case "$FILENAME" in
  "02-plan.md")
    if [ ! -f "${TASK_DIR}01-analysis.md" ]; then
      echo "BLOCKED: 분석(01-analysis.md)이 아직 작성되지 않았습니다."
      echo ""
      echo "→ Step 1(분석)을 먼저 완료하세요."
      echo "→ .harness/pipeline/steps/01-analyze.md 지침을 따르세요."
      exit 1
    fi
    ;;
  "03-review.md")
    if [ ! -f "${TASK_DIR}02-plan.md" ]; then
      echo "BLOCKED: 계획(02-plan.md)이 아직 작성되지 않았습니다."
      echo "→ Step 2(계획)를 먼저 완료하세요."
      exit 1
    fi
    if ! grep -q "APPROVED" "${TASK_DIR}02-plan.md"; then
      echo "BLOCKED: 계획(02-plan.md)이 아직 승인되지 않았습니다."
      echo "→ 사용자에게 계획 승인을 받으세요."
      exit 1
    fi
    ;;
  "04-verify.md")
    if [ ! -f "${TASK_DIR}03-review.md" ]; then
      echo "BLOCKED: 리뷰(03-review.md)가 아직 수행되지 않았습니다."
      echo ""
      echo "→ Step 4(리뷰)를 먼저 완료하세요."
      echo "→ .harness/pipeline/steps/04-review.md 지침을 따르세요."
      exit 1
    fi
    ;;
  "05-summary.md")
    if [ ! -f "${TASK_DIR}03-review.md" ]; then
      echo "BLOCKED: 리뷰(03-review.md)가 수행되지 않았습니다."
      echo "→ Step 4(리뷰)를 먼저 진행하세요."
      exit 1
    fi
    if [ ! -f "${TASK_DIR}04-verify.md" ]; then
      echo "BLOCKED: 검증(04-verify.md)이 수행되지 않았습니다."
      echo "→ Step 5(검증)를 먼저 진행하세요."
      exit 1
    fi
    ;;
esac

exit 0
