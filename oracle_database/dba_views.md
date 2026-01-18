# DBA 관련 뷰 목록

## 개요
DBA_* 접두사를 가진 뷰들은 데이터베이스 전체의 정보를 제공하며, DBA 권한이 있는 사용자만 조회할 수 있습니다.

## 객체 관리 뷰

### 테이블 및 컬럼

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TABLES | 모든 테이블 정보 |
| DBA_TAB_COLUMNS | 모든 테이블의 컬럼 정보 |
| DBA_TAB_PRIVS | 테이블 권한 정보 |
| DBA_TAB_COMMENTS | 테이블 주석 |
| DBA_COL_COMMENTS | 컬럼 주석 |
| DBA_TAB_STATISTICS | 테이블 통계 정보 |
| DBA_TAB_MODIFICATIONS | 테이블 변경 정보 |
| DBA_TAB_PARTITIONS | 테이블 파티션 정보 |
| DBA_TAB_SUBPARTITIONS | 테이블 서브파티션 정보 |
| DBA_EXTERNAL_TABLES | 외부 테이블 정보 |
| DBA_OBJECT_TABLES | 객체 테이블 정보 |
| DBA_NESTED_TABLES | 중첩 테이블 정보 |

### 인덱스

| 뷰 이름 | 설명 |
|---------|------|
| DBA_INDEXES | 모든 인덱스 정보 |
| DBA_IND_COLUMNS | 인덱스 컬럼 정보 |
| DBA_IND_PARTITIONS | 인덱스 파티션 정보 |
| DBA_IND_SUBPARTITIONS | 인덱스 서브파티션 정보 |
| DBA_IND_EXPRESSIONS | 함수 기반 인덱스 표현식 |
| DBA_IND_STATISTICS | 인덱스 통계 |
| DBA_HISTOGRAMS | 히스토그램 정보 |

### 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_VIEWS | 모든 뷰 정보 |
| DBA_MVIEWS | Materialized View 정보 |
| DBA_MVIEW_LOGS | MView 로그 정보 |
| DBA_MVIEW_REFRESH_TIMES | MView 리프레시 시간 |
| DBA_MVIEW_AGGREGATES | MView 집계 정보 |
| DBA_REGISTERED_MVIEWS | 등록된 MView |

### 시퀀스 및 동의어

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SEQUENCES | 모든 시퀀스 |
| DBA_SYNONYMS | 모든 동의어 |

### 제약조건

| 뷰 이름 | 설명 |
|---------|------|
| DBA_CONSTRAINTS | 모든 제약조건 |
| DBA_CONS_COLUMNS | 제약조건 컬럼 |

### 트리거

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TRIGGERS | 모든 트리거 |
| DBA_TRIGGER_COLS | 트리거 컬럼 |

## PL/SQL 객체 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_OBJECTS | 모든 데이터베이스 객체 |
| DBA_PROCEDURES | 프로시저, 함수, 패키지 |
| DBA_SOURCE | PL/SQL 소스 코드 |
| DBA_ARGUMENTS | 프로시저/함수 인자 |
| DBA_DEPENDENCIES | 객체 의존성 |
| DBA_ERRORS | 컴파일 에러 정보 |
| DBA_OBJECT_SIZE | 객체 크기 정보 |

## 스토리지 관리 뷰

### 테이블스페이스

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TABLESPACES | 테이블스페이스 정보 |
| DBA_TABLESPACE_GROUPS | 테이블스페이스 그룹 |
| DBA_TABLESPACE_USAGE_METRICS | 테이블스페이스 사용량 메트릭 |

### 데이터파일

| 뷰 이름 | 설명 |
|---------|------|
| DBA_DATA_FILES | 데이터파일 정보 |
| DBA_TEMP_FILES | 임시파일 정보 |
| DBA_FREE_SPACE | 여유 공간 정보 |
| DBA_FREE_SPACE_COALESCED | 통합된 여유 공간 |

### 세그먼트 및 익스텐트

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SEGMENTS | 세그먼트 정보 |
| DBA_EXTENTS | 익스텐트 정보 |
| DBA_UNDO_EXTENTS | UNDO 익스텐트 |
| DBA_ROLLBACK_SEGS | 롤백 세그먼트 |

## 사용자 및 권한 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_USERS | 모든 데이터베이스 사용자 |
| DBA_ROLES | 모든 역할 |
| DBA_SYS_PRIVS | 시스템 권한 부여 |
| DBA_TAB_PRIVS | 객체 권한 부여 |
| DBA_ROLE_PRIVS | 역할 부여 |
| DBA_COL_PRIVS | 컬럼 권한 |
| DBA_TS_QUOTAS | 테이블스페이스 할당량 |
| DBA_PROFILES | 프로파일 정보 |

## 감사 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_AUDIT_TRAIL | 감사 추적 |
| DBA_AUDIT_SESSION | 세션 감사 |
| DBA_AUDIT_STATEMENT | 문장 감사 옵션 |
| DBA_AUDIT_OBJECT | 객체 감사 옵션 |
| DBA_FGA_AUDIT_TRAIL | Fine-Grained 감사 |
| DBA_COMMON_AUDIT_TRAIL | 공통 감사 추적 |

