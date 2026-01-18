# Oracle 전체 테이블 카탈로그

## 시스템 카탈로그 개요
이 문서는 Oracle Database의 주요 시스템 테이블과 뷰를 카테고리별로 정리한 종합 카탈로그입니다.

## 전체 테이블 수 통계

### 데이터 딕셔너리 뷰 통계
- **DBA_* 뷰**: 약 700개 이상
- **ALL_* 뷰**: 약 600개 이상  
- **USER_* 뷰**: 약 400개 이상
- **V$ 뷰**: 약 600개 이상
- **GV$ 뷰**: 약 600개 이상 (RAC 환경)

### 주요 카테고리별 분류

#### 1. 객체 관리 (약 150개 뷰)
- 테이블 관련: 30개
- 인덱스 관련: 25개
- 뷰 관련: 20개
- 시퀀스/동의어: 10개
- 제약조건: 15개
- 트리거: 10개
- PL/SQL 객체: 40개

#### 2. 보안 및 권한 (약 100개 뷰)
- 사용자 관리: 20개
- 역할 관리: 15개
- 권한 관리: 30개
- 감사: 35개

#### 3. 스토리지 관리 (약 80개 뷰)
- 테이블스페이스: 20개
- 데이터파일: 15개
- 세그먼트/익스텐트: 25개
- 파티션: 20개

#### 4. 성능 및 모니터링 (약 200개 뷰)
- 세션/프로세스: 40개
- SQL 통계: 50개
- 메모리 관리: 30개
- I/O 통계: 30개
- 대기 이벤트: 50개

#### 5. 고가용성 (약 80개 뷰)
- 복제: 30개
- 백업/복구: 30개
- Data Guard: 20개

## 주요 카테고리별 상세 목록

### A. 객체 관리 뷰

#### A1. 테이블 관련 (32개)
1. DBA_TABLES - 모든 테이블
2. ALL_TABLES - 접근 가능 테이블
3. USER_TABLES - 사용자 테이블
4. DBA_TAB_COLUMNS - 테이블 컬럼
5. ALL_TAB_COLUMNS - 접근 가능 컬럼
6. USER_TAB_COLUMNS - 사용자 컬럼
7. DBA_TAB_COMMENTS - 테이블 주석
8. DBA_COL_COMMENTS - 컬럼 주석
9. DBA_TAB_STATISTICS - 테이블 통계
10. DBA_TAB_MODIFICATIONS - 테이블 변경 추적
11. DBA_TAB_PARTITIONS - 테이블 파티션
12. DBA_TAB_SUBPARTITIONS - 서브파티션
13. DBA_EXTERNAL_TABLES - 외부 테이블
14. DBA_OBJECT_TABLES - 객체 테이블
15. DBA_NESTED_TABLES - 중첩 테이블
16. DBA_ALL_TABLES - 모든 테이블 통합 뷰
17. DBA_TAB_COLS - 모든 컬럼 (숨겨진 컬럼 포함)
18. DBA_TAB_COL_STATISTICS - 컬럼 통계
19. DBA_TAB_HISTOGRAMS - 히스토그램
20. DBA_UNUSED_COL_TABS - 사용하지 않는 컬럼이 있는 테이블
21. DBA_PARTIAL_DROP_TABS - 부분 삭제 테이블
22. DBA_TABLES_AE - Application Edition 테이블
23. DBA_TAB_IDENTITY_COLS - Identity 컬럼
24. DBA_TAB_PRIVS - 테이블 권한
25. ALL_TAB_PRIVS - 접근 가능 테이블 권한
26. USER_TAB_PRIVS - 사용자 테이블 권한
27. DBA_COL_PRIVS - 컬럼 권한
28. ALL_COL_PRIVS - 접근 가능 컬럼 권한
29. USER_COL_PRIVS - 사용자 컬럼 권한
30. DBA_TAB_PENDING_STATS - 대기 중인 통계
31. DBA_TAB_STATS_HISTORY - 통계 이력
32. DICTIONARY - 데이터 딕셔너리 객체 목록

