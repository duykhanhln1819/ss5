-- 1. Thiết kế I/O (Dữ liệu đầu vào)

-- API nhận dữ liệu yêu cầu cập nhật / trừ điểm:

-- user_id (Long/UUID): Định danh người dùng
-- deduct_amount (Decimal/Double): Số điểm cần trừ (phải > 0)
-- transaction_type (String): Loại giao dịch (ví dụ: "PURCHASE", "REDEEM")
-- request_id (String - khuyên dùng): Mã giao dịch duy nhất từ client để chống gọi trùng (Idempotency)
-- 2. Luồng xử lý & Logic kiểm tra (Pre-SQL Validation)

-- Tại tầng Service (Backend), trước khi thực hiện câu lệnh
-- UPDATE ... SET points = points - ?, cần chặn bẫy điểm âm bằng logic sau:

-- Bắt đầu giao dịch (Transaction Begin)

-- Bước 1: Xác thực dữ liệu đầu vào

-- if (deduct_amount <= 0):
--     Trả về lỗi "Số điểm trừ không hợp lệ" (Bad Request)

-- Bước 2: Lấy số dư hiện tại (Lock dữ liệu)
-- Sử dụng câu lệnh có khóa hàng:

-- SELECT current_points 
-- FROM user_points 
-- WHERE user_id = ? 
-- FOR UPDATE;
-- if (user_not_found):
--     Trả về lỗi "Người dùng không tồn tại"

-- Bước 3: Kiểm tra logic âm điểm (Chặn bẫy)

-- if (current_points - deduct_amount < 0):
--     Ghi log cảnh báo (theo dõi gian lận)
--     ROLLBACK giao dịch
--     Trả về lỗi "Số dư không đủ" (Business Rule Exception)

-- Bước 4: Thực hiện trừ điểm

-- UPDATE user_points 
-- SET current_points = current_points - ? 
-- WHERE user_id = ?;

-- Bước 5: Commit giao dịch

-- Triển khai: Câu lệnh SQL hoàn chỉnh
-- Để thực hiện lọc và sắp xếp đa tầng (Multi-level sorting) theo đúng yêu cầu, 
-- chúng ta sử dụng mệnh đề ORDER BY với nhiều tham số:


-- Triển khai: Câu lệnh SQL hoàn chỉnh
SELECT 
    driver_id, 
    driver_name, 
    status, 
    trust_score, 
    distance_km
FROM Drivers
WHERE status = 'AVAILABLE'  
  AND trust_score >= 80   
ORDER BY 
    distance_km ASC, 
    trust_score DESC;