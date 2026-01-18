# 사용자 레벨 뷰 목록

## 개요
USER_* 접두사를 가진 뷰들은 현재 로그인한 사용자가 소유한 객체에 대한 정보만 제공합니다.

## 테이블 및 컬럼 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_TABLES | 사용자 소유 테이블 |
| USER_TAB_COLUMNS | 사용자 테이블의 컬럼 정보 |
| USER_TAB_COMMENTS | 테이블 주석 |
| USER_COL_COMMENTS | 컬럼 주석 |
| USER_TAB_PRIVS | 사용자 테이블에 부여된 권한 |
| USER_TAB_PRIVS_MADE | 사용자가 부여한 권한 |
| USER_TAB_PRIVS_RECD | 사용자가 받은 권한 |
| USER_COL_PRIVS | 컬럼 레벨 권한 |
| USER_COL_PRIVS_MADE | 사용자가 부여한 컬럼 권한 |
| USER_COL_PRIVS_RECD | 사용자가 받은 컬럼 권한 |

## 인덱스 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_INDEXES | 사용자 소유 인덱스 |
| USER_IND_COLUMNS | 인덱스 컬럼 정보 |
| USER_IND_PARTITIONS | 인덱스 파티션 |
| USER_IND_SUBPARTITIONS | 인덱스 서브파티션 |
| USER_IND_EXPRESSIONS | 함수 기반 인덱스 표현식 |
| USER_IND_STATISTICS | 인덱스 통계 |

## 뷰 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_VIEWS | 사용자 소유 뷰 |
| USER_UPDATABLE_COLUMNS | 업데이트 가능한 뷰 컬럼 |
| USER_MVIEWS | Materialized View |
| USER_MVIEW_LOGS | MView 로그 |
| USER_MVIEW_REFRESH_TIMES | MView 리프레시 시간 |

## 시퀀스 및 동의어

| 뷰 이름 | 설명 |
|---------|------|
| USER_SEQUENCES | 사용자 소유 시퀀스 |
| USER_SYNONYMS | 사용자 소유 동의어 |

## 제약조건 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_CONSTRAINTS | 사용자 소유 제약조건 |
| USER_CONS_COLUMNS | 제약조건 컬럼 |

## 트리거 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_TRIGGERS | 사용자 소유 트리거 |
| USER_TRIGGER_COLS | 트리거 컬럼 |

## PL/SQL 객체 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_OBJECTS | 사용자 소유 객체 |
| USER_PROCEDURES | 프로시저, 함수, 패키지 |
| USER_SOURCE | PL/SQL 소스 코드 |
| USER_ARGUMENTS | 프로시저/함수 인자 |
| USER_DEPENDENCIES | 객체 의존성 |
| USER_ERRORS | 컴파일 에러 |
| USER_OBJECT_SIZE | 객체 크기 |

## 파티션 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_PART_TABLES | 파티션 테이블 |
| USER_TAB_PARTITIONS | 테이블 파티션 |
| USER_TAB_SUBPARTITIONS | 서브파티션 |
| USER_PART_KEY_COLUMNS | 파티션 키 컬럼 |
| USER_PART_INDEXES | 파티션 인덱스 |
| USER_IND_PARTITIONS | 인덱스 파티션 |
| USER_SUBPART_KEY_COLUMNS | 서브파티션 키 컬럼 |

## 클러스터 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_CLUSTERS | 클러스터 정보 |
| USER_CLU_COLUMNS | 클러스터 컬럼 |

## LOB 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_LOBS | LOB 정보 |
| USER_LOB_PARTITIONS | LOB 파티션 |
| USER_LOB_SUBPARTITIONS | LOB 서브파티션 |

## 사용자 정보 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_USERS | 현재 사용자 정보 |
| USER_ROLE_PRIVS | 사용자에게 부여된 역할 |
| USER_SYS_PRIVS | 사용자의 시스템 권한 |
| USER_TS_QUOTAS | 테이블스페이스 할당량 |
| USER_RESOURCE_LIMITS | 리소스 제한 |
| USER_PASSWORD_LIMITS | 패스워드 제한 |

## 감사 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_AUDIT_TRAIL | 사용자 감사 추적 |
| USER_AUDIT_OBJECT | 객체 감사 옵션 |
| USER_AUDIT_POLICIES | 감사 정책 |

## 통계 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_TAB_STATISTICS | 테이블 통계 |
| USER_IND_STATISTICS | 인덱스 통계 |
| USER_TAB_COL_STATISTICS | 컬럼 통계 |
| USER_TAB_HISTOGRAMS | 히스토그램 |
| USER_TAB_MODIFICATIONS | 테이블 변경 사항 |

## 세그먼트 및 익스텐트

| 뷰 이름 | 설명 |
|---------|------|
| USER_SEGMENTS | 사용자 세그먼트 |
| USER_EXTENTS | 사용자 익스텐트 |

