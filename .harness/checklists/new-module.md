# New Module Checklist

<!--
  새 모듈/디렉토리를 추가할 때 확인해야 할 항목입니다.
  모듈이란 독립적인 기능 단위의 디렉토리를 의미합니다.
  (예: app/services/, src/components/, pkg/auth/)
-->

## 아키텍처

- [ ] `docs/architecture/layers.md` — 이 모듈이 어떤 레이어에 속하는지 확인
- [ ] `docs/architecture/dependency-rules.md` — 의존성 매트릭스 위반 없음 확인
- [ ] `docs/architecture/cross-cutting.md` — 횡단 모듈이라면 등록

## 문서

- [ ] 해당 디렉토리에 **CLAUDE.md 생성** (아래 템플릿 참조)
- [ ] 루트 `CLAUDE.md`의 Subdirectories 테이블 업데이트
- [ ] 상위 디렉토리 CLAUDE.md 업데이트 (있다면)

## 품질

- [ ] `docs/quality/score.md`에 초기 등급 추가 (보통 D로 시작)
- [ ] 기본 테스트 파일 생성

---

## 하위 CLAUDE.md 템플릿

```markdown
# {모듈명}

## Purpose
<!-- 이 모듈의 역할을 1-2줄로 설명 -->

## Key Files
| File | Description |
|------|-------------|

## Patterns
<!-- 이 모듈에서 사용하는 패턴/규칙 -->

## Dependencies
<!-- 이 모듈이 의존하는 다른 모듈 -->
<!-- docs/architecture/dependency-rules.md의 규칙을 준수해야 함 -->
```
