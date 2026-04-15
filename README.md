# Harness Engineering Template

AI 에이전트와 협업하기 위한 프로젝트 하네스 엔지니어링 프레임워크 템플릿.

> 참고: [OpenAI - Harness Engineering: Building with Codex in an agent-first world](https://openai.com/ko-KR/index/harness-engineering/)

## 이게 뭔가요?

AI 코딩 에이전트(Claude Code, Codex, Cursor 등)가 프로젝트에서 효과적으로 작업하려면 **환경이 갖춰져야** 합니다. 이 템플릿은 에이전트가 프로젝트의 구조, 규칙, 품질 기준을 이해하고 따를 수 있도록 하는 **문서 + 설정 프레임워크**입니다.

### 핵심 원칙

- **리포 = 유일한 진실의 원천** — 리포에 없으면 에이전트에겐 존재하지 않음
- **백과사전이 아닌 목차** — CLAUDE.md는 ~100줄 맵, 상세는 docs/에
- **기계적 강제 > 문서 설명** — 린터로 잡을 수 있으면 도구로 강제
- **에이전트 가독성 우선** — 에이전트가 추론할 수 있는 형태로 지식 구조화

## 특징

- 언어 무관 (Python, Java, TypeScript, Go, Rust 등)
- OS 무관 (Mac, Windows, Linux)
- 에이전트 무관 (Claude Code, Codex, Cursor 등)
- 코드 없음 — 마크다운 + YAML만으로 구성
- 외부 의존성 없음 — git만 있으면 사용 가능

## 사용법

### 새 프로젝트

```bash
git clone https://github.com/{org}/harness-template.git
cp -r harness-template/docs my-project/
cp -r harness-template/.harness my-project/
cp harness-template/CLAUDE.md my-project/
cp harness-template/ARCHITECTURE.md my-project/
```

### 기존 프로젝트

```bash
cd my-project
git remote add harness https://github.com/{org}/harness-template.git
git fetch harness
git checkout harness/main -- docs/ .harness/ CLAUDE.md ARCHITECTURE.md
```

## 도입 프로세스

### Phase 1: 구조 (30분)

1. 위 사용법에 따라 파일 복사
2. `.harness/config.yaml` 작성 — language, framework, 도구 매핑
3. `CLAUDE.md` — Purpose, Quick Start 작성

### Phase 2: 원칙 (1시간)

1. `docs/beliefs/core-beliefs.md` — 프로젝트별 원칙 추가
2. `docs/beliefs/golden-rules.md` — 프로젝트별 규칙 추가
3. `docs/architecture/layers.md` — 레이어 정의
4. `docs/architecture/dependency-rules.md` — 의존성 매트릭스 작성
5. `ARCHITECTURE.md` — 시스템 개요, 기술 스택, 레이어 맵 작성

### Phase 3: 강제 (프로젝트별)

1. 네이티브 린터로 아키텍처 규칙 구현
   - Python: `import-linter`
   - Java/Kotlin: `ArchUnit`
   - TypeScript: `dependency-cruiser`
   - Go: `go vet` + custom analyzer
2. CI에 체크리스트 검증 단계 추가
3. 주요 소스 디렉토리에 하위 CLAUDE.md 생성

### Phase 4: 운영 (지속)

1. `docs/quality/score.md` — 주기적 품질 등급 갱신
2. `docs/plans/tech-debt.md` — 기술 부채 추적
3. `docs/quality/drift-log.md` — 드리프트 기록 및 해결
4. 문서 신선도 모니터링

## 디렉토리 구조

```
project-root/
├── CLAUDE.md                        # 에이전트 진입점 (목차)
├── ARCHITECTURE.md                  # 아키텍처 최상위 맵
├── docs/                            # 기록 시스템
│   ├── index.md                     # 문서 인덱스
│   ├── beliefs/                     # 핵심 원칙
│   │   ├── core-beliefs.md
│   │   └── golden-rules.md
│   ├── architecture/                # 아키텍처 상세
│   │   ├── layers.md
│   │   ├── dependency-rules.md
│   │   └── cross-cutting.md
│   ├── plans/                       # 실행 계획
│   │   ├── active/
│   │   ├── completed/
│   │   └── tech-debt.md
│   ├── specs/                       # 제품 스펙
│   │   └── index.md
│   ├── quality/                     # 품질 관리
│   │   ├── score.md
│   │   └── drift-log.md
│   └── references/                  # 외부 참조
└── .harness/                        # 하네스 설정
    ├── config.yaml
    └── checklists/
        ├── pre-commit.md
        ├── pre-pr.md
        └── new-module.md
```

## 모든 템플릿에는 가이드가 포함되어 있습니다

빈 파일은 하나도 없습니다. 모든 파일에:
- 파일의 **목적** 설명
- **작성 가이드** (HTML 주석)
- 언어별 **예시** 포함
- 필수 입력 항목은 빈 값(`""`)으로 표시
