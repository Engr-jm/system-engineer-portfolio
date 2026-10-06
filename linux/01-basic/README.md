# 01. Linux Basic

## 목표

Linux 서버의 기본적인 시스템 정보를 확인하고
서버의 기본 구조를 이해한다.

## 실습 환경

* OS: RHEL
* Shell: Bash

## 실습 내용

### 1. Hostname 확인

```bash
hostname
```

### 2. IP Address 확인

```bash
ip -br addr
```

### 3. Routing Table 확인

```bash
ip route
```

### 4. Disk 사용량 확인

```bash
df -h
```

### 5. Memory 확인

```bash
free -h
```

### 6. Failed Service 확인

```bash
systemctl --failed
```

## 결과

실습 후 실제 명령어 결과와 화면을 추가한다.

## 배운 내용

* Linux 서버의 hostname 확인 방법
* Network Interface와 IP 확인 방법
* Routing Table의 기본 구조
* Disk 사용량 확인 방법
* Memory 상태 확인 방법
* Failed Service 확인 방법
