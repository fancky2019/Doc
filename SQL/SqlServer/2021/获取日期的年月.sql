select year(getdate()),month(getdate()),day(getdate())
--提取年：select datepart(yy,getdate()) as year

--提取月：select datepart(mm,getdate()) as month

--提取日：select datepart(dd,getdate()) as day

--提取季度：select datepart(quarter,getdate())