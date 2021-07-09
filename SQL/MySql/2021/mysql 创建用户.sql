
-- 创建用户

-- 命令:CREATE USER 'username'@'host' IDENTIFIED BY 'password';
-- 说明：
-- username：你将创建的用户名
-- host：指定该用户在哪个主机上可以登陆，如果是本地用户可用localhost，如果想让该用户可以从任意远程主机登陆，可以使用通配符%
-- password：该用户的登陆密码，密码可以为空，如果为空则该用户可以不需要密码登陆服务器

CREATE USER 'fanckyread'@'%' IDENTIFIED BY '123456';

SELECT * FROM mysql.user;



-- 二. 授权:

-- 命令:GRANT privileges ON databasename.tablename TO 'username'@'host'
-- 说明:
-- privileges：用户的操作权限，如SELECT，INSERT，UPDATE,DELETE等，如果要授予所的权限则使用ALL
-- databasename：数据库名
-- tablename：表名，如果要授予该用户对所有数据库和表的相应操作权限则可用*表示，如*.*

-- 只读权限
GRANT SELECT ON *.* TO 'fanckyread'@'%'

-- 所有权限
GRANT ALL ON *.* TO 'fanckyread'@'%';

-- navicat 可以登录，sqlyog 不行。要执行下面语句
 ALTER USER 'fanckyread'@'%' IDENTIFIED WITH mysql_native_password BY '123456';
 
 
 FLUSH PRIVILEGES;
 
 
 -- INSERT command denied to user 'fanckyread'@'localhost' for table 'person'
 
 -- 删除用户
 DROP USER 'fanckyread'@'%';
 
 
 
 
 
 
 

  -- 用UPDATE直接编辑user表

　  -- 　mysql -u root

　  -- 　mysql> use mysql;

　  -- 　mysql> UPDATE user SET Password = PASSWORD('newpass') WHERE user = 'root';

　  -- 　mysql> FLUSH PRIVILEGES;


  -- 在丢失root密码的时候，可以这样
  
-- https://blog.csdn.net/weidong_y/article/details/80493743
-- 进入mysql bin  目录
  -- bin>net stop mysql

  -- bin>mysqld --skip-grant-tables

--  重新打开一个 cmd 窗口。进入 bin  目录 。输入 mysql 回车
  -- bin>mysql

  --  mysql>use mysql

--
  -- mysql>update user set password=password("123456") where user="root";

  -- mysql>flush privileges;

  -- mysql>quit

  -- bin>mysqladmin -u root -p shutdown

  --  bin>net start mysql

 
 
 
 
 
 
 
 
 
 
 