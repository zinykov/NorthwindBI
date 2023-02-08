bcp "[dbo].[Categories]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Categories.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Customers]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Customers.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Employees]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Employees.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Order Details]" format nul -f "C:\SSIS\NorthwindBI\IngestData\OrderDetails.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Orders]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Orders.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Products]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Products.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c

bcp "[dbo].[Categories]" out "C:\SSIS\NorthwindBI\IngestData\Categories.dat" -f "C:\SSIS\NorthwindBI\IngestData\Categories.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Customers]" out "C:\SSIS\NorthwindBI\IngestData\Customers.dat" -f "C:\SSIS\NorthwindBI\IngestData\Customers.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Employees]" out "C:\SSIS\NorthwindBI\IngestData\Employees.dat" -f "C:\SSIS\NorthwindBI\IngestData\Employees.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Order Details]" out "C:\SSIS\NorthwindBI\IngestData\OrderDetails.dat" -f "C:\SSIS\NorthwindBI\IngestData\OrderDetails.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Orders]" out "C:\SSIS\NorthwindBI\IngestData\Orders.dat" -f "C:\SSIS\NorthwindBI\IngestData\Orders.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Products]" out "C:\SSIS\NorthwindBI\IngestData\Products.dat" -f "C:\SSIS\NorthwindBI\IngestData\Products.xml" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
