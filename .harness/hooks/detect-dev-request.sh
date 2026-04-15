#!/bin/bash
# Hook: UserPromptSubmit - 개발 요청 감지 시 파이프라인 안내 주입
# 개발/수정/추가 관련 키워드가 포함된 요청에서 파이프라인을 먼저 따르도록 안내
# exit 0 = 통과 (stdout 메시지는 컨텍스트로 주입됨)

HOOK_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_ROOT="$(cd "$HOOK_DIR/../.." && pwd)"

# stdin에서 사용자 입력 읽기
INPUT=$(cat)
USER_INPUT=$(echo "$INPUT" | grep -o '"content"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"content"[[:space:]]*:[[:space:]]*"//;s/"//' | head -1)

# 개발 관련 키워드 감지
if echo "$USER_INPUT" | grep -qE '(개발|진행|구현|추가개발|기능개선|수정|만들어|작성해|개선|신규|추가해|생성해|변경해)'; then
  # 파이프라인 적용 제외 키워드 (문서, 설정 등 단순 작업)
  if echo "$USER_INPUT" | grep -qE '(문서만|설정만|README|CLAUDE\.md|메모리|remember|기억)'; then
    exit 0
  fi

  PLANS_DIR="$PROJECT_ROOT/docs/plans/active"
  ACTIVE_TASKS=$(find "$PLANS_DIR" -mindepth 1 -maxdepth 1 -type d 2>/dev/null | wc -l | tr -d ' ')

  echo "[PIPELINE REMINDER] 개발 관련 요청이 감지되었습니다."
  echo ""
  echo "⚠️  반드시 .harness/pipeline/README.md를 먼저 읽고 파이프라인 절차를 따르세요."
  echo ""
  echo "필수 절차:"
  echo "  1. .harness/pipeline/README.md 읽기"
  echo "  2. 태스크 폴더 생성: docs/plans/active/{YYYYMMDD}-{설명}/"
  echo "  3. 입력 문서 준비 (PPT→PDF 변환: soffice --headless --convert-to pdf)"
  echo "  4. Step 1(분석)부터 순서대로 진행"
  echo ""
  echo "모델 라우팅:"
  echo "  - 분석(Step1), 리뷰(Step4): opus"
  echo "  - 계획(Step2): opus + plan mode 필수"
  echo "  - 개발(Step3): sonnet"
  echo ""

  if [ "$ACTIVE_TASKS" -gt 0 ]; then
    LATEST_TASK=$(ls -dt "$PLANS_DIR"/*/ 2>/dev/null | head -1)
    echo "현재 활성 태스크: $(basename "$LATEST_TASK")"
  else
    echo "현재 활성 태스크: 없음 — 새 태스크 폴더를 생성하세요."
  fi
fi

exit 0
