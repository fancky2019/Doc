
SELECT CONVERT(datetime,[TimeStamp], 126) [TimeStamp]  from  product;

 select  CONVERT(datetime,[TimeStamp])[datetime],
	        CONVERT (bigint, [TimeStamp]) [bigint],
			 [TimeStamp],
	        CONVERT (bigint,CONVERT (timestamp, GETDATE())) t
	        from product;



