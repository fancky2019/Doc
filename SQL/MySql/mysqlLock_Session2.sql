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
 
 UPDATE  person SET name='product_2ee2' WHERE id=27;
 
 
   
   UPDATE  person SET name='product_2ee2' WHERE id=1;

	
   UPDATE  person SET name='product_2ee2' WHERE id=2;
	 
	 select * from   person WHERE id=2;
	 
   UPDATE  person SET name='product_2ee2' WHERE id=57;
 
 
    
   UPDATE  person SET name='product_22' WHERE age=23;

   UPDATE  person SET name='product_2ee2' WHERE age=27;
		
	UPDATE  person SET name='product_2ee2' WHERE age=29;
			 
	UPDATE  person SET name='product_2ee2' WHERE age=30;
	
			UPDATE  person SET name='product_2ee2' WHERE age=57;	 
			 select  *  from person WHERE age=57;	
START TRANSACTION ;
-- 		UPDATE  person SET name='product_2ee2' WHERE age=57;	
			 select  *  from person WHERE age=57;	
COMMIT ;


 START TRANSACTION ;
  
	 select * from   person WHERE id=2;
-- 	UPDATE  person SET name='product_2ee2' WHERE age=23;
-- SELECT SLEEP(10);
COMMIT ;
 
 INSERT INTO `demo`.`person` (`name`, `age`, `birthday`) VALUES ( 'fancky', 56, '2023-12-28 07:55:04');

 
 delete  from person where age =56;
 
 UPDATE  person set name='product_22' WHERE name='product_2ee';
 
 
 select  *  from person
ORDER BY age;
 
 	UPDATE  person SET name='product5' WHERE id=5;
 
  	UPDATE  person SET name='product5' WHERE id=3;
		
 select  *  from person WHERE id=5;
 
 
 -- 查看锁信息
 
select ENGINE_LOCK_ID,ENGINE_TRANSACTION_ID,LOCK_MODE,LOCK_TYPE,INDEX_NAME,OBJECT_SCHEMA,OBJECT_NAME,LOCK_DATA,LOCK_STATUS,THREAD_ID 
from performance_schema.data_locks;

select * from `performance_schema`.data_locks;
 
 select trx_id,trx_state,trx_started,trx_tables_locked,trx_rows_locked,trx_query from information_schema.innodb_trx;
  
  
  