#### A2. 인덱스 관련 (28개)
1. DBA_INDEXES - 모든 인덱스
2. ALL_INDEXES - 접근 가능 인덱스
3. USER_INDEXES - 사용자 인덱스
4. DBA_IND_COLUMNS - 인덱스 컬럼
5. ALL_IND_COLUMNS - 접근 가능 인덱스 컬럼
6. USER_IND_COLUMNS - 사용자 인덱스 컬럼
7. DBA_IND_PARTITIONS - 인덱스 파티션
8. DBA_IND_SUBPARTITIONS - 인덱스 서브파티션
9. DBA_IND_EXPRESSIONS - 함수 기반 인덱스
10. DBA_IND_STATISTICS - 인덱스 통계
11. DBA_PART_INDEXES - 파티션 인덱스
12. DBA_JOIN_IND_COLUMNS - 조인 인덱스 컬럼
13. DBA_CLUSTER_HASH_EXPRESSIONS - 해시 클러스터 표현식
14. DBA_SUBPARTITION_TEMPLATES - 서브파티션 템플릿
15. DBA_IND_PENDING_STATS - 대기 중인 인덱스 통계
16. DBA_IND_STATS_HISTORY - 인덱스 통계 이력
17. DBA_HISTOGRAMS - 히스토그램 정보
18. USER_HISTOGRAMS - 사용자 히스토그램
19. V$INDEXED_FIXED_COLUMN - 고정 인덱스 컬럼
20. DBA_ORPHAN_KEY_TABLE - 고아 키 테이블
21. DBA_ILM_POLICIES - ILM 정책
22. DBA_ILMDATAMOVEMENTPOLICIES - ILM 데이터 이동 정책
23. DBA_ILMEVALUATIONDETAILS - ILM 평가 상세
24. DBA_ILMOBJECTS - ILM 객체
25. DBA_ILMPARAMETERS - ILM 파라미터
26. DBA_ILMRESULTS - ILM 결과
27. DBA_ILMTASKS - ILM 작업
28. DBA_UNUSED_COL_TABS - 미사용 컬럼 테이블

#### A3. 뷰 관련 (24개)
1. DBA_VIEWS - 모든 뷰
2. ALL_VIEWS - 접근 가능 뷰
3. USER_VIEWS - 사용자 뷰
4. DBA_MVIEWS - Materialized View
5. ALL_MVIEWS - 접근 가능 MView
6. USER_MVIEWS - 사용자 MView
7. DBA_MVIEW_LOGS - MView 로그
8. DBA_MVIEW_REFRESH_TIMES - MView 리프레시 시간
9. DBA_MVIEW_AGGREGATES - MView 집계
10. DBA_MVIEW_ANALYSIS - MView 분석
11. DBA_MVIEW_DETAIL_RELATIONS - MView 상세 관계
12. DBA_MVIEW_JOINS - MView 조인
13. DBA_MVIEW_KEYS - MView 키
14. DBA_BASE_TABLE_MVIEWS - 기본 테이블 MView
15. DBA_REGISTERED_MVIEWS - 등록된 MView
16. DBA_RGROUP - 리프레시 그룹
17. DBA_REFRESH - 리프레시 정보
18. DBA_REFRESH_CHILDREN - 리프레시 자식
19. DBA_UPDATABLE_COLUMNS - 업데이트 가능 컬럼
20. USER_UPDATABLE_COLUMNS - 사용자 업데이트 가능 컬럼
21. DBA_MVIEW_COMMENTS - MView 주석
22. DBA_SNAPSHOT_LOGS - 스냅샷 로그
23. DBA_SNAPSHOTS - 스냅샷
24. DBA_ALL_MVIEWS - 모든 MView 통합

#### A4. 시퀀스 및 동의어 (12개)
1. DBA_SEQUENCES - 모든 시퀀스
2. ALL_SEQUENCES - 접근 가능 시퀀스
3. USER_SEQUENCES - 사용자 시퀀스
4. DBA_SYNONYMS - 모든 동의어
5. ALL_SYNONYMS - 접근 가능 동의어
6. USER_SYNONYMS - 사용자 동의어
7. DBA_SEQUENCES_AE - Application Edition 시퀀스
8. V$SEQUENCE - 시퀀스 캐시 정보
9. DBA_OBJECT_USAGE - 객체 사용 정보
10. USER_OBJECT_USAGE - 사용자 객체 사용
11. DBA_SECONDARY_OBJECTS - 보조 객체
12. PUBLIC_DEPENDENCY - 공용 의존성

#### A5. 제약조건 관련 (18개)
1. DBA_CONSTRAINTS - 모든 제약조건
2. ALL_CONSTRAINTS - 접근 가능 제약조건
3. USER_CONSTRAINTS - 사용자 제약조건
4. DBA_CONS_COLUMNS - 제약조건 컬럼
5. ALL_CONS_COLUMNS - 접근 가능 제약조건 컬럼
6. USER_CONS_COLUMNS - 사용자 제약조건 컬럼
7. DBA_CONSTRAINT_DEFS - 제약조건 정의
8. V$CONSTRAINT - 제약조건 정보
9. DBA_REFS - 참조 제약조건
10. V$CONSTRAINT_DEF - 제약조건 정의
11. DBA_CONSTRAINTS_AE - Application Edition 제약조건
12. DBA_CONSTRAINT_COLUMNS - 제약조건 컬럼 상세
13. DBA_APPLY_CONFLICT_COLUMNS - 충돌 컬럼
14. DBA_APPLY_KEY_COLUMNS - 키 컬럼
15. DBA_APPLY_CONFLICT_HANDLERS - 충돌 핸들러
16. DBA_APPLY_DML_CONF_COLUMNS - DML 충돌 컬럼
17. DBA_APPLY_DML_CONF_HANDLERS - DML 충돌 핸들러
18. DBA_CONSTRAINT_COLS - 제약조건 컬럼 요약

