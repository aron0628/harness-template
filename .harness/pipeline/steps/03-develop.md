# Step 3: 개발

## 목적

승인된 계획에 따라 코드를 구현합니다.

## 선행 조건

- [ ] `02-plan.md`에 `Status: APPROVED` 마커가 있음
- [ ] `02-plan.md`의 선행 수동 작업이 모두 `[x]`로 체크됨
- [ ] `context-chain.md`를 읽고 이전 결정사항을 확인함

> **위 조건이 충족되지 않으면 멈추고, 먼저 해결하세요.**

## 입력

- 승인된 계획 (`02-plan.md`)
- 컨텍스트 체인 (`context-chain.md`)
- 개발 규칙 (`.harness/pipeline/rules.md`)
- 참고문서 (`docs/references/`)

## 지침

### 1. 계획 따르기

- `02-plan.md`의 파일별 변경 계획을 순서대로 실행
- 계획에 없는 파일은 수정하지 않음
- 계획과 다른 방식으로 구현해야 하면 `context-chain.md`에 사유 기록

### 2. 규칙 준수

- `.harness/pipeline/rules.md`의 모든 규칙을 준수
- 특히 CRITICAL/HIGH 심각도 규칙에 주의
- 프레임워크 보호 규칙(FRM-*) 위반 여부 수시 확인

### 3. 기존 패턴 일관성

- 동일 모듈의 기존 코드 패턴을 따름
- 새로운 패턴을 도입하지 않음
- 필요한 경우 `docs/references/`의 패턴 가이드 참조

### 4. 빌드 확인

- 구현 완료 후 빌드 실행 (`.harness/config.yaml`의 `enforcement.build_command`)
- 빌드 실패 시 수정 후 재시도
- 새로 발생한 경고도 확인

## 자체 검증 (다음 단계 전 확인)

- [ ] 계획된 모든 파일이 생성/수정되었는가
- [ ] 계획에 없는 파일을 수정하지 않았는가
- [ ] 빌드가 통과하는가
- [ ] 규칙 위반이 없는가 (특히 CRITICAL/HIGH)
- [ ] import 누락이나 미사용 import가 없는가

## 완료 후

1. `context-chain.md`에 구현 중 변경사항/판단 기록
2. 복잡도가 "단순"이고 리뷰가 선택이면 Step 5로 건너뛸 수 있음
3. 그 외에는 Step 4로 진행
