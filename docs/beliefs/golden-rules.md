# Golden Rules

<!--
  이 파일은 코드베이스 전체에 적용되는 불변 규칙을 정의합니다.
  에이전트는 모든 작업에서 이 규칙을 준수해야 합니다.
  
  작성 가이드:
  - 범용 규칙: 모든 프로젝트에 공통 적용 (수정하지 마세요)
  - 프로젝트별 규칙: 이 프로젝트 고유의 규칙 추가
  - 각 규칙은 "왜 필요한지" 한 줄 설명 포함
  - CLAUDE.md의 Key Constraints에 가장 중요한 3-5개를 요약 복사
-->

## 범용 규칙 (기본 제공)

1. **외부 입력은 경계에서 즉시 검증**
   - 외부 API 응답, 사용자 입력, 파일 파싱 결과는 경계에서 스키마 검증
   - 언어별 도구: Pydantic (Python) / Zod (TS) / Bean Validation (Java) / serde (Rust)

2. **공유 유틸리티 확인 후 헬퍼 작성**
   - 새 헬퍼 함수 작성 전 기존 유틸리티 모듈에 동일 기능이 있는지 확인
   - 중복 구현 방지, 일관성 유지

3. **새 모듈 추가 시 문서 업데이트 필수**
   - 해당 디렉토리의 CLAUDE.md 업데이트
   - 루트 CLAUDE.md의 Subdirectories 테이블 업데이트
   - docs/quality/score.md에 초기 등급 추가
   - `.harness/checklists/new-module.md` 체크리스트 따름

## 프로젝트별 규칙

<!-- 아래에 프로젝트 고유 규칙을 추가하세요 -->
<!-- 각 규칙에는 "왜 필요한지" 설명을 포함하세요 -->

<!--
예시 (Python/FastAPI):
4. **LLM 인스턴스는 반드시 팩토리 경유**
   - `utils/llm_factory.py`의 `create_chat_model()` 사용
   - 서비스에서 직접 LLM 인스턴스 생성 금지
   - 이유: 프로바이더 전환 시 변경 지점 최소화

5. **DB PK 생성은 시퀀스 헬퍼 사용**
   - Oracle SEQUENCE를 통한 PK 생성 (`utils/sequence_helper.py`)
   - auto_increment 사용 금지
   - 이유: Oracle DB 호환성

예시 (Java/Spring):
4. **Service 레이어에 @Transactional 필수**
   - 모든 write 작업은 Service 레이어에서 트랜잭션 관리
   - Repository에서 직접 트랜잭션 관리 금지

5. **DTO 변환은 Mapper 사용**
   - Entity ↔ DTO 변환은 MapStruct Mapper 사용
   - 수동 변환 코드 금지

예시 (TypeScript/React):
4. **상태 관리는 지정된 도구만 사용**
   - 전역 상태: Zustand
   - 서버 상태: TanStack Query
   - 다른 상태 관리 라이브러리 추가 금지

5. **컴포넌트 props는 interface로 정의**
   - type 대신 interface 사용
   - Props 이름 규칙: {ComponentName}Props
-->
