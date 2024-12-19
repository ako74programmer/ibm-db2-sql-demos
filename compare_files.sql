--  category:  Db2 for i Services
--  description:  Utilities - Compare Database files
--  Note: If no rows are returned, there are no miscompares
--  minvrm: V7R4M0
--

--  For evaluation purposes, create two sample databases
call qsys.create_sql_sample('DOORSTORE1');
call qsys.create_sql_sample('DOORSTORE2');

--
-- Compare will find no differences and return an empty result set
--
select *
  from table (
      qsys2.compare_file(
        library1 => 'DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'YES', 
        compare_data => 'YES')
    );
stop;  

-- Change one of the files to introduce a difference
update doorstore2.sales set sales = sales + 1 limit 3;

--
-- Compare will find 3 rows differ
--
select *
  from table (
      qsys2.compare_file(
        library1 => 'DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'YES', 
        compare_data => 'YES')
    );
stop;    


--
-- Compare will return as soon as the first difference is found
--
select *
  from table (
      qsys2.compare_file(
        library1 => '
--  category:  Db2 for i Services
--  description:  Utilities - Compare Database files
--  Note: If no rows are returned, there are no miscompares
--  minvrm: V7R4M0
--

--  For evaluation purposes, create two sample databases
call qsys.create_sql_sample('DOORSTORE1');
call qsys.create_sql_sample('DOORSTORE2');

--
-- Compare will find no differences and return an empty result set
--
select *
  from table (
      qsys2.compare_file(
        library1 => 'DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'YES', 
        compare_data => 'YES')
    );
stop;  

-- Change one of the files to introduce a difference
update doorstore2.sales set sales = sales + 1 limit 3;

--
-- Compare will find 3 rows differ
--
select *
  from table (
      qsys2.compare_file(
        library1 => 'DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'YES', 
        compare_data => 'YES')
    );
stop;    


--
-- Compare will return as soon as the first difference is found
--
select *
  from table (
      qsys2.compare_file(
        library1 => 'DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'QUICK', 
        compare_data => 'QUICK')
    );
stop;  

DOORSTORE1', 
        file1 => 'SALES', 
        library2 => 'DOORSTORE2',
        file2 => 'SALES', 
        compare_attributes => 'QUICK', 
        compare_data => 'QUICK')
    );
stop;
