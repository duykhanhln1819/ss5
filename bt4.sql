-- 1. Đề xuất đa giải pháp
-- Giải pháp 1: Sử dụng liên tiếp toán tử = và OR

-- SQL
SELECT * FROM Orders 
WHERE status = 'KHACH_HUY' 
   OR status = 'QUAN_DONG_CUA' 
   OR status = 'KHONG_CO_TAI_XE' 
   OR status = 'BOM_HANG';
-- Giải pháp 2: Sử dụng toán tử tập hợp IN

-- SQL
    SELECT * FROM Orders 
    WHERE status IN ('KHACH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG');

---

### 2. Bảng so sánh Ưu điểm & Nhược điểm

-- | Tiêu chí | Giải pháp 1 (OR) | Giải pháp 2 (IN) |
-- | :--- | :--- | :--- |
-- | **Mức độ code sạch** | Thấp. Code bị dài dòng, lặp lại tên cột nhiều lần gây rối mắt. | Cao. Ngắn gọn, súc tích, dễ đọc và dễ hiểu mục đích lọc theo tập hợp. |
-- | **Khả năng mở rộng** | Rất kém. Nếu lọc 20 nguyên nhân, câu lệnh sẽ cực kỳ dài và khó quản lý. | Rất tốt. Chỉ cần thêm các giá trị vào trong ngoặc, cấu trúc câu lệnh không đổi. |
-- | **Hiệu năng biên dịch** | Chậm hơn. SQL Engine phải phân tích từng biểu thức logic riêng lẻ. | Tốt hơn. SQL Engine tối ưu hóa `IN` bằng cách chuyển đổi thành danh sách sắp xếp hoặc bảng băm để tìm kiếm nhanh. |

-- ---

-- ### 3. Xử lý bẫy & Chốt code

-- **Xử lý lỗi mạng (Mảng rỗng) tại tầng Backend:**
-- Nếu mảng nguyên nhân gửi xuống bị rỗng, câu lệnh SQL dạng `IN ()` sẽ gây lỗi Syntax ngay lập tức. Bạn cần xử lý tại Backend như sau:
-- *   **Kiểm tra độ dài mảng:** Trước khi gọi CSDL, dùng lệnh `if (reasons.length == 0)`.
-- *   **Hành động:** 
--     *   **Phương án 1:** Không gọi SQL và trả về ngay một mảng rỗng cho phía Client (vì không có tiêu chí lọc thì không có kết quả). Đây là cách tối ưu nhất.
--     *   **Phương án 2:** Nếu vẫn phải gọi SQL, hãy thêm một điều kiện mặc định không bao giờ đúng (ví dụ: `WHERE 1=0`) để tránh lỗi Syntax và đảm bảo không trả về dữ liệu sai.

-- **Câu truy vấn SQL tốt nhất (Sử dụng giải pháp 2):**

-- ```sql
SELECT order_id, customer_name, status, created_at
FROM Orders
WHERE status IN ('KHACH_HUY', 'QUAN_DONG_CUA', 'KHONG_CO_TAI_XE', 'BOM_HANG');