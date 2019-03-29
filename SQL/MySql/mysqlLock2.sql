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
  
  
  
  
  UPDATE wms.`product` SET productname='tran12' WHERE ID=7;
  
SELECT *  FROM wms.`product` WHERE ID=7;
  
  
  
  
  
  