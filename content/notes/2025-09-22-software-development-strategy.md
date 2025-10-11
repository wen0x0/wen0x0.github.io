+++
title = "Khám phá các mô hình làm việc phổ biến trong phát triển phần mềm"  
description = "Agile, Scrum, Waterfall và các mô hình làm việc khác đã định hình cách con người xây dựng phần mềm. Cùng tìm hiểu chi tiết đặc điểm, quy trình và ưu nhược điểm của từng mô hình."  
date = 2025-09-22
draft = false  
[taxonomies]  
categories = ["Notes"]  
tags = ["agile", "scrum", "waterfall", "project management", "software development"]  
[extra]  
lang = "vi"  
toc = true  
comment = false  
copy = true  
outdate_alert = false  
outdate_alert_days = 120  
math = false  
mermaid = false  
featured = false  
reaction = false  
+++  

Trong ngành phát triển phần mềm, cách chúng ta **tổ chức công việc và quản lý dự án** ảnh hưởng trực tiếp đến **chất lượng sản phẩm, tiến độ và sự hài lòng của khách hàng**.  
Trải qua nhiều năm, các mô hình làm việc như **Waterfall**, **Agile**, **Scrum**, hay **Kanban** đã ra đời, mỗi mô hình mang một triết lý và cách tiếp cận khác nhau.

Bài viết này giúp bạn hiểu rõ hơn từng mô hình — từ quy trình, đặc điểm cho đến ưu và nhược điểm — để chọn ra phương pháp phù hợp nhất với dự án của mình.

---

## 1. Mô hình Waterfall – Quy trình thác nước truyền thống

### Khái niệm
Waterfall (thác nước) là **mô hình phát triển phần mềm tuyến tính**, trong đó công việc diễn ra theo từng giai đoạn cụ thể và **giai đoạn sau chỉ bắt đầu khi giai đoạn trước hoàn tất**.

### Các giai đoạn chính
1. **Phân tích yêu cầu (Requirement Analysis)** – Thu thập và ghi chép yêu cầu từ khách hàng.  
2. **Thiết kế hệ thống (System Design)** – Lên kiến trúc phần mềm, cơ sở dữ liệu và giao diện.  
3. **Triển khai (Implementation)** – Lập trình theo thiết kế.  
4. **Kiểm thử (Testing)** – Kiểm tra toàn bộ hệ thống, phát hiện lỗi.  
5. **Triển khai & Bảo trì (Deployment & Maintenance)** – Cài đặt phần mềm và hỗ trợ sau triển khai.

### Ưu điểm
- Dễ quản lý, đặc biệt với dự án có yêu cầu rõ ràng, ít thay đổi.  
- Có tài liệu chi tiết cho từng bước, dễ đào tạo nhân viên mới.  
- Tiến độ và chi phí được xác định sớm.

### Hạn chế
- Không linh hoạt — nếu có thay đổi, phải quay lại từ đầu.  
- Phản hồi của khách hàng chỉ có sau khi hoàn thành sản phẩm.  
- Khó phát hiện sớm các vấn đề trong quá trình phát triển.

---

## 2. Mô hình Agile – Linh hoạt và thích ứng với thay đổi

### Khái niệm
Agile là **triết lý làm việc linh hoạt** giúp nhóm phát triển **thích ứng nhanh với thay đổi** và **liên tục cải tiến** sản phẩm.  
Agile ra đời để khắc phục nhược điểm của Waterfall, nơi mọi thứ quá cứng nhắc.

### Tư tưởng cốt lõi (Agile Manifesto)
Agile nhấn mạnh 4 giá trị chính:
- Con người và sự tương tác **quan trọng hơn** quy trình và công cụ.  
- Phần mềm hoạt động được **quan trọng hơn** tài liệu chi tiết.  
- Hợp tác với khách hàng **quan trọng hơn** đàm phán hợp đồng.  
- Phản hồi với thay đổi **quan trọng hơn** việc bám sát kế hoạch.

### Cách làm việc
- Dự án được chia thành **các vòng lặp ngắn (iteration)**, thường kéo dài 1–4 tuần.  
- Sau mỗi vòng, nhóm đánh giá kết quả, nhận phản hồi và điều chỉnh kế hoạch.  
- Các thành viên trong nhóm **tự tổ chức và chịu trách nhiệm lẫn nhau**.

### Ưu điểm
- Linh hoạt, dễ thích ứng với thay đổi.  
- Sản phẩm được cải thiện liên tục.  
- Giao tiếp nhóm và sự minh bạch cao.  

### Nhược điểm
- Cần đội ngũ có kỷ luật và khả năng tự quản.  
- Khó ước lượng thời gian và chi phí tổng thể.  
- Không phù hợp với khách hàng yêu cầu kế hoạch cố định.

---

## 3. Mô hình Scrum – Cụ thể hóa Agile

### Khái niệm
Scrum là **một framework cụ thể trong Agile**, giúp quản lý và chia nhỏ công việc trong các vòng lặp ngắn gọi là **Sprint** (thường 2–4 tuần).

