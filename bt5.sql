-- Giải pháp
-- Dùng CASE WHEN để rẽ nhánh và tạo cột ảo Xep_Hang ngay trong SELECT.
--  Xử lý NULL
-- NULL không so sánh được → phải bắt riêng bằng:
-- WHEN total_orders IS NULL
-- Đặt lên đầu để tránh xếp sai.
SELECT 
    customer_name AS Ten_Khach_Hang,
    CASE 
        WHEN total_orders IS NULL THEN 'Khách mới'
        WHEN total_orders > 500 THEN 'Kim Cương'
        WHEN total_orders BETWEEN 100 AND 500 THEN 'Vàng'
        ELSE 'Bạc'
    END AS Xep_Hang
FROM Users;