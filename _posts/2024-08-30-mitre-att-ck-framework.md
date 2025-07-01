---
title: "Tìm hiểu về MITRE ATT&CK Framework"
date: 2024-08-30 19:25:48 +0700
categories: [Notes, Cybersecurity]
tags: [mitre att&ck, cybersecurity, blue team, red team]
pin: false
comments: false
published: true
---

## MITRE ATT&CK là gì?

**MITRE ATT&CK** (Adversarial Tactics, Techniques, and Common Knowledge) là một **framework mã nguồn mở** mô tả các tactics (chiến thuật), techniques (kỹ thuật) mà adversaries (đối thủ tấn công) sử dụng trong các giai đoạn tấn công mạng.

- Được phát triển bởi **MITRE Corporation** từ năm 2013.
- Là một cơ sở dữ liệu sống (living knowledge base) được update thường xuyên dựa trên **threat intelligence thực tế**.
- Mục tiêu chính: giúp các tổ chức hiểu rõ **hành vi tấn công** thay vì chỉ tập trung vào Indicators of Compromise (IoC) truyền thống.

## Cấu trúc của ATT&CK

Framework này chia làm 3 main matrices:

1. **Enterprise Matrix**: áp dụng cho hệ thống Windows, macOS, Linux, Cloud, SaaS.
2. **Mobile Matrix**: áp dụng cho iOS, Android.
3. **ICS Matrix**: áp dụng cho Industrial Control Systems.

### Mỗi Matrix bao gồm:

- **Tactics**: mục tiêu chiến thuật của attacker, ví dụ: Initial Access, Execution, Persistence.
- **Techniques**: cách cụ thể attacker thực hiện tactic đó. Ví dụ: Spearphishing Attachment (T1566.001).
- **Sub-techniques**: nhánh nhỏ hơn của technique chính.
- **Procedures**: mô tả cách cụ thể attacker (APT group) đã triển khai technique đó trong thực tế.

## Tactics (Chiến thuật) phổ biến

Dưới đây là một số tactics cơ bản trong Enterprise ATT&CK Matrix:

| Tactic | Mục tiêu |
|---|---|
| **Initial Access** | Thu thập quyền truy cập ban đầu vào hệ thống |
| **Execution** | Thực thi mã độc trên hệ thống |
| **Persistence** | Duy trì quyền truy cập sau reboot hoặc credential changes |
| **Privilege Escalation** | Nâng cấp đặc quyền |
| **Defense Evasion** | Tránh bị phát hiện bởi security controls |
| **Credential Access** | Thu thập thông tin đăng nhập |
| **Discovery** | Thu thập thông tin về hệ thống hoặc network |
| **Lateral Movement** | Di chuyển sang các hệ thống khác trong network |
| **Collection** | Thu thập dữ liệu mục tiêu |
| **Command and Control (C2)** | Giao tiếp với máy chủ attacker |
| **Exfiltration** | Đưa dữ liệu ra ngoài tổ chức |
| **Impact** | Phá hoại, mã hóa, hoặc gây ảnh hưởng đến hệ thống |

## ATT&CK giúp gì cho Blue Team?

- **Threat Detection**: Xây dựng detection rules dựa trên technique thay vì IoC.
- **Threat Hunting**: Thiết kế hunts dựa trên kỹ thuật tấn công thực tế.
- **Gap Analysis**: Đánh giá coverage của security controls với các tactics/techniques.
- **Purple Teaming**: Giao tiếp rõ ràng giữa Red Team và Blue Team khi mô phỏng tấn công.

## ATT&CK giúp gì cho Red Team?

- **Attack Simulation**: Lập kế hoạch và báo cáo dựa trên ATT&CK giúp chuẩn hóa và dễ hiểu.
- **TTP Emulation**: Mô phỏng tactics, techniques, procedures mà attacker thực tế sử dụng.

## Ví dụ thực tế

Giả sử bạn là Blue Team Analyst:

Phát hiện một suspicious PowerShell execution.

- Check ATT&CK Matrix: tactic **Execution**, technique **PowerShell (T1059.001)**.
- Tham khảo procedures: nhiều APT group (APT3, FIN6) dùng PowerShell cho fileless malware hoặc in-memory attacks.
- Phản hồi: viết detection rule dựa trên command line arguments hoặc parent-child process anomalies.

## Resources chính thức

- [MITRE ATT&CK Website](https://attack.mitre.org/)
- [ATT&CK Navigator](https://mitre-attack.github.io/attack-navigator/) – Visualization tool
- [ATT&CK GitHub](https://github.com/mitre/attack)

## Kết luận

MITRE ATT&CK không chỉ là một bảng tra cứu, mà là **kim chỉ nam** cho mọi hoạt động từ detection, threat hunting, cho đến red teaming. Nếu bạn là sinh viên, SOC Analyst, hoặc đang bước vào thế giới cybersecurity, việc thành thạo ATT&CK Framework sẽ giúp bạn:

- [x] Hiểu rõ hành vi attacker  
- [x] Giao tiếp chuyên nghiệp với team  
- [x] Nâng cao kỹ năng defensive và offensive

---

*“Know your enemy and know yourself and you can fight a hundred battles without disaster.”*  
— **Sun Tzu**

---
