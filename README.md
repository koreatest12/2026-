# 2026 정보보안기사 공부 자료

2026년도 정보보안기사 시험 대비 학습 자료 저장소입니다.

## 📚 저장소 구조

```
2026-/
├── oracle-queries/           # Oracle 데이터베이스 쿼리 모음
│   ├── 01-DDL-queries.sql
│   ├── 02-DML-queries.sql
│   ├── 03-security-queries.sql
│   ├── 04-user-privilege-queries.sql
│   ├── 05-audit-monitoring-queries.sql
│   ├── 06-database-management-queries.sql
│   └── README.md
└── README.md
```

## 🎯 학습 자료

### Oracle 데이터베이스 쿼리 모음

정보보안기사 시험의 데이터베이스 보안 과목을 대비하기 위한 Oracle 쿼리 모음집입니다.

#### 포함된 내용:
1. **DDL (Data Definition Language)** - 테이블, 인덱스, 뷰, 시퀀스 등 데이터베이스 객체 관리
2. **DML (Data Manipulation Language)** - 데이터 조회, 삽입, 수정, 삭제
3. **보안 관련 쿼리** - 사용자 관리, 권한 관리, 감사, 암호화, VPD
4. **사용자 및 권한 관리** - 사용자 생성, 권한 부여, 롤 관리, 프로파일 설정
5. **감사 및 모니터링** - 감사 설정, 로그 조회, 활동 모니터링
6. **데이터베이스 관리 및 성능** - 성능 튜닝, 백업, 통계 관리

자세한 내용은 [oracle-queries/README.md](oracle-queries/README.md)를 참고하세요.

## 📖 사용 방법

### Oracle 쿼리 실행
```bash
# SQL*Plus에서 실행
SQL> @oracle-queries/01-DDL-queries.sql

# 또는 SQL Developer에서 파일을 열어 실행
```

### 학습 순서
1. DDL 및 DML 기본 쿼리로 시작 (1-2주)
2. 사용자 및 권한 관리 학습 (3-4주)
3. 보안 기능 (감사, 암호화) 학습 (5-6주)
4. 모니터링 및 성능 관리 학습 (7-8주)

## 🔒 정보보안기사 주요 학습 영역

### 데이터베이스 보안
- ✅ Oracle 사용자 및 권한 관리
- ✅ 롤(Role) 기반 접근 제어
- ✅ 프로파일을 이용한 비밀번호 정책
- ✅ 감사(Audit) 기능
- ✅ 데이터 암호화 (TDE)
- ✅ VPD (Virtual Private Database)
- ✅ Fine-Grained Auditing
- ✅ 데이터 마스킹

### 추가 예정
- [ ] 네트워크 보안
- [ ] 시스템 보안
- [ ] 애플리케이션 보안
- [ ] 정보보호 관리

## 📝 학습 팁

1. **실습 환경 구축**: Oracle Database Express Edition (XE) 설치
2. **반복 학습**: 주요 쿼리는 직접 타이핑하며 학습
3. **기출문제 풀이**: 학습한 내용을 기출문제에 적용
4. **개념 정리**: 각 보안 기능의 목적과 사용 시나리오 이해

## ⚠️ 주의사항

- 운영 환경에서는 절대 테스트하지 마세요
- DROP, TRUNCATE 등의 명령어는 신중하게 사용하세요
- 권한 부여 시 최소 권한 원칙을 따르세요
- 감사 로그는 정기적으로 관리하세요

## 📚 참고 자료

- [Oracle Database Documentation](https://docs.oracle.com/en/database/)
- [한국인터넷진흥원(KISA) 정보보안기사](https://www.kisa.or.kr/)
- [정보보안기사 실기 가이드](https://www.q-net.or.kr/)

## 🤝 기여

학습 자료 개선을 위한 기여를 환영합니다!
- Issues를 통한 오류 신고
- Pull Request를 통한 자료 추가 및 수정

## 📄 라이선스

이 저장소의 자료는 학습 목적으로 자유롭게 사용할 수 있습니다.

---

**마지막 업데이트**: 2026-01-18  
**대상 시험**: 정보보안기사 (Engineer Information Security)  
**주요 과목**: 데이터베이스 보안, Oracle 관리
