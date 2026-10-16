# System Engineer Portfolio

## 프로젝트 소개

VMware Fusion 기반 Rocky Linux 서버를 직접 구축하고, Linux 시스템 운영 및 장애 대응 과정을 기록한 시스템 엔지니어 포트폴리오입니다.

Linux 서버 구축을 시작으로 네트워크, 사용자 및 권한 관리, 서비스 운영, 저장장치 관리, 보안 설정과 장애 분석을 실습하였습니다.

단순히 명령어를 실행하는 데 그치지 않고, **구성 목적 → 구축 과정 → 정상 동작 검증 → 문제 발생 및 해결 → 결과 기록** 순서로 실습을 문서화하였습니다.

향후 Shell Script 자동화, Docker, Kubernetes로 확장하여 Linux 기반 시스템 운영부터 컨테이너 환경까지 연결하는 것을 목표로 합니다.

---

## 1. 실습 환경

| 구분 | 환경 |
|---|---|
| Host OS | macOS (MacBook M1 Air) |
| Virtualization | VMware Fusion |
| Guest OS | Rocky Linux 10.2 (ARM64) |
| Hostname | server01.example.com |
| Network | VMware NAT |
| Server IP | 192.168.76.10/24 |
| Gateway | 192.168.76.2 |
| DNS | 192.168.76.2 |
| Remote Access | OpenSSH |
| Storage | LVM, XFS |
| Service Management | systemd |
| Firewall | firewalld |

### 실습 환경 구성

```text
MacBook M1 Air (macOS)
         |
    VMware Fusion
         |
      NAT Network
    192.168.76.0/24
         |
   Rocky Linux 10.2
   server01.example.com
   192.168.76.10
         |
   +-------------------+
   | SSH Remote Access |
   | NetworkManager    |
   | systemd           |
   | firewalld         |
   | LVM / XFS         |
   +-------------------+
```

---

## 2. 프로젝트 진행 현황

| 구분 | 진행 상태 |
|---|---|
| Linux 서버 구축 및 운영 | 완료 |
| Shell Script 자동화 | 완료 (01~04) |
| Docker 컨테이너 환경 | 진행 예정 |
| Kubernetes 운영 환경 | 진행 예정 |

현재 Linux 서버 구축 및 운영 실습 7개 영역의 문서 작성을 완료하였습니다.

---

## 3. Linux 서버 구축 및 운영

실제 Rocky Linux 서버에서 수행한 작업을 영역별로 구분하여 기록하였습니다.

각 문서에는 주요 명령어, 설정 과정, 실행 결과 및 검증 스크린샷을 포함하였습니다.

| 번호 | 실습 영역 | 주요 내용 | 실습 문서 |
|---|---|---|---|
| 01 | 기본 환경 구축 | Rocky Linux 설치, 호스트명 및 기본 환경 확인 | [01-basic](linux/01-basic/README.md) |
| 02 | 사용자 및 권한 관리 | 사용자·그룹 생성, SGID, 그룹 상속, 접근 권한 검증 | [02-users-permissions](linux/02-users-permissions/README.md) |
| 03 | 프로세스 및 서비스 | systemctl, 서비스 상태, 프로세스·포트 확인 | [03-process-service](linux/03-process-service/README.md) |
| 04 | 저장장치 관리 | PV·VG·LV 생성, XFS, LVM 확장, fstab | [04-storage](linux/04-storage/README.md) |
| 05 | 네트워크 구성 | VMware NAT, 고정 IP, 게이트웨이, DNS, SSH | [05-network](linux/05-network/README.md) |
| 06 | 보안 및 방화벽 | firewalld 포트 허용·제거, 영구 설정, 검증 | [06-security](linux/06-security/README.md) |
| 07 | 로그 및 장애 분석 | journalctl, 시스템 로그, 서비스 장애 재현 및 복구 | [07-logs-troubleshooting](linux/07-logs-troubleshooting/README.md) |

---

## 4. 주요 구축 및 검증 경험

### 4.1 네트워크 및 SSH 원격 접속

- VMware Fusion NAT 네트워크를 이용한 Linux 서버 환경 구성
- NetworkManager 연결 프로파일 백업
- 고정 IP `192.168.76.10/24` 설정
- 게이트웨이 및 DNS 설정 확인
- 외부 네트워크 통신과 도메인 이름 조회 검증
- macOS 터미널에서 SSH 원격 접속 검증

[상세 실습 기록](linux/05-network/README.md)

### 4.2 사용자 및 공유 디렉터리 권한 관리

- `linux01`, `linux02` 사용자 및 `devops` 그룹 구성
- `/project` 디렉터리 소유권 및 SGID 권한 설정
- 서로 다른 사용자가 생성한 파일의 그룹 상속 확인
- 파일 쓰기 권한 부족으로 발생한 접근 거부 확인
- 그룹 쓰기 권한 변경 후 정상적인 파일 수정 검증

[상세 실습 기록](linux/02-users-permissions/README.md)

### 4.3 LVM 저장장치 구성 및 확장

- VMware Fusion에 10GiB 가상 디스크 추가
- PV·VG·LV 생성 및 XFS 파일시스템 구성
- LV를 5GiB에서 8GiB, 이후 9GiB까지 확장
- LV와 파일시스템 크기가 불일치하는 상황 확인
- `xfs_growfs`를 이용한 파일시스템 확장
- 기존 테스트 파일 및 해시값을 이용한 데이터 유지 검증
- UUID 기반 `/etc/fstab` 마운트 설정 및 검증

