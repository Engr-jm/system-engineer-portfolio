
# System Engineer Portfolio

Linux 기반 시스템 운영과 인프라 구축을 단계적으로 실습한 프로젝트입니다.

Linux 서버 구축을 시작으로 Network, Shell, Docker, Kubernetes까지 확장하며
서버 운영과 장애 대응 과정을 기록합니다.

---

## 1. Project Overview

### 목표

* Linux 서버 운영 능력 향상
* 네트워크 기반 서버 통신 이해
* Shell Script를 이용한 운영 자동화
* Docker 기반 서비스 운영
* Kubernetes 기반 컨테이너 서비스 배포
* 장애 상황 재현 및 원인 분석
* 문제 해결 과정 문서화

### Project Flow

Linux Server
→ Network
→ Shell
→ Docker
→ Kubernetes
→ Troubleshooting

---

## 2. Technology

| Category      | Technology                                  |
| ------------- | ------------------------------------------- |
| OS            | RHEL / Linux                                |
| Network       | TCP/IP, Subnet, Routing, DNS, SSH, Firewall |
| Shell         | Bash                                        |
| Container     | Docker                                      |
| Orchestration | Kubernetes                                  |
| Cloud         | AWS                                         |
| Documentation | GitHub / Markdown                           |

---

## 3. Infrastructure

프로젝트 전체 환경은 Linux 서버를 기반으로 구성하며,
Network와 서버 운영 환경 위에 Docker 및 Kubernetes 환경을 단계적으로 확장합니다.

### Server

| Server  | Role                   |
| ------- | ---------------------- |
| infra01 | Management / Shell     |
| infra02 | Application / Linux    |
| infra03 | Container / Kubernetes |

> 실제 서버 구성과 IP 정보는 `architecture/network-design.md`에서 관리합니다.

---

## 4. Architecture

전체 인프라 구성은 다음과 같은 단계로 확장합니다.

```text
Client
   │
   ▼
Network
   │
   ├── infra01
   │    └── Management / Shell
   │
   ├── infra02
   │    └── Linux / Application
   │
   └── infra03
        └── Docker / Kubernetes
```

구성도:

`architecture/topology.png`

상세 네트워크 구성:

`architecture/network-design.md`

---

# 5. Linux

Linux 서버를 직접 구성하고 운영하면서
시스템 엔지니어에게 필요한 기본적인 서버 관리 능력을 실습합니다.

### Linux Topics

* Linux 기본 환경 구성
* 사용자 / 그룹 관리
* 파일 및 디렉터리 권한
* Process 관리
* systemd 서비스 관리
* Storage / 파일시스템
* Network 설정
* SSH
* Firewall
* SELinux
* 로그 분석
* 장애 대응

상세 내용:

`linux/README.md`

---

# 6. Network

Linux 서버 간 통신을 구성하면서
IP, Subnet, Routing, DNS, SSH, Firewall의 관계를 실습합니다.

### Topics

* IP Address
* Subnet
* Routing
* DNS
* SSH
* Port
* Firewall
* Server-to-Server Communication

상세 내용:

`network/README.md`

---

# 7. Shell

Linux 운영 작업을 Bash Script로 자동화합니다.

### Topics

* Bash 기본 문법
* 변수
* 조건문
* 반복문
* 함수
* 명령어 결과 처리
* 서버 상태 점검
* 로그 관리
* 운영 자동화

상세 내용:

`shell/README.md`

---

# 8. Docker

Linux 서버 환경에서 Docker를 이용해 서비스를 컨테이너로 운영합니다.

### Topics

* Image
* Container
* Dockerfile
* Volume
* Network
* Port Mapping
* Docker Compose

상세 내용:

`docker/README.md`

---

# 9. Kubernetes

Docker 기반 컨테이너 환경을 Kubernetes로 확장합니다.

### Topics

* Pod
* Deployment
* Service
* ConfigMap
* Secret
* Volume
* Ingress
* Resource

상세 내용:

`kubernetes/README.md`

---

# 10. Troubleshooting

실제 운영 환경에서 발생할 수 있는 장애를 의도적으로 발생시키고
원인 분석 및 복구 과정을 문서화합니다.

### Linux

* SSH 접속 장애
* Service 장애
* 권한 오류
* Disk 부족
* Network 오류

### Docker

* Container 실행 실패
* Port Mapping 오류
* Volume 오류
* Network 오류

### Kubernetes

* Pod 실행 실패
* ImagePullBackOff
* Service 접속 실패
* Config 오류

장애 대응 문서:

`troubleshooting/`

---

# 11. Documentation Rule

각 실습은 다음 기준으로 기록합니다.

### 1. Problem

어떤 문제를 해결하려고 했는가?

### 2. Environment

어떤 서버와 환경에서 실습했는가?

### 3. Configuration

어떤 설정을 적용했는가?

### 4. Verification

어떻게 정상 작동하는지 확인했는가?

### 5. Troubleshooting

어떤 문제가 발생했고 어떻게 해결했는가?

### 6. Result

최종적으로 무엇을 확인했는가?

---

# 12. Project Roadmap

```text
[Phase 1]
Linux Server
    ↓
[Phase 2]
Network
    ↓
[Phase 3]
Shell Automation
    ↓
[Phase 4]
Docker
    ↓
[Phase 5]
Kubernetes
    ↓
[Phase 6]
Troubleshooting
```

현재 진행 단계:

**Phase 1 - Linux Server**

---

# 13. Key Learning

이 프로젝트를 통해 단순한 명령어 사용을 넘어

Linux Server
→ Network
→ Service
→ Container
→ Kubernetes

로 이어지는 시스템 운영 구조를 이해하는 것을 목표로 합니다.