### Các vai trò trong Scrum
- **Product Owner** – đại diện khách hàng, ưu tiên các tính năng trong **Product Backlog**.  
- **Scrum Master** – hướng dẫn nhóm tuân thủ quy tắc Scrum, gỡ bỏ trở ngại.  
- **Development Team** – nhóm kỹ sư, kiểm thử viên, thiết kế, phát triển sản phẩm.

### Quy trình Scrum
1. **Sprint Planning** – lập kế hoạch cho Sprint.  
2. **Daily Scrum** – họp nhanh 15 phút mỗi ngày để cập nhật tiến độ.  
3. **Sprint Review** – trình bày kết quả cho khách hàng hoặc stakeholder.  
4. **Sprint Retrospective** – cùng nhìn lại và cải thiện quy trình.

### Ưu điểm
- Cải thiện khả năng phản hồi nhanh với thay đổi.  
- Tăng tính chủ động, tinh thần nhóm.  
- Giúp khách hàng thấy sản phẩm dần hoàn thiện qua từng Sprint.

### Nhược điểm
- Dễ thất bại nếu không hiểu rõ nguyên tắc Scrum.  
- Không phù hợp nếu nhóm thiếu sự cam kết hoặc ổn định.  
- Cần thời gian làm quen ban đầu.

---

## 4. Mô hình Kanban – Quản lý công việc trực quan

### Khái niệm
Kanban là **phương pháp quản lý dòng công việc (workflow)** dựa trên trực quan hóa tiến độ.  
Các công việc được thể hiện trên **bảng Kanban**, thường chia thành các cột:  
**“Việc cần làm (To Do)” – “Đang làm (In Progress)” – “Hoàn thành (Done)”**.

### Cách hoạt động
- Khi bắt đầu công việc, thẻ được di chuyển từ “To Do” sang “In Progress”.  
- Khi hoàn thành, thẻ chuyển sang “Done”.  
- Giới hạn số lượng công việc đang làm (**WIP limit**) để tránh quá tải.

### Ưu điểm
- Dễ triển khai, trực quan, ai cũng hiểu được.  
- Linh hoạt, không ràng buộc thời gian như Scrum.  
- Giúp phát hiện tắc nghẽn trong quy trình sớm.

### Nhược điểm
- Không có cấu trúc cố định, dễ rối nếu thiếu kỷ luật.  
- Khó theo dõi tiến độ dài hạn.

---

## 5. Một số mô hình khác

### V-Model (Verification & Validation)
Là phiên bản mở rộng của Waterfall, chú trọng song song giữa phát triển và kiểm thử.  
Ví dụ: mỗi giai đoạn phát triển đều có giai đoạn kiểm thử tương ứng.

### Spiral Model
Kết hợp giữa Waterfall và phát triển lặp, nhấn mạnh vào **quản lý rủi ro**.  
Phù hợp với dự án lớn, có nhiều yếu tố chưa chắc chắn.

### Hybrid Model (Agile + Waterfall)
Là mô hình lai, thường được dùng trong doanh nghiệp lớn:  
- Phần lập kế hoạch theo Waterfall.  
- Phần phát triển chia nhỏ theo Agile hoặc Scrum.

---

## 6. Bảng so sánh tổng quan

| Tiêu chí | Waterfall | Agile | Scrum | Kanban |
|-----------|------------|--------|--------|---------|
| **Cách làm việc** | Tuyến tính, theo giai đoạn | Linh hoạt, lặp lại | Lặp lại theo Sprint | Liên tục, trực quan |
| **Phản hồi khách hàng** | Sau khi hoàn thành | Liên tục | Sau mỗi Sprint | Liên tục |
| **Phù hợp với** | Dự án cố định, ít thay đổi | Dự án cần linh hoạt | Nhóm phát triển sản phẩm | Quy trình cải tiến liên tục |
| **Ưu điểm nổi bật** | Dễ quản lý | Linh hoạt | Minh bạch, tự quản | Đơn giản, trực quan |
| **Nhược điểm chính** | Thiếu linh hoạt | Khó đoán thời gian | Dễ hiểu sai quy trình | Dễ rối nếu không kiểm soát |

---

## 7. Kết luận

Không có mô hình nào hoàn hảo cho mọi dự án.  
Việc lựa chọn mô hình phụ thuộc vào:
- Quy mô nhóm và kinh nghiệm.  
- Mức độ thay đổi yêu cầu.  
- Văn hóa doanh nghiệp và khách hàng.

**Waterfall** phù hợp với môi trường ổn định.  
**Agile/Scrum** giúp nhóm thích ứng nhanh, tạo giá trị sớm.  
**Kanban** lại lý tưởng cho quy trình cải tiến liên tục.

Hiểu rõ từng mô hình sẽ giúp bạn chọn được **cách làm việc phù hợp nhất** để đạt hiệu quả tối đa trong phát triển phần mềm.
