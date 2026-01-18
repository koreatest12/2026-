# Oracle 데이터 딕셔너리 뷰 목록

## 개요
Oracle 데이터 딕셔너리는 3가지 주요 접두사를 사용합니다:
- **DBA_\*** - 데이터베이스의 모든 객체에 대한 정보 (DBA 권한 필요)
- **ALL_\*** - 현재 사용자가 접근 가능한 모든 객체에 대한 정보
- **USER_\*** - 현재 사용자가 소유한 객체에 대한 정보

## 주요 데이터 딕셔너리 뷰

### 테이블 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TABLES | 데이터베이스의 모든 테이블 |
| ALL_TABLES | 사용자가 접근 가능한 모든 테이블 |
| USER_TABLES | 사용자 소유의 테이블 |
| DBA_TAB_COLUMNS | 모든 테이블의 컬럼 정보 |
| ALL_TAB_COLUMNS | 접근 가능한 테이블의 컬럼 정보 |
| USER_TAB_COLUMNS | 사용자 테이블의 컬럼 정보 |
| DBA_TAB_COMMENTS | 테이블 주석 |
| DBA_COL_COMMENTS | 컬럼 주석 |

### 인덱스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_INDEXES | 모든 인덱스 정보 |
| ALL_INDEXES | 접근 가능한 인덱스 정보 |
| USER_INDEXES | 사용자 소유 인덱스 |
| DBA_IND_COLUMNS | 인덱스 컬럼 정보 |
| DBA_IND_PARTITIONS | 인덱스 파티션 정보 |
| DBA_IND_STATISTICS | 인덱스 통계 정보 |

### 뷰 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_VIEWS | 모든 뷰 정보 |
| ALL_VIEWS | 접근 가능한 뷰 |
| USER_VIEWS | 사용자 소유 뷰 |
| DBA_MVIEWS | Materialized View 정보 |
| DBA_MVIEW_LOGS | MView 로그 정보 |

### 시퀀스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SEQUENCES | 모든 시퀀스 정보 |
| ALL_SEQUENCES | 접근 가능한 시퀀스 |
| USER_SEQUENCES | 사용자 소유 시퀀스 |

### 제약조건 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_CONSTRAINTS | 모든 제약조건 |
| ALL_CONSTRAINTS | 접근 가능한 제약조건 |
| USER_CONSTRAINTS | 사용자 소유 제약조건 |
| DBA_CONS_COLUMNS | 제약조건 컬럼 정보 |

### 트리거 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TRIGGERS | 모든 트리거 |
| ALL_TRIGGERS | 접근 가능한 트리거 |
| USER_TRIGGERS | 사용자 소유 트리거 |
| DBA_TRIGGER_COLS | 트리거 컬럼 정보 |

### 프로시저/함수/패키지 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_PROCEDURES | 모든 프로시저/함수 |
| ALL_PROCEDURES | 접근 가능한 프로시저/함수 |
| USER_PROCEDURES | 사용자 소유 프로시저/함수 |
| DBA_SOURCE | PL/SQL 소스 코드 |
| ALL_SOURCE | 접근 가능한 소스 코드 |
| USER_SOURCE | 사용자 소유 소스 코드 |
| DBA_OBJECTS | 모든 객체 정보 |
| ALL_OBJECTS | 접근 가능한 객체 |
| USER_OBJECTS | 사용자 소유 객체 |

### 파티션 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_PART_TABLES | 파티션 테이블 정보 |
| DBA_TAB_PARTITIONS | 테이블 파티션 정보 |
| DBA_TAB_SUBPARTITIONS | 서브파티션 정보 |
| DBA_PART_KEY_COLUMNS | 파티션 키 컬럼 |

### 동의어(Synonym) 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_SYNONYMS | 모든 동의어 |
| ALL_SYNONYMS | 접근 가능한 동의어 |
| USER_SYNONYMS | 사용자 소유 동의어 |

### 데이터베이스 링크 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_DB_LINKS | 모든 데이터베이스 링크 |
| ALL_DB_LINKS | 접근 가능한 DB 링크 |
| USER_DB_LINKS | 사용자 소유 DB 링크 |

### 클러스터 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_CLUSTERS | 모든 클러스터 |
| ALL_CLUSTERS | 접근 가능한 클러스터 |
| USER_CLUSTERS | 사용자 소유 클러스터 |
| DBA_CLU_COLUMNS | 클러스터 컬럼 정보 |

### 스토리지 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TABLESPACES | 테이블스페이스 정보 |
| DBA_DATA_FILES | 데이터파일 정보 |
| DBA_TEMP_FILES | 임시파일 정보 |
| DBA_SEGMENTS | 세그먼트 정보 |
| DBA_EXTENTS | 익스텐트 정보 |
| DBA_FREE_SPACE | 여유 공간 정보 |

### 세션 및 프로세스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$SESSION | 현재 세션 정보 |
| V$PROCESS | 프로세스 정보 |
| V$SQL | SQL 문장 정보 |
| V$SQLAREA | SQL 영역 정보 |
| V$SQLTEXT | SQL 텍스트 |

### 통계 및 성능 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_TAB_STATISTICS | 테이블 통계 |
| DBA_IND_STATISTICS | 인덱스 통계 |
| V$SYSSTAT | 시스템 통계 |
| V$SESSTAT | 세션 통계 |
| V$WAITSTAT | 대기 통계 |

### 복구 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$LOG | 리두 로그 그룹 정보 |
| V$LOGFILE | 리두 로그 파일 정보 |
| V$ARCHIVED_LOG | 아카이브 로그 정보 |
| V$BACKUP | 백업 정보 |
| V$RECOVERY_FILE_DEST | 복구 파일 위치 |

### 잠금(Lock) 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| V$LOCK | 현재 락 정보 |
| V$LOCKED_OBJECT | 잠긴 객체 정보 |
| DBA_BLOCKERS | 블로킹 세션 정보 |
| DBA_WAITERS | 대기 중인 세션 정보 |
| DBA_DDL_LOCKS | DDL 락 정보 |
| DBA_DML_LOCKS | DML 락 정보 |

### 리소스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| DBA_PROFILES | 프로파일 정보 |
| DBA_RESOURCE_LIMITS | 리소스 제한 정보 |
| V$RESOURCE_LIMIT | 현재 리소스 제한 |

## 유용한 쿼리 예제

### 현재 데이터베이스의 모든 테이블 조회
```sql
SELECT table_name, tablespace_name, num_rows 
FROM dba_tables 
WHERE owner = 'HR';
```

### 특정 테이블의 컬럼 정보 조회
```sql
SELECT column_name, data_type, data_length, nullable
FROM dba_tab_columns
WHERE table_name = 'EMPLOYEES'
AND owner = 'HR';
```

### 현재 접속 중인 세션 조회
```sql
SELECT username, sid, serial#, status, machine, program
FROM v$session
WHERE username IS NOT NULL;
```

## 참고사항
- 데이터 딕셔너리 뷰는 읽기 전용입니다
- V$ 뷰는 동적 성능 뷰로 데이터베이스 운영 정보를 제공합니다
- GV$ 뷰는 RAC 환경에서 모든 인스턴스의 정보를 제공합니다