## 작업 스케줄링

| 뷰 이름 | 설명 |
|---------|------|
| USER_JOBS | DBMS_JOB 작업 |
| USER_SCHEDULER_JOBS | 스케줄러 작업 |
| USER_SCHEDULER_JOB_RUN_DETAILS | 작업 실행 상세 |
| USER_SCHEDULER_SCHEDULES | 스케줄 |
| USER_SCHEDULER_PROGRAMS | 프로그램 |

## 데이터베이스 링크

| 뷰 이름 | 설명 |
|---------|------|
| USER_DB_LINKS | 사용자 DB 링크 |

## 큐 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_QUEUES | 큐 정보 |
| USER_QUEUE_TABLES | 큐 테이블 |

## XML 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_XML_SCHEMAS | XML 스키마 |
| USER_XML_TABLES | XML 테이블 |
| USER_XML_TAB_COLS | XML 테이블 컬럼 |

## 암호화 관련 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_ENCRYPTED_COLUMNS | 암호화된 컬럼 |

## 보안 정책 뷰

| 뷰 이름 | 설명 |
|---------|------|
| USER_POLICIES | RLS 정책 |
| USER_POLICY_GROUPS | 정책 그룹 |

## 유용한 USER 뷰 쿼리

### 1. 내 테이블 목록 조회
```sql
SELECT table_name, num_rows, tablespace_name
FROM user_tables
ORDER BY table_name;
```

### 2. 특정 테이블의 컬럼 정보
```sql
SELECT 
    column_name, 
    data_type, 
    data_length, 
    nullable, 
    data_default
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES'
ORDER BY column_id;
```

### 3. 내 인덱스 목록
```sql
SELECT 
    index_name, 
    table_name, 
    uniqueness, 
    status
FROM user_indexes
ORDER BY table_name, index_name;
```

### 4. 컬럼별 인덱스 정보
```sql
SELECT 
    i.table_name,
    i.index_name,
    ic.column_name,
    ic.column_position
FROM user_indexes i
JOIN user_ind_columns ic ON i.index_name = ic.index_name
WHERE i.table_name = 'EMPLOYEES'
ORDER BY i.index_name, ic.column_position;
```

### 5. 내 권한 조회
```sql
-- 시스템 권한
SELECT * FROM user_sys_privs ORDER BY privilege;

-- 역할
SELECT * FROM user_role_privs ORDER BY granted_role;

-- 객체 권한 (받은 것)
SELECT * FROM user_tab_privs_recd ORDER BY table_name;
```

### 6. 무효 객체 조회
```sql
SELECT 
    object_name, 
    object_type, 
    status, 
    last_ddl_time
FROM user_objects
WHERE status = 'INVALID'
ORDER BY object_type, object_name;
```

### 7. 제약조건 조회
```sql
SELECT 
    constraint_name, 
    constraint_type, 
    table_name, 
    search_condition
FROM user_constraints
WHERE table_name = 'EMPLOYEES'
ORDER BY constraint_type;
```

### 8. 외래키 관계 조회
```sql
SELECT 
    a.table_name AS child_table,
    a.constraint_name,
    a.column_name AS child_column,
    c_pk.table_name AS parent_table,
    b.column_name AS parent_column
FROM user_cons_columns a
JOIN user_constraints c ON a.constraint_name = c.constraint_name
JOIN user_constraints c_pk ON c.r_constraint_name = c_pk.constraint_name
JOIN user_cons_columns b ON c_pk.constraint_name = b.constraint_name
WHERE c.constraint_type = 'R'
ORDER BY a.table_name, a.constraint_name;
```

### 9. 트리거 정보 조회
```sql
SELECT 
    trigger_name, 
    trigger_type, 
    triggering_event, 
    table_name, 
    status
FROM user_triggers
ORDER BY table_name, trigger_name;
```

### 10. 테이블 크기 조회
```sql
SELECT 
    segment_name, 
    segment_type,
    ROUND(bytes/1024/1024, 2) AS size_mb
FROM user_segments
WHERE segment_type = 'TABLE'
ORDER BY bytes DESC;
```

### 11. 소스 코드 조회
```sql
SELECT text
FROM user_source
WHERE name = 'MY_PROCEDURE'
ORDER BY line;
```

### 12. 의존성 조회
```sql
SELECT 
    name, 
    type, 
    referenced_name, 
    referenced_type
FROM user_dependencies
WHERE name = 'MY_PACKAGE'
ORDER BY referenced_name;
```

## 참고사항
- USER 뷰는 일반 사용자가 가장 많이 사용하는 뷰입니다
- OWNER 컬럼이 없으며, 모든 객체가 현재 사용자 소유입니다
- DBA 권한 없이도 조회 가능합니다
- 성능이 DBA 뷰보다 우수합니다
