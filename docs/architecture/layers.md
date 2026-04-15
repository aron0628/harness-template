# Architecture Layers

<!--
  이 파일은 프로젝트의 레이어 구조와 의존성 방향을 정의합니다.
  에이전트는 새 코드 작성 시 이 규칙을 반드시 준수해야 합니다.

  작성 가이드:
  1. 레이어 정의: 프로젝트의 레이어 목록과 역할
  2. 의존성 방향: 허용되는 참조 방향 (다이어그램)
  3. 규칙: 명문화된 의존성 규칙
  4. 위반 시 조치: 에이전트가 위반을 발견했을 때 해야 할 일
-->

## 레이어 정의

| Layer | 역할 | 디렉토리 |
|-------|------|----------|
<!-- 프로젝트에 맞게 작성하세요 -->

<!--
예시 (Python/FastAPI - Layered):
| Schemas      | 요청/응답 데이터 형태 정의 | app/schemas/      |
| Models       | ORM 모델 (DB 테이블 매핑)  | app/models/       |
| Repositories | 데이터 접근 계층           | app/repositories/ |
| Services     | 비즈니스 로직              | app/services/     |
| Routers      | API 엔드포인트            | app/routers/      |

예시 (Java/Spring - Layered):
| DTO          | 데이터 전송 객체           | dto/              |
| Entity       | JPA 엔티티               | entity/           |
| Repository   | 데이터 접근 (JPA)         | repository/       |
| Service      | 비즈니스 로직              | service/          |
| Controller   | REST 컨트롤러             | controller/       |

예시 (TypeScript/React):
| Types        | 타입 정의                 | types/            |
| Hooks        | 커스텀 훅                 | hooks/            |
| Components   | UI 컴포넌트               | components/       |
| Pages        | 페이지 컴포넌트            | pages/            |
| Services     | API 호출 로직             | services/         |

예시 (Hexagonal):
| Domain       | 도메인 모델 + 비즈니스 로직 | domain/           |
| Port         | 인터페이스 정의            | port/             |
| Adapter      | 외부 시스템 연결           | adapter/          |
| Application  | 유스케이스 오케스트레이션   | application/      |
-->

## 의존성 방향

<!-- 허용되는 방향을 다이어그램으로 표현하세요 -->
<!-- 화살표(→)는 "참조할 수 있음"을 의미합니다 -->

<!--
예시 (Layered):
```
Router/Controller → Service → Repository → Model → Schema/DTO
       ↑ 금지          ↑ 금지      ↑ 금지       ↑ 금지
```

예시 (Hexagonal):
```
Adapter → Port ← Application → Domain
                     ↑ 금지
```
-->

## 규칙

1. 상위 레이어는 하위 레이어만 참조 가능 (역방향 금지)
2. 같은 레이어 간 참조: <!-- 허용 | 금지 | 조건부 허용 — 선택하세요 -->
3. 횡단 관심사는 `docs/architecture/cross-cutting.md` 참조
4. 순환 의존성 절대 금지

## 위반 시 조치

<!--
  에이전트가 의존성 위반을 발견했을 때의 수정 가이드입니다.
  린터 에러 메시지에 이 내용을 포함하면 자동 수정이 가능합니다.
-->

| 위반 유형 | 수정 방법 |
|----------|----------|
| 역방향 참조 | 공통으로 필요한 타입/인터페이스를 하위 레이어로 이동 |
| 순환 의존성 | 중간 인터페이스 도입 또는 공통 모듈로 추출 |
| 횡단 관심사 우회 | cross-cutting 모듈을 통해 접근하도록 변경 |
