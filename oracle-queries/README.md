# Oracle 데이터베이스 쿼리 모음집

정보보안기사 시험 대비를 위한 Oracle 데이터베이스 쿼리 모음집입니다.

## 📚 목차

1. [DDL (Data Definition Language) 쿼리](#ddl-queries)
2. [DML (Data Manipulation Language) 쿼리](#dml-queries)
3. [보안 관련 쿼리](#security-queries)
4. [사용자 및 권한 관리 쿼리](#user-privilege-queries)
5. [감사 및 모니터링 쿼리](#audit-monitoring-queries)
6. [데이터베이스 관리 및 성능 쿼리](#database-management-queries)

---

## 📖 파일 설명

### 01-DDL-queries.sql
**DDL (Data Definition Language) 쿼리 목록**

데이터베이스 객체의 구조를 정의하고 관리하는 쿼리들을 포함합니다.

#### 주요 내용:
- **테이블 생성 및 관리**
  - CREATE TABLE (기본, 제약조건, 외래키, CHECK 제약조건)
  - ALTER TABLE (컬럼 추가/수정/삭제, 제약조건 관리)
  - DROP TABLE, TRUNCATE TABLE
  
- **인덱스 관리**
  - 일반 인덱스, 유니크 인덱스, 비트맵 인덱스
  - 함수 기반 인덱스
  - 인덱스 재생성 및 삭제
  
- **뷰(View) 관리**
  - 단순 뷰, 복합 뷰, 읽기 전용 뷰
  - 뷰 수정 및 삭제
  
- **시퀀스(Sequence)**
  - 시퀀스 생성, 수정, 삭제
  - NEXTVAL, CURRVAL 사용
  
- **동의어(Synonym)**
  - 개인/공용 동의어 생성 및 삭제
  
- **테이블스페이스 관리**
  - 테이블스페이스 생성, 수정, 삭제
  
- **주석(Comment) 추가**
  - 테이블 및 컬럼 주석

---

### 02-DML-queries.sql
**DML (Data Manipulation Language) 쿼리 목록**

데이터 조회, 삽입, 수정, 삭제 등 데이터 조작에 관련된 쿼리들을 포함합니다.

#### 주요 내용:
- **데이터 조회 (SELECT)**
  - 기본 조회, 조건부 조회 (WHERE)
  - 정렬 (ORDER BY), 중복 제거 (DISTINCT)
  - ROWNUM, FETCH를 이용한 제한 조회
  
- **조인(JOIN)**
  - INNER JOIN, LEFT/RIGHT/FULL OUTER JOIN
  - SELF JOIN
  
- **그룹화 및 집계**
  - COUNT, AVG, SUM, MAX, MIN
  - GROUP BY, HAVING
  - ROLLUP, CUBE
  
- **서브쿼리(Subquery)**
  - 단일 행, 다중 행 서브쿼리
  - 상관 서브쿼리, EXISTS
  
- **집합 연산자**
  - UNION, UNION ALL, INTERSECT, MINUS
  
- **데이터 조작**
  - INSERT (기본, 다중 행, 서브쿼리)
  - UPDATE (기본, 다중 컬럼, 서브쿼리)
  - DELETE
  - MERGE
  
- **트랜잭션 제어**
  - COMMIT, ROLLBACK, SAVEPOINT
  
- **함수**
  - 문자열 함수 (UPPER, LOWER, LENGTH, SUBSTR, TRIM)
  - 숫자 함수 (ROUND, TRUNC, MOD)
  - 날짜 함수 (SYSDATE, MONTHS_BETWEEN, ADD_MONTHS)
  - 변환 함수 (TO_NUMBER, TO_CHAR, TO_DATE, NVL, COALESCE)
  - 조건 함수 (CASE, DECODE)

---

### 03-security-queries.sql
**보안 관련 쿼리 목록**

데이터베이스 보안을 위한 종합적인 쿼리들을 포함합니다.

#### 주요 내용:
- **사용자 계정 관리**
  - 사용자 생성, 비밀번호 변경
  - 계정 잠금/잠금 해제
  - 비밀번호 만료, 사용자 삭제
  
- **권한 관리**
  - 시스템 권한 부여/회수 (GRANT/REVOKE)
  - 객체 권한 부여/회수
  - WITH ADMIN OPTION, WITH GRANT OPTION
  
- **롤(Role) 관리**
  - 롤 생성, 권한 부여
  - 롤 활성화/비활성화
  - 미리 정의된 롤 (CONNECT, RESOURCE, DBA)
  
- **프로파일(Profile) - 비밀번호 정책**
  - 비밀번호 정책 설정
  - 로그인 실패 제한, 비밀번호 수명
  - 리소스 제한 설정
  
- **감사(Audit)**
  - 문장 감사, 권한 감사, 객체 감사
  - 감사 로그 조회
  - Fine-Grained Auditing (FGA)
  
- **데이터 암호화 (TDE)**
  - 테이블스페이스 암호화
  - 컬럼 암호화
  
- **VPD (Row Level Security)**
  - 보안 정책 함수 생성 및 적용
  
- **비밀번호 검증 함수**
  - 복잡성 검사 함수 생성
  
- **데이터 마스킹 (Data Redaction)**
  - 데이터 마스킹 정책 생성

---

### 04-user-privilege-queries.sql
**사용자 및 권한 관리 쿼리 목록**

사용자 계정과 권한을 관리하는 상세한 쿼리들을 포함합니다.

#### 주요 내용:
- **사용자 생성 및 설정**
  - 기본 테이블스페이스 지정
  - 쿼터 제한 설정
  
- **사용자 정보 수정**
  - 비밀번호, 테이블스페이스 변경
  - 계정 잠금 관리
  - 프로파일 변경
  
- **시스템 권한**
  - 기본 시스템 권한 (CREATE SESSION, CREATE TABLE 등)
  - 고급 시스템 권한 (CREATE ANY TABLE, ALTER ANY TABLE 등)
  - 데이터베이스 관리 권한
  
- **객체 권한**
  - 테이블, 뷰, 시퀀스, 프로시저 권한
  - 특정 컬럼 권한
  
- **롤 관리**
  - 롤 생성 및 권한 부여
  - 기본 제공 롤
  - 기본 롤 설정
  
- **권한 조회**
  - 사용자 정보, 권한, 롤 조회
  - 현재 세션 정보
  
- **프로파일 관리**
  - 프로파일 생성 및 설정 조회
  
- **접속 세션 관리**
  - 세션 조회 및 종료
  
- **잠긴 계정 관리**
  - 잠긴 계정 조회 및 해제

---

### 05-audit-monitoring-queries.sql
**감사 및 모니터링 쿼리 목록**

데이터베이스 활동을 감사하고 모니터링하는 쿼리들을 포함합니다.

#### 주요 내용:
- **감사 기능 활성화**
  - AUDIT_TRAIL 파라미터 설정
  - 통합 감사 활성화
  
- **문장 감사 (Statement Auditing)**
  - 테이블, 세션 관련 문장 감사
  - DDL, DML 문장 감사
  
- **권한 감사 (Privilege Auditing)**
  - 시스템 권한 감사
  - 성공/실패 조건 감사
  
- **객체 감사 (Object Auditing)**
  - 특정 테이블/뷰 감사
  - 사용자별 객체 감사
  
- **감사 로그 조회**
  - 전체 감사 로그, 세션 감사 로그
  - 실패한 로그인 시도 조회
  
- **Fine-Grained Auditing (FGA)**
  - FGA 정책 생성 및 관리
  - 컬럼 단위 감사
  - FGA 로그 조회
  
- **데이터베이스 활동 모니터링**
  - 현재 세션 정보
  - SQL 실행 이력
  - 잠금(Lock) 모니터링
  
- **리소스 사용 모니터링**
  - 테이블스페이스 사용률
  - 큰 테이블 조회
  
- **보안 이벤트 모니터링**
  - 계정 잠금 이벤트
  - 권한 변경 이력
  - 비정상 접속 탐지
  
- **통합 감사 (Oracle 12c 이상)**
  - 통합 감사 정책 생성 및 관리
  
- **감사 로그 정리**
  - 오래된 감사 로그 삭제 및 아카이브

---

### 06-database-management-queries.sql
**데이터베이스 관리 및 성능 쿼리 목록**

데이터베이스 관리와 성능 튜닝에 관련된 쿼리들을 포함합니다.

#### 주요 내용:
- **데이터베이스 정보**
  - 데이터베이스 버전, 인스턴스 정보
  - 파라미터 조회
  
- **테이블스페이스 관리**
  - 테이블스페이스 목록 및 사용률
  - 데이터 파일 정보
  
- **스키마 객체 정보**
  - 테이블, 인덱스, 뷰, 시퀀스 정보
  - 프로시저, 함수 정보
  
- **제약조건 조회**
  - 테이블 제약조건
  - 외래키 관계
  
- **통계 정보 관리**
  - 테이블, 인덱스, 컬럼 통계
  - 통계 수집
  
- **세그먼트 및 익스텐트**
  - 세그먼트 크기 조회
  - 큰 테이블 조회
  
- **무효화된 객체 관리**
  - 무효화된 객체 조회 및 재컴파일
  
- **의존성 조회**
  - 객체 간 의존 관계
  
- **Redo 로그 관리**
  - Redo 로그 파일 및 그룹 정보
  - 로그 스위치 이력
  
- **아카이브 로그 관리**
  - 아카이브 모드 확인
  - 아카이브 로그 정보
  
- **백업 및 복구**
  - RMAN 백업 정보
  
- **성능 관련 뷰**
  - 대기 이벤트 통계
  - 시스템 통계
  
- **메모리 정보**
  - SGA, PGA 메모리 통계
  
- **SQL 튜닝**
  - 실행 계획 확인
  - 바인드 변수 조회
  
- **데이터베이스 링크**
  - 데이터베이스 링크 관리

---

## 🎯 사용 방법

### 1. SQL*Plus에서 실행
```sql
SQL> @01-DDL-queries.sql
```

### 2. SQL Developer에서 실행
1. 파일 열기 (File > Open)
2. 실행하려는 쿼리 선택
3. F5 또는 실행 버튼 클릭

### 3. 특정 쿼리만 실행
- 필요한 쿼리만 복사하여 실행
- 주석을 참고하여 적절한 쿼리 선택

---

## 📝 학습 가이드

### 정보보안기사 시험 대비 학습 순서

1. **기본 개념 학습** (1-2주차)
   - DDL 쿼리로 데이터베이스 객체 생성 학습
   - DML 쿼리로 데이터 조작 학습

2. **보안 개념 학습** (3-4주차)
   - 사용자 및 권한 관리 쿼리 학습
   - 롤과 프로파일 개념 이해

3. **고급 보안 기능** (5-6주차)
   - 감사(Audit) 기능 학습
   - 암호화 및 VPD 개념 이해

4. **실전 연습** (7-8주차)
   - 모니터링 쿼리로 실시간 감시 연습
   - 데이터베이스 관리 쿼리로 성능 분석

---

## ⚠️ 주의사항

### 운영 환경에서 주의할 점

1. **DROP 명령어**
   - `DROP TABLE`, `DROP USER CASCADE` 등은 데이터를 완전히 삭제합니다
   - 운영 환경에서는 반드시 백업 후 실행하세요

2. **TRUNCATE 명령어**
   - 롤백이 불가능합니다
   - 테스트 환경에서 먼저 테스트하세요

3. **권한 부여**
   - `GRANT DBA`는 모든 권한을 부여합니다
   - 최소 권한 원칙을 따라 필요한 권한만 부여하세요

4. **감사 기능**
   - 감사 로그는 디스크 공간을 많이 차지할 수 있습니다
   - 정기적으로 감사 로그를 아카이브하거나 삭제하세요

5. **통계 수집**
   - `DBMS_STATS.GATHER_DATABASE_STATS`는 시간이 오래 걸립니다
   - 사용량이 적은 시간에 실행하세요

---

## 🔒 보안 모범 사례

### 1. 비밀번호 정책
```sql
CREATE PROFILE secure_profile LIMIT
    FAILED_LOGIN_ATTEMPTS 3
    PASSWORD_LIFE_TIME 90
    PASSWORD_REUSE_TIME 365
    PASSWORD_LOCK_TIME 1;
```

### 2. 최소 권한 원칙
```sql
-- 나쁜 예
GRANT DBA TO app_user;

-- 좋은 예
GRANT CREATE SESSION TO app_user;
GRANT SELECT, INSERT, UPDATE ON specific_table TO app_user;
```

### 3. 감사 활성화
```sql
AUDIT SESSION WHENEVER NOT SUCCESSFUL;
AUDIT SELECT ON sensitive_table;
```

### 4. 데이터 암호화
```sql
CREATE TABLE secure_data (
    id NUMBER PRIMARY KEY,
    ssn VARCHAR2(11) ENCRYPT USING 'AES256'
);
```

---

## 📚 참고 자료

### 공식 문서
- [Oracle Database Documentation](https://docs.oracle.com/en/database/)
- [Oracle Security Guide](https://docs.oracle.com/en/database/oracle/oracle-database/19/dbseg/)
- [Oracle SQL Reference](https://docs.oracle.com/en/database/oracle/oracle-database/19/sqlrf/)

### 정보보안기사 관련
- 한국인터넷진흥원(KISA) 정보보안기사 안내
- 정보보안기사 실기 기출문제
- Oracle Database 보안 가이드

---

## 🤝 기여 방법

이 저장소는 정보보안기사 시험 대비를 위한 학습 자료입니다.

### 개선 사항 제안
1. Issues 탭에서 새로운 이슈 생성
2. 추가하고 싶은 쿼리나 개선 사항 설명
3. Pull Request 제출

---

## 📄 라이선스

이 프로젝트는 학습 목적으로 자유롭게 사용할 수 있습니다.

---

## 📞 문의

- GitHub Issues를 통해 질문하거나 개선 사항을 제안해주세요
- 정보보안기사 시험 준비에 도움이 되는 자료를 함께 만들어갑시다

---

## 📊 파일 통계

| 파일명 | 쿼리 카테고리 수 | 설명 |
|--------|-----------------|------|
| 01-DDL-queries.sql | 10 | 테이블, 인덱스, 뷰, 시퀀스 등 DDL |
| 02-DML-queries.sql | 15 | SELECT, INSERT, UPDATE, DELETE 등 DML |
| 03-security-queries.sql | 15 | 사용자, 권한, 감사, 암호화 등 보안 |
| 04-user-privilege-queries.sql | 15 | 사용자 및 권한 상세 관리 |
| 05-audit-monitoring-queries.sql | 17 | 감사 및 모니터링 |
| 06-database-management-queries.sql | 16 | 데이터베이스 관리 및 성능 |

---

**마지막 업데이트:** 2026-01-18

**버전:** 1.0.0

**목적:** 정보보안기사 시험 대비용 Oracle 쿼리 모음집
