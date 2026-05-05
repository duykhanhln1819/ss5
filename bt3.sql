-- Dữ liệu đầu vào (Input):

-- min_trust_score: Điểm tín nhiệm tối thiểu (nhận từ cấu hình Admin).

-- current_restaurant_id: ID của quán ăn (để xác định khoảng cách).

-- Logic kiểm tra và chặn bẫy dữ liệu:

-- Nhận giá trị min_trust_score từ yêu cầu của Admin.

-- Sử dụng câu điều kiện if (min_trust_score < 0) để kiểm tra.

-- Nếu điều kiện đúng (điểm âm), thực hiện gán lại giá trị min_trust_score = 0 (hoặc trả về thông báo lỗi tùy theo quy định của hệ thống).

-- Đảm bảo giá trị truyền vào tham số SQL luôn là số nguyên không âm trước khi thực thi truy vấn.

SELECT driver_id, driver_name, status, trust_score, distance_km
FROM Drivers
WHERE status = 'AVAILABLE' 
AND trust_score >= 80
ORDER BY distance_km ASC, trust_score DESC;