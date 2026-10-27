# He thong giam sat tram cam bien SmartFarm

## Hướng dẫn chạy script

Tạo cây thư mục từ thư mục chứa dự án bằng một lệnh PowerShell:

```powershell
@('smartfarm-system','smartfarm-system\docs','smartfarm-system\scripts','smartfarm-system\data','smartfarm-system\backup') | ForEach-Object { New-Item -ItemType Directory -Path $_ -Force }
```

Chép `log-he-thong.log` vào `data/` và `auto_report.ps1` vào `scripts/`. Từ `scripts/`, chạy:

```powershell
.\auto_report.ps1
```

Nếu ExecutionPolicy chặn script:

```powershell
powershell -ExecutionPolicy Bypass -File .\auto_report.ps1
```

Để tạo `.env` bằng đường dẫn tương đối, đứng trong `data/` rồi chạy:

```powershell
Set-Content -Path ..\.env -Value 'DB_PASSWORD=demo_123456'
attrib +h ..\.env
```

Giá trị mật khẩu trên chỉ là dữ liệu giả định của bài tập.

## Checklist kiểm tra thiết bị

- [x] Kiểm tra kết nối gateway và đồng bộ dữ liệu
- [ ] Kiểm tra cảm biến có cảnh báo pin yếu
- [ ] Kiểm tra phiên bản firmware của các thiết bị
- [ ] Kiểm tra dung lượng lưu trữ máy chủ

## Bảng thông số phần cứng

| Tên thiết bị | Đơn giá (VND) | Loại storage |
|---|---:|---|
| Raspberry Pi 4 Model B | 1.450.000 | SSD |
| Intel NUC i3 | 6.200.000 | SSD |
| Orange Pi 5 | 2.300.000 | SSD |
| Dell Optiplex Micro | 5.400.000 | HDD |
| Mini PC Fanless N100 | 4.200.000 | SSD |
| Synology DS220j NAS | 3.900.000 | HDD |

## Phân tích hệ thống

### IPO cho chức năng lọc log

- **Input:** tệp `data/log-he-thong.log` chứa các dòng nhật ký có thời gian, mức độ, thiết bị và nội dung sự kiện.
- **Process:** PowerShell đọc log, lọc dòng có mức `ERROR` hoặc `CRITICAL`, ghi các dòng phù hợp vào báo cáo, đếm số dòng và thêm thời gian tạo báo cáo.
- **Output:** tệp `backup/bao-cao-su-co.txt` gồm tiêu đề, thời gian, danh sách sự cố và tổng số sự cố.

### Phân loại DIKW

| Tầng | Phát biểu | Lý do |
|---|---|---|
| Data | (b) `2026-10-12 08:15:01 [ERROR] sensor-03 Connection TIMEOUT after 30s` | Một bản ghi thô trong log. |
| Information | (c) “Hôm nay hệ thống ghi nhận 8 sự cố, trong đó 4 sự cố đến từ trạm sensor-03.” | Số liệu đã được tổng hợp từ các bản ghi. |
| Knowledge | (d) “Trạm sensor-03 hay mất kết nối vào buổi chiều do sóng yếu, nên cần lắp thêm anten.” | Diễn giải xu hướng và nguyên nhân để đưa ra hướng xử lý. |
| Wisdom | (a) “Quyết định thay modem trạm sensor-03 trước thứ Sáu.” | Quyết định hành động có thời hạn dựa trên hiểu biết. |

**Đối chiếu dữ liệu mẫu:** log đính kèm có 6 dòng `ERROR` và 2 dòng `CRITICAL`, tổng cộng 8 sự cố; sensor-03 xuất hiện 4 lần trong các dòng này. Phát biểu (c) khớp với dữ liệu nguồn, và script sẽ báo tổng 8 sự cố.

## Cấu trúc dự án

```text
smartfarm-system/
├── .env
├── backup/
│   └── bao-cao-su-co.txt (được tạo khi chạy script)
├── data/
│   ├── log-he-thong.log
│   └── quan-ly-thiet-bi.xlsx
├── docs/
│   └── README.md
└── scripts/
    └── auto_report.ps1
```

Đặt tên repository theo mẫu `[Tên Lớp]_[Môn Học]_KiemTraDauGio_SmartFarm` trước khi nộp lên GitHub.
