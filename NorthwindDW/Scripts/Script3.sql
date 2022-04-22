--SELECT name, index_id  
--FROM sys.indexes  
--WHERE OBJECT_NAME (object_id) = N'Order';  

EXEC sp_estimate_data_compression_savings   
    @schema_name = 'Fact',   
    @object_name = 'Order',  
    @index_id = NULL,   
    @partition_number = NULL,   
    @data_compression = 'COLUMNSTORE' ;   