# Dependency Rules

<!--
  이 파일은 레이어 간 허용/금지 의존성을 매트릭스로 정의합니다.
  layers.md의 규칙을 구체적인 매트릭스로 표현합니다.

  작성 가이드:
  1. 의존성 매트릭스: 행(from) → 열(to) 방향으로 허용 여부 표기
  2. 금지 사유: 왜 금지하는지 설명 (에이전트가 의도를 이해)
  3. 예외 사항: 허용되는 예외와 조건
-->

## 의존성 매트릭스

<!-- O = 허용, X = 금지, △ = 조건부 허용 -->
<!-- 행(from)이 열(to)을 참조할 수 있는지 여부 -->

<!--
예시 (Python/FastAPI):
| from \ to    | Schemas | Models | Repositories | Services | Routers |
|-------------|---------|--------|-------------|----------|---------|
| Schemas     | -       | X      | X           | X        | X       |
| Models      | O       | -      | X           | X        | X       |
| Repositories| O       | O      | -           | X        | X       |
| Services    | O       | O      | O           | △        | X       |
| Routers     | O       | X      | X           | O        | -       |

예시 (Java/Spring):
| from \ to   | DTO | Entity | Repository | Service | Controller |
|-------------|-----|--------|-----------|---------|------------|
| DTO         | -   | X      | X         | X       | X          |
| Entity      | X   | -      | X         | X       | X          |
| Repository  | X   | O      | -         | X       | X          |
| Service     | O   | O      | O         | △       | X          |
| Controller  | O   | X      | X         | O       | -          |
-->

## 금지 사유

| 금지 규칙 | 사유 |
|----------|------|
<!-- 예:
| Router → Model | Router는 스키마(DTO)만 다뤄야 함. ORM 모델 직접 노출 금지 |
| Repository → Service | 역방향 참조. 순환 의존 위험 |
| Service → Service (△) | 동일 도메인 내에서만 허용. 타 도메인 서비스 직접 참조 금지 |
-->

## 예외 사항

<!-- 매트릭스의 규칙에서 허용되는 예외를 기술하세요 -->
<!--
예시:
1. **테스트 코드**: 테스트에서는 모든 레이어 직접 참조 허용
2. **DI 설정**: 컨테이너/설정 파일에서는 모든 레이어 참조 허용
3. **마이그레이션**: DB 마이그레이션 스크립트에서는 Model 직접 참조 허용
-->
