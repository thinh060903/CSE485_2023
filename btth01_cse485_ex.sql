-- a
SELECT ten_bhat 
from theloai inner join baiviet on theloai.ma_tloai = baiviet.ma_tloai
WHERE ten_tloai = "Nhạc trữ tình"

-- cau b
 SELECT ten_bhat FROM baiviet, tacgia WHERE baiviet.ma_tgia = tacgia.ma_tgia AND ten_tgia = 'Nhacvietplus';
 
-- cau d
SELECT ma_bviet, ten_bhat, ten_tgia, ten_tloai, ngayviet
FROM theloai INNER JOIN baiviet on  theloai.ma_tloai = baiviet.ma_tloai
INNER JOIN tacgia on baiviet.ma_tgia = tacgia.ma_tgia


-- cau e
SELECT
  ten_tloai,
  COUNT(*) AS so_bai_viet
FROM
  baiviet, theloai
WHERE
  baiviet.ma_tloai = theloai.ma_tloai
GROUP BY
  ten_tloai
ORDER BY
  so_bai_viet DESC
LIMIT
  1;


-- cau f

SELECT tacgia.ten_tgia, COUNT(baiviet.ma_bviet) AS SoBaiViet FROM tacgia
JOIN baiviet ON tacgia.ma_tgia =  baiviet.ma_tgia 
GROUP BY tacgia.ma_tgia
ORDER BY SoBaiViet DESC
LIMIT 2;

-- câu g.	Liệt kê các bài viết về các bài hát có tựa bài hát chứa 1 trong các từ “yêu”, “thương”, “anh”, “em” 

SELECT * FROM baiviet
WHERE tieude LIKE '%yêu%' OR tieude LIKE '%thương%' OR tieude LIKE '%anh%' OR tieude LIKE '%em%';

-- câu h.	Liệt kê các bài viết về các bài hát có tiêu đề bài viết hoặc tựa bài hát chứa 1 trong các từ “yêu”, “thương”, “anh”, “em” 
SELECT * FROM baiviet 
WHERE tieude LIKE '%yêu%' OR tieude LIKE '%thương%' OR tieude LIKE '%anh%' OR tieude LIKE '%em%' 
OR  ten_bhat LIKE '%yêu%' OR ten_bhat LIKE '%thương%' OR ten_bhat LIKE '%anh%' OR ten_bhat LIKE '%em%'


--Câu i
CREATE VIEW vw_Music AS
SELECT baiviet.ma_bviet, baiviet.tieude, baiviet.ten_bhat, theloai.ten_tloai, tacgia.ten_tgia
FROM baiviet
INNER JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai
INNER JOIN tacgia ON baiviet.ma_tgia = tacgia.ma_tgia;
----------------------------
SELECT * FROM vw_Music;

--Câu J
DELIMITER //
CREATE PROCEDURE sp_DSBaiViet (IN tenTheLoai VARCHAR(50))
BEGIN
    DECLARE maTheLoai INT;
    
    SELECT ma_tloai INTO maTheLoai FROM theloai WHERE ten_tloai = tenTheLoai;
    
    IF maTheLoai IS NULL THEN
        SELECT 'Thể loại không tồn tại' AS Loi;
    ELSE
        SELECT baiviet.ma_bviet, baiviet.tieude, baiviet.ten_bhat, baiviet.ten_bhat, baiviet.ngayviet
        FROM baiviet
        INNER JOIN theloai ON baiviet.ma_tloai = theloai.ma_tloai
        WHERE theloai.ten_tloai = tenTheLoai;
    END IF;
END //
DELIMITER ;
----------------------------------------------------------------------------------------------
CALL sp_DSBaiViet('Nhạc trẻ ');


-- cau k

ALTER TABLE theloai ADD SLBaiViet INT;

CREATE TRIGGER tg_CapNhatTheLoai
ON baiviet
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

-- Thêm bài viết
IF (INSERTED.[ma_tloai] IS NOT NULL)
BEGIN

UPDATE theloai
SET SLBaiViet = SLBaiViet + 1
WHERE ma_tloai = INSERTED.[ma_tloai];

END;

-- Xóa bài viết
IF (DELETED.[ma_tloai] IS NOT NULL)
BEGIN

UPDATE theloai
SET SLBaiViet = SLBaiViet - 1
WHERE ma_tloai = DELETED.[ma_tloai];

END;

END;

-- cau l

CREATE TABLE Users (
ma_user INT UNSIGNED PRIMARY KEY,
		ten_user VARCHAR(200) NOT NULL,
		ten_dnhap CHAR(20) NOT NULL,
		mkhau INT NOT NULL
);


INSERT INTO Users (ma_user, ten_user, ten_dnhap, mkhau) VALUES (1,"admin ne", "admin",1);