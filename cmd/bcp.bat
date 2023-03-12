bcp "[dbo].[Categories]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Categories.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Customers]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Customers.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Employees]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Employees.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Order Details]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Order Details.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Orders]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Orders.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c
bcp "[dbo].[Products]" format nul -f "C:\SSIS\NorthwindBI\IngestData\Products.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)" -x -c

bcp "[dbo].[Categories]" out "C:\SSIS\NorthwindBI\IngestData\Categories.dat" -f "C:\SSIS\NorthwindBI\IngestData\Categories.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Customers]" out "C:\SSIS\NorthwindBI\IngestData\Customers.dat" -f "C:\SSIS\NorthwindBI\IngestData\Customers.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Employees]" out "C:\SSIS\NorthwindBI\IngestData\Employees.dat" -f "C:\SSIS\NorthwindBI\IngestData\Employees.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Order Details]" out "C:\SSIS\NorthwindBI\IngestData\Order Details.dat" -f "C:\SSIS\NorthwindBI\IngestData\OrderDetails.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Orders]" out "C:\SSIS\NorthwindBI\IngestData\Orders.dat" -f "C:\SSIS\NorthwindBI\IngestData\Orders.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
bcp "[dbo].[Products]" out "C:\SSIS\NorthwindBI\IngestData\Products.dat" -f "C:\SSIS\NorthwindBI\IngestData\Products.fmt" -S "SQL.Samorodov.su" -d "Northwind (упрощённая)"
