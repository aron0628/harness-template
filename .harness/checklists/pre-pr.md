# Pre-PR Checklist

<!--
  PR 생성 전 확인해야 할 항목입니다.
  pre-commit.md의 모든 항목이 통과된 상태여야 합니다.
-->

## 필수

- [ ] Pre-Commit 체크리스트 모두 통과
- [ ] **전체** 테스트 스위트 통과 (변경 관련 테스트뿐 아니라 전체)
- [ ] 변경 사항 관련 문서 업데이트 완료
- [ ] 셀프 리뷰 완료 (에이전트: 자신의 diff 검토)
- [ ] PR 제목과 설명이 변경 내용을 정확히 반영

## 품질

- [ ] `docs/quality/score.md` 영향도 확인 — 품질 등급 하락 없음
- [ ] `docs/quality/drift-log.md` — 새로운 드리프트 미발생 확인

## 계획 추적

- [ ] `docs/plans/active/` — 관련 계획이 있다면 진행 상태 업데이트
- [ ] `docs/plans/tech-debt.md` — 새로운 기술 부채 발생 시 기록