#### A6. 트리거 관련 (15개)
1. DBA_TRIGGERS - 모든 트리거
2. ALL_TRIGGERS - 접근 가능 트리거
3. USER_TRIGGERS - 사용자 트리거
4. DBA_TRIGGER_COLS - 트리거 컬럼
5. ALL_TRIGGER_COLS - 접근 가능 트리거 컬럼
6. USER_TRIGGER_COLS - 사용자 트리거 컬럼
7. DBA_TRIGGERS_AE - Application Edition 트리거
8. DBA_INTERNAL_TRIGGERS - 내부 트리거
9. ALL_INTERNAL_TRIGGERS - 접근 가능 내부 트리거
10. USER_INTERNAL_TRIGGERS - 사용자 내부 트리거
11. DBA_TRIGGER_ORDERING - 트리거 순서
12. DBA_DDL_LOCKS - DDL 락
13. V$TRIGGER - 트리거 정보
14. DBA_ENABLED_AGGREGATIONS - 활성화된 집계
15. DBA_ENABLED_TRACES - 활성화된 추적

### B. 보안 및 권한 관련 뷰

#### B1. 사용자 관리 (25개)
1. DBA_USERS - 모든 사용자
2. ALL_USERS - 모든 사용자 목록
3. USER_USERS - 현재 사용자 정보
4. DBA_TS_QUOTAS - 테이블스페이스 할당량
5. USER_TS_QUOTAS - 사용자 할당량
6. DBA_USERS_WITH_DEFPWD - 기본 패스워드 사용자
7. V$PWFILE_USERS - 패스워드 파일 사용자
8. DBA_EDITIONS - Edition 정보
9. DBA_USERS_AE - Application Edition 사용자
10. SESSION_CONTEXT - 세션 컨텍스트
11. GLOBAL_CONTEXT - 글로벌 컨텍스트
12. V$CONTEXT - 컨텍스트 정보
13. DBA_CONTEXT - 컨텍스트 정의
14. DBA_GLOBAL_CONTEXT - 글로벌 컨텍스트
15. V$TIMEZONE_NAMES - 타임존 이름
16. V$TIMEZONE_FILE - 타임존 파일
17. DBA_USTATS - 사용자 통계
18. DBA_USERS_HIST - 사용자 이력
19. DBA_PROFILE_PASSWORDS - 프로파일 패스워드
20. DBA_PASSWORD_LIMITS - 패스워드 제한
21. USER_PASSWORD_LIMITS - 사용자 패스워드 제한
22. DBA_LOCAL_TEMP_FREE_SPACE - 로컬 임시 여유 공간
23. DBA_TEMP_FREE_SPACE - 임시 여유 공간
24. V$TEMP_SPACE_HEADER - 임시 공간 헤더
25. V$TEMPSTAT - 임시 통계

#### B2. 역할 관리 (18개)
1. DBA_ROLES - 모든 역할
2. DBA_ROLE_PRIVS - 역할 권한
3. USER_ROLE_PRIVS - 사용자 역할
4. ROLE_ROLE_PRIVS - 역할에 부여된 역할
5. ROLE_SYS_PRIVS - 역할 시스템 권한
6. ROLE_TAB_PRIVS - 역할 객체 권한
7. SESSION_ROLES - 세션 역할
8. DBA_ENABLED_ROLES - 활성화된 역할
9. DBA_APPLICATION_ROLES - 애플리케이션 역할
10. V$ENABLEDPRIVS - 활성화된 권한
11. ROLE_GRANT_MAP - 역할 부여 맵
12. DBA_ROLES_AE - Application Edition 역할
13. DBA_MANDATORY_ROLES - 필수 역할
14. DBA_ROLE_OWNERS - 역할 소유자
15. DBA_ROLE_DEPENDENCIES - 역할 의존성
16. V$ROLE_GRANT - 역할 부여
17. DBA_ENABLED_ROLE_PRIVS - 활성화된 역할 권한
18. SESSION_CONTEXT_ROLES - 세션 컨텍스트 역할

## 통계 요약

### 총 카탈로그 항목
- **총 시스템 테이블**: 약 200개
- **총 데이터 딕셔너리 뷰**: 약 2,000개 이상
- **총 동적 성능 뷰 (V$)**: 약 600개
- **총 RAC 뷰 (GV$)**: 약 600개

### 주요 스키마
- **SYS**: 시스템 테이블 소유자
- **SYSTEM**: 시스템 관리 스키마
- **DBSNMP**: 모니터링 스키마
- **OUTLN**: Outline 관리
- **CTXSYS**: Text 검색
- **MDSYS**: Spatial 데이터
- **XDB**: XML DB
- **WMSYS**: Workspace Manager

## 참고사항
- 이 카탈로그는 Oracle Database 19c 기준입니다
- 버전에 따라 뷰의 개수와 내용이 다를 수 있습니다
- 정보보안기사 시험에서는 주요 카테고리의 기본 뷰들을 숙지하는 것이 중요합니다
