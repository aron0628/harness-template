# {프로젝트명}

<!--
  이 파일은 AI 에이전트의 진입점(목차)입니다.
  ~100줄 이내로 유지하고, 상세 내용은 docs/로 연결하세요.

  작성 가이드:
  1. Purpose: 프로젝트를 1-2줄로 설명
  2. Navigation: 수정하지 마세요 (하네스 표준 구조)
  3. Quick Start: 빌드/테스트/린트 명령어 기입
  4. Key Constraints: golden-rules.md에서 가장 중요한 3-5개 요약
  5. Subdirectories: 주요 디렉토리와 역할 기입
-->

## Purpose
<!-- 프로젝트를 1-2줄로 설명하세요 -->
<!-- 예: "YK건기 AI 챗봇 백엔드. FastAPI + LangGraph 기반 RAG 시스템." -->

## Navigation

| Path | Description |
|------|-------------|
| `ARCHITECTURE.md` | 아키텍처 맵 — 레이어, 의존성 방향, 핵심 흐름 |
| `docs/beliefs/core-beliefs.md` | 에이전트 운영의 불변 원칙 |
| `docs/beliefs/golden-rules.md` | 코드베이스 황금 규칙 |
| `docs/architecture/layers.md` | 레이어 정의 + 의존성 매트릭스 |
| `docs/plans/active/` | 현재 진행 중인 실행 계획 |
| `docs/quality/score.md` | 도메인별 품질 등급 |
| `.harness/config.yaml` | 하네스 설정 |
| `.harness/pipeline/README.md` | 개발 파이프라인 — 작업 시 따라야 할 단계별 프로세스 |

## Quick Start

<!-- .harness/config.yaml의 enforcement 섹션과 일치시키세요 -->

- 빌드: `` <!-- 예: make build | npm run build | gradle build -->
- 테스트: `` <!-- 예: make test | npm test | gradle test -->
- 린트: `` <!-- 예: make lint | npm run lint | gradle check -->
- 포맷: `` <!-- 예: make format | npm run format | gradle spotlessApply -->

## Key Constraints

<!-- docs/beliefs/golden-rules.md에서 가장 중요한 3-5개를 여기에 요약하세요 -->
<!-- 에이전트가 이 파일만 읽고도 핵심 규칙을 파악할 수 있어야 합니다 -->

1. 
2. 
3. 
4. **개발 파이프라인 준수** — 기능 개발/수정 작업 시 `.harness/pipeline/README.md`의 파이프라인을 따른다. 단계를 건너뛰지 않는다.

## Subdirectories

<!-- 주요 디렉토리와 역할을 기입하세요 -->
<!-- 하위 CLAUDE.md가 있으면 "(see CLAUDE.md)" 표기 -->

| Directory | Description |
|-----------|-------------|
<!-- 예:
| `src/` | 애플리케이션 소스 코드 (see CLAUDE.md) |
| `tests/` | 테스트 코드 |
| `docs/` | 프로젝트 지식 베이스 |
-->
