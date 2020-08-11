



-- 1、公开数据库中自动生成的唯一二进制数字的数据类型。
-- 2、timestamp 通常用作给表行加版本戳的机制。
-- 3、存储大小为 8 个字节。 不可为空的 timestamp 列在语义上等价于 binary(8) 列。可为空的 timestamp 列在语义上等价于 varbinary(8) 列。这将导致在C#程序中获取到的timestamp类型则变成了byte[]类型。所以如果我们需要从数据库中获取并使用这个时间戳的话就必需经过转换。
-- 4、timestamp 数据类型只是递增的数字，不保留日期或时间。 若要记录日期或时间，请使用 datetime 数据类型。
-- 5、一个表只能有一个 timestamp 列。每次插入或更新包含 timestamp 列的行时，timestamp 列中的值均会更新。对行的任何更新都会更改 timestamp 值。
-- 、总结：SQL Server timestamp 数据类型与时间和日期无关。SQL Server timestamp 是二进制数字，它表明数据库中数据修改发生的相对顺序。实现 timestamp 数据类型最初是为了支持 
--   SQL Server 恢复算法。每次修改页时，都会使用当前的 @@DBTS 值对其做一次标记，然后 @@DBTS 加1。这样做足以帮助恢复过程确定页修改的相对次序，
--  但是 timestamp 值与时间没有任何关系。@@DBTS 返回当前数据库最后使用的时间戳值。插入或更新包含 timestamp 列的行时，将产生一个新的时间戳值。



select @@DBTS;

