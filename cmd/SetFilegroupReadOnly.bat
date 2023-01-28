"-S "++" -E -i \""++"Scripts\SetFilegroupsReadOnly.sql" -v DatabaseName="++" CutoffTime='"++"' IsYearOptimisationWorked="+

SQLCmd -S (localdb)\MSSQLLocalDB -E -i "C:\Users\zinyk\source\repos\Northwind_BI_Solution\NorthwindDW\Scripts\SetFilegroupsReadOnly.sql" -v DatabaseName=NorthwindDW CutoffTime='01.01.1998' IsYearOptimisationWorked=False