#!/bin/bash
# Hook: 보호 파일 수정 차단
# PreToolUse: Write, Edit 에서 실행
# exit 1 = 차단, exit 0 = 통과

HOOK_DIR="$(cd "$(dirname "$0")" && pwd)"
PROTECTED_LIST="$HOOK_DIR/protected-files.txt"

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | grep -o '"file_path"[[:space:]]*:[[:space:]]*"[^"]*"' | sed 's/.*"file_path"[[:space:]]*:[[:space:]]*"//;s/"//')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

if [ ! -f "$PROTECTED_LIST" ]; then
  exit 0
fi

while IFS= read -r pattern; do
  [[ "$pattern" =~ ^#.*$ ]] && continue
  [[ -z "$pattern" ]] && continue
  if echo "$FILE_PATH" | grep -q "$pattern"; then
    echo "BLOCKED: 이 파일은 수정 금지입니다 (harness 보호 규칙 위반)"
    echo "대상: $FILE_PATH"
    echo "매칭 패턴: $pattern"
    echo "→ .harness/pipeline/rules.md의 프레임워크 보호 섹션을 확인하세요."
    exit 1
  fi
done < "$PROTECTED_LIST"

exit 0
