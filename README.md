# System Engineer Portfolio

## 프로젝트 소개

VMware Fusion 기반 Rocky Linux 서버 구축을 시작으로 Linux 시스템 운영, 네트워크 관리, Shell Script 자동화, Docker 및 Kubernetes 환경까지 단계적으로 구축하는 시스템 엔지니어 포트폴리오입니다.

단순히 명령어를 실행하는 것이 아니라 시스템 구성 목적, 구축 과정, 검증 결과, 장애 해결 과정을 기록하는 것을 목표로 합니다.

## 1. 실습 환경

| 구분 | 환경 |
|---|---|
| Host OS | macOS (MacBook M1 Air) |
| Virtualization | VMware Fusion |
| Guest OS | Rocky Linux 10.2 ARM64 |
| Hostname | server01.example.com |
| Network | VMware NAT |
| Server IP | 192.168.76.10/24 |
| Gateway | 192.168.76.2 |
| DNS | 192.168.76.2 |
| Remote Access | OpenSSH |

## 2. 프로젝트 진행 현황

### Linux 서버 구축

- [x] Rocky Linux 설치 및 초기 설정
- [x] root / admin 사용자 생성
- [x] 호스트명 설정
- [x] VMware NAT 네트워크 확인
- [x] NetworkManager 연결 프로파일 백업
- [x] 고정 IP 구성
- [x] 게이트웨이 및 외부 네트워크 통신 검증
- [x] DNS 이름 해석 확인
- [x] SSH 서비스 실행 확인
- [x] macOS에서 Linux 서버로 SSH 원격 접속
- [ ] 방화벽 설정 및 관리
- [ ] 사용자·그룹·파일 권한 관리
- [ ] 디스크 및 LVM 관리
- [ ] systemd 서비스 및 프로세스 관리

### Shell Script 자동화

- [ ] 시스템 자원 점검 스크립트
- [ ] 로그 분석 및 관리
- [ ] cron 기반 정기 점검

### Docker

- [ ] Docker 설치 및 컨테이너 관리
- [ ] Dockerfile 이미지 빌드
- [ ] 볼륨 및 컨테이너 네트워크
- [ ] Docker Compose 기반 서비스 구성

### Kubernetes

- [ ] Kubernetes 실습 환경 구성
- [ ] Pod 및 Deployment
- [ ] Service 및 Ingress
- [ ] 장애 복구 및 스케일링

## 3. 실습 기록 기준

각 실습은 다음 항목을 중심으로 작성합니다.

1. 실습 목적 및 환경
2. 구성 과정과 사용 명령어
3. 정상 작동 검증 결과
4. 발생한 문제와 해결 과정
5. 배운 점과 개선 사항

## 4. 장애 해결 기록

실습 중 발생한 문제를 단순히 해결하는 데 그치지 않고 원인, 점검 명령어, 해결 방법, 재발 방지 방안을 정리합니다.

## 5. 프로젝트 목표

Linux 서버 구축과 운영 역량을 바탕으로 자동화 및 컨테이너 운영 기술을 확장하고, 실제 수행한 작업을 재현 가능한 기술 문서로 정리하는 것을 목표로 합니다.
