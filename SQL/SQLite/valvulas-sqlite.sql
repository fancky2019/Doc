
CREATE TABLE product (
    ID           INTEGER       PRIMARY KEY AUTOINCREMENT
                               NOT NULL,
    GUID         VARCHAR (36)  NOT NULL,
    ProductName  VARCHAR (50),
    ProductStyle VARCHAR (20),
    ImagePath    VARCHAR (200),
    CreadteTime  DATETIME,
    ModifyTime   DATETIME,
    Status       INT,
    Description  VARCHAR (500),
    TimeStamp    DATETIME
);


select * from product;

-- SQLite 没有truncate  用Delete
DELETE FROM 'product';
SELECT * FROM sqlite_sequence; 
-- 删除递增
DELETE FROM sqlite_sequence WHERE NAME = 'product';
-- mybatis执行报错
 SELECT DISTINCT ProductName FROM `valvulas`.`product`;
 -- 改成下面语句
 SELECT DISTINCT ProductName FROM product;
--  68cfd436-8cc0-11e9-8f69-00163e320c36  Balance Valve          balance         /img/balance/1.png         2019-06-12 11:16:03.156  2019-06-12 11:16:03.156       1  Balance Valve1             2019-06-12 11:16:03.156

INSERT INTO product (
                        GUID,
                        ProductName,
                        ProductStyle,
                        ImagePath,
                        CreadteTime,
                        ModifyTime,
                        Status,
                        Description,
                        TimeStamp
                    )
                    VALUES (
                        '68cfd436-8cc0-11e9-8f69-00163e320c36',
                        'Balance Valve',
                        'balance',
                        '/img/balance/1.png',
                        '2019-06-12 11:16:03.156',
                        '2019-06-12 11:16:03.156',
                         1,
                        'Balance Valve1',
                        '2019-06-12 11:16:03.156'
                    );
