# 01. Linux Basic - 서버 기본 환경 점검

## 1. 실습 목표

VMware Fusion 기반 Rocky Linux 서버의 기본 시스템 정보를 확인하고, 서버 운영에 필요한 점검 명령어를 학습한다.

운영체제, 호스트명, 네트워크, 디스크, 메모리 상태를 확인하고 정상적인 서버 운영 환경인지 검증한다.

## 2. 실습 환경

| 항목 | 내용 |
|---|---|
| Virtualization | VMware Fusion |
| OS | Rocky Linux 10.2 ARM64 |
| Shell | Bash |
| Hostname | server01.example.com |
| CPU | 2 vCPU |
| Memory | 4GB 할당 |
| Disk | 20GB |
| Network | VMware NAT |

## 3. 실습 내용

### 3.1 운영체제 정보 확인

```bash
cat /etc/os-release
hostnamectl
```

확인 결과:
- Rocky Linux 10.2
- ARM64 아키텍처
- VMware 가상화 환경

### 3.2 Hostname 설정 및 확인

```bash
sudo hostnamectl set-hostname server01.example.com
hostname
hostnamectl
```

확인 결과:

```text
server01.example.com
```

### 3.3 네트워크 인터페이스 확인

```bash
ip -br addr
```

네트워크 인터페이스 `enp2s0`가 UP 상태이며 IPv4 주소가 할당된 것을 확인하였다.

### 3.4 라우팅 테이블 확인

```bash
ip route
```

기본 게이트웨이 `192.168.76.2`를 확인하였다.

### 3.5 디스크 및 파일시스템 확인

```bash
lsblk
df -h
```

확인한 디스크 구성:

| 장치 | 용량 | 용도 |
|---|---|---|
| nvme0n1 | 20GB | 가상 디스크 |
| nvme0n1p1 | 600MB | /boot/efi |
| nvme0n1p2 | 2GB | /boot |
| rl-root | 15.4GB | 루트 파일시스템 |
| rl-swap | 2GB | Swap |

루트 및 스왑 영역이 LVM 논리 볼륨으로 구성된 것을 확인하였다.

### 3.6 메모리 확인

```bash
free -h
```

확인 결과:

- 전체 사용 가능 메모리: 3.5GiB
- Swap: 2GiB

### 3.7 실패한 서비스 확인

```bash
systemctl --failed
```

이 명령어를 통해 실패 상태인 systemd 서비스를 확인한다.

※ 실제 실행 결과는 추후 추가 예정이다.

## 4. 실습 결과

- [x] 운영체제 및 아키텍처 확인
- [x] 호스트명 설정 및 검증
- [x] 네트워크 인터페이스 확인
- [x] 기본 라우팅 정보 확인
- [x] 디스크 및 LVM 구성 확인
- [x] 메모리 상태 확인
- [ ] 실패한 서비스 점검

## 5. 배운 내용

- `hostnamectl`을 이용한 서버 호스트명 설정
- `ip` 명령어를 이용한 네트워크 및 라우팅 정보 확인
- `lsblk`를 이용한 디스크와 파티션 구조 확인
- `free`를 이용한 메모리 및 Swap 사용량 확인
- Linux 시스템 점검 시 기본적으로 확인해야 할 항목 이해

## 6. 향후 계획

- 서버 상태 점검 자동화
- 사용자 및 그룹 관리
- 서비스 및 프로세스 관리
- 디스크 및 LVM 실습
- 네트워크 및 SSH 운영
