SET @row=0;
SELECT @row:=@row+1 FROM demo.`userinfo`;

SELECT ROW_NUMBER() OVER(ORDER BY (SELECT 1)) AS rownum,id FROM demo.`userinfo`;

SELECT ROW_NUMBER() OVER(ORDER BY id) AS rownum,id FROM demo.`userinfo`;

