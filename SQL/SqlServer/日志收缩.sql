USE [master]
GO
ALTER DATABASE NewClassesAdmin SET RECOVERY SIMPLE WITH NO_WAIT
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY SIMPLE --简单模式
GO

USE [NewClassesAdmin]
GO

DBCC SHRINKFILE (N'NewClassesAdmin_log',1024, TRUNCATEONLY) --收缩后1024M
GO

USE [master]
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY FULL WITH NO_WAIT
GO

ALTER DATABASE NewClassesAdmin SET RECOVERY FULL --还原为完全模式
GO

--不知道日志名字，查询方法：
USE  [NewClassesAdmin]
GO
SELECT file_id, name FROM sys.database_files;
GO


--自动收缩
EXEC sp_dboption 'NewClassesAdmin', 'autoshrink', 'false'


--最好备份日志，以后可通过日志恢复数据。。。
以下为日志处理方法
一般不建议做第4,6两步
第4步不安全,有可能损坏数据库或丢失数据
第6步如果日志达到上限,则以后的数据库处理会失败,在清理日志后才能恢复.
--*/

--下面的所有库名都指你要处理的数据库的库名

1.清空日志
DUMP TRANSACTION 库名 WITH NO_LOG

2.截断事务日志：
BACKUP LOG 库名 WITH NO_LOG

3.收缩数据库文件(如果不压缩,数据库的文件不会减小
企业管理器--右键你要压缩的数据库--所有任务--收缩数据库--收缩文件
--选择日志文件--在收缩方式里选择收缩至XXM,这里会给出一个允许收缩到的最小M数,直接输入这个数,确定就可以了
--选择数据文件--在收缩方式里选择收缩至XXM,这里会给出一个允许收缩到的最小M数,直接输入这个数,确定就可以了

也可以用SQL语句来完成 
--收缩数据库
DBCC SHRINKDATABASE(库名)

--收缩指定数据文件,1是文件号,可以通过这个语句查询到:select * from sysfiles
DBCC SHRINKFILE(1)

4.为了最大化的缩小日志文件(如果是sql 7.0,这步只能在查询分析器中进行)
a.分离数据库:
企业管理器--服务器--数据库--右键--分离数据库

b.在我的电脑中删除LOG文件

c.附加数据库:
企业管理器--服务器--数据库--右键--附加数据库

此法将生成新的LOG，大小只有500多K

或用代码： 
下面的示例分离 pubs，然后将 pubs 中的一个文件附加到当前服务器。

a.分离
EXEC sp_detach_db @dbname = '库名'

b.删除日志文件

c.再附加
EXEC sp_attach_single_file_db @dbname = '库名', 
@physname = 'c:\Program Files\Microsoft SQL Server\MSSQL\Data\库名.mdf'

5.为了以后能自动收缩,做如下设置:
企业管理器--服务器--右键数据库--属性--选项--选择"自动收缩"

--SQL语句设置方式:
EXEC sp_dboption '库名', 'autoshrink', 'TRUE'

6.如果想以后不让它日志增长得太大
企业管理器--服务器--右键数据库--属性--事务日志
--将文件增长限制为xM(x是你允许的最大数据文件大小)

--SQL语句的设置方式:
alter database 库名 modify file(name=逻辑文件名,maxsize=20)