## 작업 스케줄링 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_JOBS | DBMS_JOB 작업 |
| DBA_JOBS_RUNNING | 실행 중인 작업 |
| DBA_SCHEDULER_JOBS | 스케줄러 작업 |
| DBA_SCHEDULER_JOB_RUN_DETAILS | 작업 실행 상세 |
| DBA_SCHEDULER_SCHEDULES | 스케줄 정보 |
| DBA_SCHEDULER_PROGRAMS | 프로그램 정보 |
| DBA_SCHEDULER_CHAINS | 체인 작업 |

## 복제 및 스트림 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_APPLY | Apply 프로세스 |
| DBA_CAPTURE | Capture 프로세스 |
| DBA_STREAMS_ADMINISTRATOR | Streams 관리자 |
| DBA_PROPAGATION | 전파 정보 |

## 데이터베이스 링크 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_DB_LINKS | 데이터베이스 링크 |
| DBA_2PC_PENDING | 보류 중인 분산 트랜잭션 |
| DBA_2PC_NEIGHBORS | 분산 트랜잭션 참여자 |

## 리소스 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_RSRC_PLANS | 리소스 계획 |
| DBA_RSRC_PLAN_DIRECTIVES | 리소스 계획 지시어 |
| DBA_RSRC_CONSUMER_GROUPS | 소비자 그룹 |
| DBA_RSRC_GROUP_MAPPINGS | 그룹 매핑 |

## 통계 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TAB_STATISTICS | 테이블 통계 |
| DBA_IND_STATISTICS | 인덱스 통계 |
| DBA_TAB_COL_STATISTICS | 컬럼 통계 |
| DBA_TAB_HISTOGRAMS | 테이블 히스토그램 |
| DBA_OPTSTAT_OPERATIONS | 통계 수집 작업 |

## 파티셔닝 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_PART_TABLES | 파티션 테이블 |
| DBA_TAB_PARTITIONS | 테이블 파티션 |
| DBA_TAB_SUBPARTITIONS | 서브파티션 |
| DBA_PART_KEY_COLUMNS | 파티션 키 컬럼 |
| DBA_PART_COL_STATISTICS | 파티션 컬럼 통계 |
| DBA_PART_INDEXES | 파티션 인덱스 |
| DBA_IND_PARTITIONS | 인덱스 파티션 |
| DBA_SUBPART_KEY_COLUMNS | 서브파티션 키 컬럼 |

## 클러스터 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_CLUSTERS | 클러스터 정보 |
| DBA_CLU_COLUMNS | 클러스터 컬럼 |

## LOB 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_LOBS | LOB 정보 |
| DBA_LOB_PARTITIONS | LOB 파티션 |
| DBA_LOB_SUBPARTITIONS | LOB 서브파티션 |

## 디렉토리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_DIRECTORIES | 디렉토리 객체 |

## 큐 관리 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_QUEUES | 큐 정보 |
| DBA_QUEUE_TABLES | 큐 테이블 |
| DBA_QUEUE_SCHEDULES | 큐 스케줄 |

## XML 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_XML_SCHEMAS | XML 스키마 |
| DBA_XML_TABLES | XML 테이블 |
| DBA_XML_TAB_COLS | XML 테이블 컬럼 |

## 유용한 DBA 쿼리

### 1. 데이터베이스 크기 조회
```sql
SELECT 
    SUM(bytes)/1024/1024/1024 AS size_gb
FROM dba_data_files;
```

### 2. 테이블스페이스 사용률
```sql
SELECT 
    tablespace_name,
    ROUND((used_space * 8192)/1024/1024/1024, 2) AS used_gb,
    ROUND((tablespace_size * 8192)/1024/1024/1024, 2) AS total_gb,
    ROUND(used_percent, 2) AS used_percent
FROM dba_tablespace_usage_metrics
ORDER BY used_percent DESC;
```

### 3. 가장 큰 테이블 조회
```sql
SELECT 
    owner, 
    segment_name, 
    segment_type,
    ROUND(bytes/1024/1024, 2) AS size_mb
FROM dba_segments
WHERE segment_type = 'TABLE'
ORDER BY bytes DESC
FETCH FIRST 20 ROWS ONLY;
```

### 4. 무효 객체 조회
```sql
SELECT 
    owner, 
    object_type, 
    object_name, 
    status
FROM dba_objects
WHERE status = 'INVALID'
ORDER BY owner, object_type, object_name;
```

### 5. 사용자별 객체 수
```sql
SELECT 
    owner, 
    object_type, 
    COUNT(*) AS object_count
FROM dba_objects
WHERE owner NOT IN ('SYS', 'SYSTEM', 'XDB', 'MDSYS', 'CTXSYS')
GROUP BY owner, object_type
ORDER BY owner, object_count DESC;
```

### 6. 최근 컴파일된 객체
```sql
SELECT 
    owner, 
    object_name, 
    object_type, 
    last_ddl_time, 
    status
FROM dba_objects
WHERE last_ddl_time >= SYSDATE - 7
ORDER BY last_ddl_time DESC;
```

## 참고사항
- DBA 뷰는 SELECT ANY DICTIONARY 또는 DBA 역할이 필요합니다
- 대용량 데이터베이스에서는 쿼리 실행 시간이 오래 걸릴 수 있습니다
- 성능을 위해 WHERE 절로 필터링하는 것이 좋습니다
