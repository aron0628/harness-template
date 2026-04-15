# Pre-Commit Checklist

<!--
  커밋 전 에이전트/사람이 확인해야 할 항목입니다.
  .harness/config.yaml의 enforcement 명령어를 사용하세요.
-->

## 필수

- [ ] 린트 통과 (config.yaml → `enforcement.lint_command`)
- [ ] 타입 체크 통과 (`enforcement.type_check_command`) — 설정된 경우
- [ ] 변경한 코드와 관련된 테스트 통과 (`enforcement.test_command`)
- [ ] `docs/beliefs/golden-rules.md` 위반 없음
- [ ] `docs/architecture/layers.md` 의존성 방향 준수

## 조건부

- [ ] 새 파일 추가 시 → 해당 디렉토리의 CLAUDE.md 업데이트
- [ ] 새 모듈/디렉토리 추가 시 → `.harness/checklists/new-module.md` 체크리스트 수행
- [ ] API 변경 시 → 관련 docs/specs/ 문서 업데이트
- [ ] 아키텍처 변경 시 → `ARCHITECTURE.md` 및 `docs/architecture/` 업데이트
