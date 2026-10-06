# Linux Server Administration

Linux 서버를 직접 구성하고 운영하면서
시스템 엔지니어에게 필요한 기본적인 서버 관리 능력을 실습합니다.

---

## 1. Objectives

* Linux 서버 기본 구성
* 사용자 및 그룹 관리
* 파일 및 디렉터리 권한 관리
* Process 및 Service 관리
* Storage 관리
* Network 설정
* SSH 원격 관리
* Firewall 구성
* SELinux 이해
* 로그 분석
* 장애 대응

---

## 2. Practice

### 01. Basic Linux

* Hostname
* IP Address
* Routing
* Package Management
* Date / Time
* System Information

`01-basic/`

### 02. Users & Permissions

* User
* Group
* chmod
* chown
* umask
* SGID
* Sticky Bit
* SUID

`02-users-permissions/`

### 03. Process & Service

* ps
* top
* systemctl
* systemd
* Service Start / Stop
* Service Enable
* Process 확인

`03-process-service/`

### 04. Storage

* Disk 확인
* Partition
* Filesystem
* Mount
* LVM
* Disk Usage

`04-storage/`

### 05. Network

* IP
* Subnet
* Route
* DNS
* SSH
* Port
* Firewall

`05-network/`

### 06. Security

* SELinux
* Firewall
* File Permission
* SSH Security

`06-security/`

### 07. Logs & Troubleshooting

* journalctl
* System Log
* Service Log
* Process 분석
* Network 분석
* 장애 대응

`07-logs-troubleshooting/`

---

## 3. Troubleshooting

각 실습에서는 정상적인 환경만 구축하지 않고
의도적으로 문제를 발생시켜 원인 분석과 복구까지 수행합니다.

Example:

```text
Problem
↓
Symptom
↓
Analysis
↓
Cause
↓
Action
↓
Verification
```

---

## 4. Result

Linux 서버를 직접 구성하고 관리하면서
시스템 엔지니어 업무에 필요한 기본적인 Linux 운영 능력을
실습하고 문서화합니다.
