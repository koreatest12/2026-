# 2026-
2026년도 정보보안기사 공부

## 📚 학습 자료

### 오라클 데이터베이스 테이블 설계
정보보안 시스템을 위한 오라클 데이터베이스 테이블 구조 및 설계 문서가 포함되어 있습니다.

#### 📁 파일 목록
- **oracle_tables.sql** - 테이블 DDL 스크립트 (테이블 생성, 시퀀스, 인덱스, 제약조건)
- **oracle_sample_data.sql** - 샘플 데이터 삽입 스크립트
- **README_DATABASE.md** - 데이터베이스 설계 상세 문서
- **DATABASE_ERD.md** - 엔티티 관계도 (ERD)
- **QUICK_REFERENCE.md** - 빠른 참조 가이드

#### 🗂️ 테이블 구조

**1. 사용자 관리 (User Management)**
- USERS - 사용자 정보
- ROLES - 역할 정보
- USER_ROLES - 사용자-역할 매핑

**2. 접근 제어 (Access Control)**
- PERMISSIONS - 권한 정보
- ROLE_PERMISSIONS - 역할-권한 매핑

**3. 감사 로그 (Audit Logging)**
- AUDIT_LOGS - 시스템 감사 로그
- LOGIN_HISTORY - 로그인 이력

**4. 보안 정책 (Security Policies)**
- SECURITY_POLICIES - 보안 정책
- PASSWORD_POLICIES - 패스워드 정책
- PASSWORD_HISTORY - 패스워드 변경 이력

**5. 취약점 관리 (Vulnerability Management)**
- VULNERABILITIES - 취약점 정보
- SECURITY_INCIDENTS - 보안 사고

#### 🚀 빠른 시작

##### SQL*Plus 사용
```bash
sqlplus username/password@database

@oracle_tables.sql
@oracle_sample_data.sql
```

##### SQL Developer 사용
1. `oracle_tables.sql` 파일을 열고 스크립트 실행 (F5)
2. `oracle_sample_data.sql` 파일을 열고 스크립트 실행 (F5)

#### 📖 문서 안내
- 상세한 테이블 설명은 [README_DATABASE.md](README_DATABASE.md) 참조
- ERD 및 관계도는 [DATABASE_ERD.md](DATABASE_ERD.md) 참조
- 자주 사용하는 쿼리는 [QUICK_REFERENCE.md](QUICK_REFERENCE.md) 참조

#### 🔐 보안 기능
- RBAC (Role-Based Access Control) 구현
- 패스워드 정책 및 이력 관리
- 로그인 실패 추적 및 계정 잠금
- 전체 감사 로그 기록
- 취약점 및 보안 사고 추적

#### 📊 주요 특징
- 정규화된 테이블 구조
- 성능 최적화를 위한 인덱스 설계
- 데이터 무결성을 위한 제약조건
- 시퀀스를 통한 자동 ID 생성
- 한국어 코멘트 및 문서

---

## 📝 라이선스
이 자료는 정보보안기사 학습 목적으로 제공됩니다.
