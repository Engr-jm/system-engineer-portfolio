# 05. Linux Network Configuration

## 1. 실습 목표

VMware Fusion 기반 Rocky Linux 서버의 네트워크 환경을 구성하고 NetworkManager를 이용해 DHCP에서 고정 IP로 변경한다.

네트워크 설정 전 기존 프로파일을 백업하고, IP 중복 여부를 확인한 후 변경 사항을 적용한다.

이후 게이트웨이, 외부 네트워크, DNS 연결을 검증하고 macOS에서 SSH 원격 접속을 수행한다.

## 2. 실습 환경

| 항목 | 구성 |
|---|---|
| Host | MacBook M1 Air |
| Hypervisor | VMware Fusion |
| OS | Rocky Linux 10.2 ARM64 |
| Hostname | server01.example.com |
| Network Mode | NAT (Share with my Mac) |
| Interface | enp2s0 |
| Static IP | 192.168.76.10/24 |
| Gateway | 192.168.76.2 |
| DNS | 192.168.76.2 |
| SSH User | admin |

## 3. 네트워크 구성

```text
MacBook M1 Air (macOS)
        |
        | VMware Fusion
        |
   NAT Network
   192.168.76.0/24
        |
        | Gateway: 192.168.76.2
        |
   Rocky Linux Server01
   enp2s0
   192.168.76.10/24
```

VMware Fusion의 NAT 네트워크를 사용하여 가상머신이 Mac의 네트워크를 공유하도록 구성하였다.

## 4. 구축 과정

### 4.1 기존 네트워크 설정 확인

```bash
nmcli device status
nmcli connection show
ip -br addr
ip route
```

초기 확인 결과:

- 연결 프로파일: enp2s0
- 기존 DHCP 주소: 192.168.76.128/24
- 기본 게이트웨이: 192.168.76.2
- DNS 서버: 192.168.76.2

### 4.2 DNS 및 NetworkManager 확인

```bash
cat /etc/resolv.conf
getent hosts google.com
systemctl is-active NetworkManager
```

검증 결과:

- DNS 서버: 192.168.76.2
- google.com 이름 해석 성공
- NetworkManager: active

### 4.3 네트워크 프로파일 백업

IP 변경 전에 기존 DHCP 연결 프로파일을 복제하였다.

```bash
sudo nmcli connection clone enp2s0 enp2s0-backup
nmcli connection show
```

백업 프로파일 `enp2s0-backup`이 생성된 것을 확인하였다.

### 4.4 DHCP 할당 범위 확인

macOS에서 VMware Fusion의 DHCP 설정 파일을 확인하였다.

```bash
sudo cat /Library/Preferences/VMware\ Fusion/vmnet8/dhcpd.conf
```

확인 결과:

```text
subnet 192.168.76.0 netmask 255.255.255.0 {
    range 192.168.76.128 192.168.76.254;
}
```

DHCP 할당 범위 밖에서 고정 IP 후보를 선정하였다.

### 4.5 IP 중복 검사

```bash
ping -c 3 192.168.76.10
sudo arping -D -I enp2s0 -c 3 192.168.76.10
```

검사 결과:

- Ping 응답 없음
- ARP 중복 검사 응답 0개
- 검사 당시 IP 중복 징후 없음

응답이 없다는 결과만으로 IP가 항상 사용 가능하다고 보장할 수는 없으므로 DHCP 범위와 함께 검토하였다.

### 4.6 고정 IP 설정

```bash
sudo nmcli connection modify enp2s0 \
ipv4.method manual \
ipv4.addresses 192.168.76.10/24 \
ipv4.gateway 192.168.76.2 \
ipv4.dns 192.168.76.2
```

설정값 확인:

```bash
nmcli -f ipv4.method,ipv4.addresses,ipv4.gateway,ipv4.dns connection show enp2s0
```

설정 적용:

```bash
sudo nmcli connection up enp2s0
```

고정 IP 설정 이후 네트워크 연결이 정상적으로 유지되는 것을 확인하였다.

### 4.7 네트워크 통신 검증

```bash
ip -br addr
ip route

ping -c 3 192.168.76.2
ping -c 3 8.8.8.8
getent hosts google.com
```

실제 검증 결과:

| 테스트 | 결과 |
|---|---|
| Gateway Ping | 3/3 성공 |
| External IP Ping | 3/3 성공 |
| DNS Lookup | 성공 |
| NetworkManager | active |

게이트웨이와 외부 IP 통신이 정상적으로 이루어졌으며 DNS 이름 해석도 성공하였다.

## 5. SSH 원격 접속

Rocky Linux에서 SSH 서비스를 확인하였다.

```bash
systemctl status sshd
```

확인 결과:

```text
Active: active (running)
```

macOS 터미널에서 다음 명령어로 접속하였다.

```bash
ssh admin@192.168.76.10
```

접속 후 서버 정보를 확인하였다.

```bash
whoami
hostname
```

결과:

```text
admin
server01.example.com
```

macOS에서 Rocky Linux 서버로 SSH 원격 접속에 성공하였다.

## 6. 문제 분석 및 해결

### 6.1 resolvectl 오류

DNS 정보를 확인하는 과정에서 다음 오류가 발생하였다.

```text
Failed to get global data: The name is not activatable
```

systemd-resolved에 접근할 수 없는 상태였으며, NetworkManager를 통한 DNS 기능은 정상적으로 동작하였다.

다음 명령어로 DNS 설정과 이름 해석을 별도로 검증하였다.

```bash
cat /etc/resolv.conf
getent hosts google.com
```

DNS 이름 해석이 정상적으로 동작함을 확인하였다.

### 6.2 IP 충돌 방지

DHCP 할당 범위에 포함된 기존 주소를 고정 IP로 사용하지 않고, DHCP 범위 밖의 주소를 선정하였다.

Ping 및 ARP 검사 후 고정 IP를 설정하여 주소 충돌 위험을 줄였다.

## 7. 구축 결과

- [x] VMware NAT 네트워크 확인
- [x] DHCP 및 네트워크 프로파일 분석
- [x] 연결 프로파일 백업
- [x] IP 중복 검사
- [x] 고정 IP 설정
- [x] 게이트웨이 통신 확인
- [x] 외부 네트워크 통신 확인
- [x] DNS 이름 해석 검증
- [x] SSH 원격 접속 성공
- [ ] 방화벽 규칙 관리 실습

## 8. 배운 내용

- NAT 방식의 가상 네트워크 구성 이해
- DHCP와 Static IP의 차이
- NetworkManager를 이용한 네트워크 관리
- 네트워크 변경 전 백업의 중요성
- Ping 및 ARP를 이용한 네트워크 점검
- DNS 문제와 네트워크 연결 문제의 구분
- SSH를 이용한 Linux 서버 원격 관리

## 9. 향후 개선 계획

- SSH 공개키 인증 구성
- firewalld를 이용한 접근 제어
- 네트워크 장애 상황 재현 및 복구
- 추가 가상머신을 이용한 서버 간 통신 검증
