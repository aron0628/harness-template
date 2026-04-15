# Harness Pipeline Hooks

파이프라인 규칙을 강제하는 Hook 스크립트입니다.
Write/Edit 도구 사용 전에 자동으로 실행되어, 조건 미충족 시 **차단**합니다.

## Hook 목록

| Hook | 역할 | 차단 조건 |
|------|------|----------|
| `check-protected-files` | 보호 파일 수정 차단 | protected-files.txt에 매칭되는 파일 수정 시 |
| `check-pipeline` | 파이프라인 진행 상태 체크 | 태스크 폴더 없음 / 계획 미승인 / 선행작업 미완료 |
| `check-review-gate` | 리뷰/검증 게이트 | 리뷰/검증 없이 완료 문서 작성 시 |
| `check-step-gate` | 스텝 간 산출물 체인 | 이전 스텝 산출물 없이 다음 스텝 산출물 작성 시 |

## OS별 설정

### macOS / Linux

`.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "bash .harness/hooks/check-protected-files.sh" },
          { "type": "command", "command": "bash .harness/hooks/check-pipeline.sh" },
          { "type": "command", "command": "bash .harness/hooks/check-review-gate.sh" },
          { "type": "command", "command": "bash .harness/hooks/check-step-gate.sh" }
        ]
      }
    ]
  }
}
```

### Windows

`.claude/settings.json`:
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Write|Edit",
        "hooks": [
          { "type": "command", "command": "cmd /c .harness\\hooks\\check-protected-files.bat" },
          { "type": "command", "command": "cmd /c .harness\\hooks\\check-pipeline.bat" },
          { "type": "command", "command": "cmd /c .harness\\hooks\\check-review-gate.bat" },
          { "type": "command", "command": "cmd /c .harness\\hooks\\check-step-gate.bat" }
        ]
      }
    ]
  }
}
```

## 파일 구조

```
.harness/hooks/
├── README.md                    # 이 파일
├── protected-files.txt          # 수정 금지 파일 목록 (프로젝트별 커스터마이징)
├── check-protected-files.sh/.bat
├── check-pipeline.sh/.bat
├── check-review-gate.sh/.bat
└── check-step-gate.sh/.bat
```

## 커스터마이징

### protected-files.txt

프로젝트별로 수정 금지 대상을 변경합니다.
한 줄에 하나씩, 파일 경로의 일부를 패턴으로 입력합니다.
`#`으로 시작하는 줄은 주석입니다.

### settings.json

`.claude/settings.json`은 프로젝트 루트에 위치합니다.
OS에 맞는 설정을 위 예시에서 복사하여 사용하세요.