[상세 실습 기록](linux/04-storage/README.md)

---

## 5. 장애 분석 및 문제 해결 경험

### 사례 1. 파일 접근 권한 거부

**문제 상황**

동일한 `devops` 그룹에 속한 사용자가 다른 사용자가 생성한 파일을 수정하지 못하는 현상이 발생하였습니다.

**원인 분석**

공유 디렉터리에 SGID가 적용되어 파일의 그룹은 정상적으로 상속되었으나, 파일 권한이 `640`으로 설정되어 그룹 쓰기 권한이 없었습니다.

**해결 방법**

`chmod 660`으로 그룹 쓰기 권한을 부여하고 다른 사용자 계정에서 파일 수정이 정상적으로 이루어지는지 확인하였습니다.

**학습 내용**

SGID에 의한 그룹 상속과 실제 파일 접근 권한은 별도로 관리해야 함을 확인하였습니다.

[문제 해결 기록](linux/02-users-permissions/README.md)

### 사례 2. LVM 확장 후 파일시스템 용량 불일치

**문제 상황**

논리 볼륨을 9GiB로 확장했지만 XFS 파일시스템의 용량은 8GiB로 표시되었습니다.

**원인 분석**

`lvextend`를 이용하여 논리 볼륨 크기만 확장하고 XFS 파일시스템 확장은 수행하지 않은 상태였습니다.

**해결 방법**

`xfs_growfs /mnt/data`를 실행하여 파일시스템을 확장하고, 용량 및 기존 파일 상태를 확인하였습니다.

**학습 내용**

LVM과 파일시스템은 서로 다른 계층으로 관리되며, 확장 후 각각의 상태를 검증해야 함을 확인하였습니다.

[문제 해결 기록](linux/04-storage/README.md)

### 사례 3. systemd 서비스 실행 실패 및 복구

**문제 상황**

장애 분석 연습을 위해 실습용 `portfolio-lab.service`에 존재하지 않는 실행 파일을 설정하여 의도적으로 서비스 시작 실패를 발생시켰습니다.

**원인 분석**

`systemctl status`와 `journalctl`에서 `203/EXEC` 오류 및 실행 파일을 찾지 못한다는 메시지를 확인하였습니다.

**해결 방법**

서비스 설정의 `ExecStart`를 정상적인 실행 파일로 변경하고 `systemctl daemon-reload` 및 서비스 시작 명령을 실행하였습니다.

이후 서비스 상태가 `active (running)`으로 변경된 것을 확인하였습니다.

**학습 내용**

서비스 장애 발생 시 상태와 로그를 우선 확인하고, 원인에 맞는 설정을 수정한 뒤 정상 복구 여부를 검증하는 절차를 학습하였습니다.

※ 해당 사례는 장애 대응 절차를 학습하기 위해 의도적으로 재현한 실습입니다.

[장애 재현 및 복구 기록](linux/07-logs-troubleshooting/README.md)

---

## 6. 향후 확장 계획

### Shell Script 자동화

- [x] CPU·메모리·디스크 사용률 점검 스크립트
- [x] 디스크 사용률 임계값 기반 WARNING 검증
- [x] journalctl 기반 시스템 오류 로그 검색
- [x] 오류 로그 개수 계산 및 상세 내용 출력
- [x] 로그 조회 실패 처리 및 예외 상황 검증
- [ ] cron 기반 정기 점검
- [ ] 점검 결과 로그 파일 자동 저장

**완료한 실습**

- [01. Linux 시스템 자원 점검 자동화](shell/01-system-monitor/README.md)
- [02. Linux 로그 분석 자동화](shell/02-log-analysis/README.md)
- [03. cron 기반 Linux 서버 정기 점검 자동화](shell/03-cron-monitor/README.md)
- [04. Linux 서버 백업 자동화 및 복구 검증](shell/04-backup-automation/README.md)

### Docker

- [ ] Docker 설치 및 컨테이너 실행
- [ ] Dockerfile을 이용한 이미지 빌드
- [ ] 컨테이너 볼륨 및 네트워크 구성
- [ ] Docker Compose 기반 다중 컨테이너 구성

### Kubernetes

- [ ] Kubernetes 실습 환경 구축
- [ ] Pod 및 Deployment 관리
- [ ] Service 및 Ingress를 통한 서비스 연결
- [ ] 장애 복구 및 스케일링 실습

Linux 운영 실습에서 구축한 환경과 학습 내용을 기반으로 단계적으로 확장할 계획입니다.

---

## 7. 실습 기록 기준

각 실습 문서는 다음 원칙에 따라 작성합니다.

1. 실습 목적 및 환경 정의
2. 실제 설정 과정과 실행 명령어 기록
3. 정상 동작 여부 검증
4. 문제 발생 시 원인과 해결 과정 기록
5. 실행 결과 스크린샷 첨부
6. 학습 내용 및 개선 사항 정리

---

## 8. 프로젝트 목표

Linux 시스템을 직접 구축하고 운영하면서 시스템 구성 요소와 명령어의 역할을 이해하는 것을 목표로 합니다.

장애가 발생했을 때 서비스 상태, 로그, 네트워크 및 권한 설정을 단계적으로 확인하여 문제 원인을 파악하는 역량을 기르고자 합니다.

향후 Shell Script, Docker, Kubernetes로 학습 범위를 확장하여 Linux 기반 시스템 운영 및 컨테이너 환경까지 다룰 수 있는 시스템 엔지니어로 성장하고자 합니다.
