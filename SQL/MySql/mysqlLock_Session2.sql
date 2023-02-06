TRUNCATE TABLE wms.`product`
INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `CreateTime`,`Status`,`Count`, `ModifyTime`
)
VALUES
  (
    
   UUID(),   1,1, 1,  'ProductName1', 'ProductStyle1',
    3, NOW(3),  3,  3,  NOW(3)
  );
  
  
  
  SHOW VARIABLES LIKE 'autocommit';
  
  INSERT INTO `demo`.`demo_product` ( `guid`, `product_name`, `product_style`, `image_path`, `create_time`, `modify_time`, `status`, `description`, `timestamp`) VALUES ( 'd006c24a-0a9c-436b-8bdb-9e5835e351db', 'product_name7', 'productStyle6', 'D:\\fancky\\git\\Doc', '2022-12-17 05:22:14.603', '2022-12-17 05:22:14.603', 1, 'setDescription_sdsdddddddddddddddd', '2022-12-17 05:22:15');

  
  select  max(id) from  `demo`.`demo_product`;

  
	select  *  from  person;
  
	INSERT INTO `demo`.`person` (`name`, `age`, `birthday`) VALUES ('fancky', 21, '2022-08-24 05:39:52');


   SELECT *  FROM  demo.demo_product 
	 WHERE ID=7;
 
 SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;
START TRANSACTION ;
  UPDATE  demo.demo_product SET product_name='product_23337' WHERE ID=7;
SELECT SLEEP(10);
ROLLBACK;
 
-- COMMIT ;



  
  UPDATE  demo.demo_product SET product_name='product_na7' WHERE ID=7;
  
  
SELECT *  FROM  demo.demo_product WHERE ID=7;
  
  
  UPDATE  test.`t_product` SET product_name='product2';
  
 SELECT *  FROM  demo.`orderhead`;
 

SELECT  *  FROM test.`t_product`;
 
 INSERT INTO `test`.`t_product` ( `product_name`) VALUES( 'product_name');

 DELETE FROM  `test`.`t_product` WHERE id=5;
 
 UPDATE  test.`t_product` SET product_name='product_2ee' WHERE id=2;
  
  
  