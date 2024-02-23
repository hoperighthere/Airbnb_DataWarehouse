-- Step 1: Connect to Database_Two:

-- Step 2: Install / Create DBLink Extenstion:
CREATE EXTENSION dblink;

-- Step 3: Verify the system tables of DBLink:
SELECT pg_namespace.nspname, pg_proc.proname 
FROM pg_proc, pg_namespace 
WHERE pg_proc.pronamespace=pg_namespace.oid 
   AND pg_proc.proname LIKE '%dblink%';

-- Step 4: Test the connection for Database_One:
SELECT dblink_connect('host=localhost user=user password=pass dbname=airbnb_barcelona');

-- Step 5: Create foreign data wrapper and server for global authentication.
You can use this server object for cross database queries:

CREATE FOREIGN DATA WRAPPER user VALIDATOR postgresql_fdw_validator;
CREATE SERVER demo FOREIGN DATA WRAPPER user OPTIONS (hostaddr '127.0.0.1', dbname 'airbnb_barcelona');

-- Step 6: Mapping of user and server:
CREATE USER MAPPING FOR user SERVER demo OPTIONS (user 'user', password 'pass');

SELECT dblink_connect('demo');
