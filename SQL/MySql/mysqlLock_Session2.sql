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
  
  
  
  
  INSERT INTO `wms`.`product` (
  `GUID`, `StockID`, `BarCodeID`,
  `SkuID`, `ProductName`,`ProductStyle`, `Price`,
  `Status`,`Count`
)
VALUES
  ( UUID(),   1,1, 1,  'ddfarrrr', NULL, 3,   3,  3 );
  
  
  
  
  UPDATE wms.`product` SET productname='tran123' WHERE ID=7;
  
  
SELECT *  FROM wms.`product` WHERE ID=7;
  
  
  UPDATE  test.`t_product` SET product_name='product2';
  
 SELECT *  FROM  demo.`orderhead`;
 

SELECT  *  FROM test.`t_product`;
 
 INSERT INTO `test`.`t_product` ( `product_name`) VALUES( 'product_name');

 DELETE FROM  `test`.`t_product` WHERE id=5;
 
 UPDATE  test.`t_product` SET product_name='product_2ee' WHERE id=2;
  
  
  