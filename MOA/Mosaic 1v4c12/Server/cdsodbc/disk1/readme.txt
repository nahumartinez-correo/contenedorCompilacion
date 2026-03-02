Mosaic OA
Central Data Server
ODBC DRIVER 
INSTALLATION NOTES

85-35023-D12
Release 1

(Version 4.12) 
October 7, 1998

MOSAIC OA CDS ODBC DRIVER OVERVIEW	3
WHAT’S NEW IN THIS RELEASE	3
WHAT’S NEW IN THIS CHECKPOINT.	3
WHAT’S NOT IN THIS RELEASE	4
RELEVANT MANUALS	5
PREREQUISITES FOR INSTALLING THIS PACKAGE	6
HARDWARE	6
SOFTWARE Prerequisites	6
HOW TO INSTALL MOSAIC OA ODBC DRIVER	7
HOW TO UNINSTALL MOSAIC OA ODBC DRIVER	8
MISCELLANEOUS SETUP NOTES	8
FILE LOCATION	8
INITIALIZATION FILES	9
The Dictionary “.INI” File	9
ACCESS SECURITY	10
OUTSTANDING PROBLEMS	10
CHANGE LOG	11
 MOSAIC OA CDS ODBC Driver Overview
The CDS ODBC driver is for use with the Microsoft Windows NT operating system ONLY.  This package contains the Central Data Server ODBC client software.  It must be used in conjunction with separately released server software piece known as “Mosaic OA Central Data Server”.
WHAT’S NEW IN THIS RELEASE
? This is the initial release of the CDS ODBC driver package!
? ODB.dll is included with this package, as well as with the mosaic OA runtime package.
? In ODB.dll the DBrowsAffected() function has been changed.   The new version needs only one parameter instead of two.   The result is returned in RETVAL rather than being passed back in a parameter.    OFB files that contain calls to DBrowsAffected() must be re-compiled.
? This package includes Osql.exe, a command line interpreter, derived from source written by Kyle Geiger, the author of  “Inside ODBC”.    Osql should work with any ODBC driver.
WHAT’S NEW IN THIS Checkpoint.
V1.4.12
? No Changes.  This checkpoint was done as part of the CDSV checkpoint.

V1.4.11
? Trivial additions to Osql syntax.  This checkpoint was done as part of the CDSV checkpoint.
 
 V1.4.10
? Quoted column name aliases are allowed.  For example: SELECT myint as 'my little integer' from T
? Bug fixes in ODB.dll.
? Easier to apply patches to the distribution, if needed.

V1.4.9
? Setup now normally doesn't install the data dictionary tools that are usually installed with the mosaic Runtime package.   You can install these tools from with this package with the Custom setup option.
? Bug fixes.

V1.4.8
? Install now works with ODBC version 3.  This version also includes the ODBC 3.0 bug fixes supplied by Microsoft on April 25, 1997. 
? Setup and un-install are smoother.
? Setup has new option of not installing developer’s executables, source header and library files.
? Setup installs a system DSN instead of only a user DSN.  
? Added support for ANSI SQL join syntax for outer joins.

V1.4.7
? ‘Batch insert’ is used for all inserts, to achieve better performance by using fewer messages to server.
? Insert from select is now supported.
? Support for multiple VALUES lists on an SQL insert statement to create multiple rows with one statement.
? SQLParamOptions() function is now supported and this means that you may insert multiple records with a single insert statement, using a single VALUES list with bound parameter arrays.
? Added support for updating a column to NULL value from ODBC.
? A column ordinal number is now supported in ORDER BY clauses.
? The ALTER verb is now supported in SQL.   You may add columns or drop columns with an ALTER TABLE statement.   But you can’t do both add column and drop column within a single statement.
? TEXT is allowed as a data type specifier in a ‘create table’ statement, it means same as VARCHAR to CDS.
? Smalldatetime type is allowed as a column data-type, meaning DATE, for compatibility with some SQL-Server applications.
? Column definition option of NULL, which is the default, meaning ‘allow null value’.
? Applications may use dictionary fields from up to 7 different dictionary ‘applications’, within a single SQL statement, such as CREATE TABLE.
? Changed parser to allow the syntax table_name.index name in “DROP INDEX table_name.index_name” as well as the old “DROP INDEX index_name from table_name”.
? Use exclusive record update locks on ODBC fetches when reading on an updatable context within a LUW, when the SQL_TXN_ISOLATION option is SQL_TXN_READ_COMMITTED (the default) or higher.
? Use exclusive lock inside the server when reading for Update_All() and currently in a LUW and current connection option for concurrency is SQL_TXN_READ_COMMITTED.  That option setting is the default for users of the CDS ODBC driver.   
? Updates are automatically totally committed or totally rolled back if failed on any row.
? Make sure that SQL_TXN_ISOLATION option default value at the server is SQL_TXN_READ_COMMITTED.   (For ODBC clients only).
? Cleaned up some error reporting to return the proper SQLState.
? Return SQLState 21S01 when insert values list doesn’t match the column list.
? Set proper SQLState for bad option ID and bad option parameter value for SQLSetConnectOption().
? Return proper SQLState when given a bad table name on an ODBC INSERT statement.
? Return proper SQLState when given a bad primary key for an insert or a bad secondary key for any update.
? The ability to have multiple connections to a single server from a single process.
? The driver is thread safe.
? WordView is no longer installed with this package, although it is on the same CD-ROM.

V1.4.6 was skipped.
V1.4.5 
? Upgrade install works correctly.
? Record locking works correctly.
? ODB.dll has a new function, DBgetInfo(), an entry to SQLGetInfo().
? MKtabSQL.exe no longer converts all table names to lower case.
? CDS ODBC SQL parser allows select FOR UPDATE (with no updatable column list) as well as FOR UPDATE OF column_list.
WHAT’S NOT IN THIS RELEASE
? Support for arithmetic expressions in SQL.  Only Boolean expressions are supported.
? Support for declarative referential integrity with SQL ‘create table’  [not planned for future either].
? SQLBrowseConnect()
? SQLPutData()
? Support for 16 bit applications.   Olsy doesn’t plan to support 16 bit CDS applications.
? OFB date fields defined with length less than 8 are not supported.   They never will be. 
? Support for database access security except as described in “Access Security” below. 
? See the CDS ODBC Programmer’s Reference [cdsodbc.DOC] for a more complete review of facilities described in the ODBC API that are missing in this CDS driver.

RELEVANT MANUALS

Mosaic OA CDS ODBC Programmer’s Reference	ISD-00028

Mosaic OA Central Data Programmer’s Reference	ISD-00025

Mosaic OA RunTime Systems Reference Manual	ISD-00023

Mosaic OA OFB Interface to ODBC Programmer’s Reference  (moa\doc\odb.doc). ISD-00029
 
PREREQUISITES FOR INSTALLING THIS PACKAGE
HARDWARE
The minimum requirements for the workstations are as follows.

? 33MHz 80486 or compatible CPU
? 12MB of ram
? 3MB of free disk space
? Intel Ether Express or equivalent network board 

NOTE:	To avoid conflicts between the wincom board and your network board, the IRQ for the wincom card should be set to 2, and the IRQ for the network card should be set to 10.  The wincom board has a hardware jumper that must be used to select interrupt 2.  The Intel Ether Express board has no hardware jumpers, a software configuration utility must be used to select interrupt 10.
SOFTWARE Prerequisites
? One of: Microsoft Windows NT 3.51; Windows NT Server 3.51; Windows NT 4.0; Windows NT Server 4.0.
? TCP/IP
? mosaic OA Central Data Server version 1.4.7 or later, on the server machine.  		Part # 85-35011-D02
? mosaic OA runtime version 1.3.6 with Patch 2 or later is necessary only if you want to use the OFB interface to ODBC.  Part # 88-00056-C06.   You don’t need this if you are using C, VB, Crystal Reports, Access or some other third party tool to access your data via ODBC.
? To read this product’s documentation, you will need one of :
? Microsoft Word, version 7 or later. 
? Microsoft WordPad, version 4 or later
? Microsoft WordView, Version 8 or later.  [Included on the CD-ROM with this package.]
 
How to install mosaic OA ODBC Driver
The setup program works best when used with a monitor set up to show more than 640 x 480 pixels.
The following steps must be taken to install this mosaic OA ODBC CDS driver.

? Close all windows applications!
? Stop all servers that might be using ODBC, such as:
? SQL Server Executive, “SQLExecutive”;
? Uninstall this CDS ODBC driver package if you already have it installed and you aren’t installing on Windows NT 3.51.  This will maintain the correct usage counts in the registry, for files that are shared with other mosaic OA packages.
? If you are running on Window NT 3.51, you may wish to install WordView at this point, to enable you to read the CDS documentation, which is in Microsoft Word 6.0/95 format.   The WordView package is included on the CD-ROM with the CDS package.  It is not installed automatically.  To install WordView: cd \wordview\disk1 and run setup.exe.
? Install mosaic OA Central Data Server ODBC driver:
? From CD_ROM:
? Run setup.BAT in the root directory of the CD-ROM.  On NT4, “Control Panel\Add/Remove Programs” automatically finds this for you. Reboot the machine to ensure that new environment will be used.
 
? From Diskettes:
? Run setup.exe on diskette labeled disk1.  Put in the other diskettes when asked. “Control Panel\Add/Remove Programs” automatically finds this for you.
? Don’t reboot request re-boot until after installing the patch.
? Reboot the machine to ensure that new environment will be used.

Setup prompts you to choose one of Typical, Compact or Custom installation. 
? Typical installation includes everything but the data dictionary tools that are normally distributed with the mosaic Runtime package.
? Compact installation excludes the dictionary tools, sample programs, online help, minimum dictionary, and developer's include files and libraries.  Only the essential programs are installed and then a data source for your default data dictionary is configured.
? Custom installation allows you to select or omit any of the options mentioned above and it is the only way to include the data dictionary tools that are normally distributed with the mosaic Runtime package.
 Setup prompts you for the parameters required for setting up an ODBC data-source.  Use the Help feature of setup if you need more information on what to enter for the parameter.   You may postpone setting up a particular data source.   You may create, update or delete a data source via Control Panel / ODBC at any time after the initial install.    
  How to Uninstall mosaic OA ODBC Driver
 
 On Windows NT 4.0, use the Settings/Control Panel/”Add/Remove Programs” applet.  Choose “MOA CDS ODBC” and click on ADD/Remove.   On Windows NT 3.51 double click on the Uninstall Icon in the “mosaic OA” program group.
 After doing one of the above, some registry entries will remain.   You may delete these, listed below, with a registry editor.  This is not recommended.  Erroneous editing of the registry can make your system unusable.  Take care!   There is no reason to edit the registry if you are simply uninstalling before installing a newer version of CDS ODBC.   Only do this if you are intending to never use CDS ODBC.
 Under:  HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBCINST.INI
 	Remove Key: “CDS ODBC DRIVER”.
 Under:  HKEY_LOCAL_MACHINE\SOFTWARE\ODBC\ODBCINST.INI\ODBC DRIVERS
 	Remove value:  “mosaic OA CDS Driver”
 
 Before or after the un-install, use the control panel ODBC applet to delete the data sources defined for use with the CDS ODBC driver.  If you do this before the un-install, it works without comment.   If you do it after the un-install you get an error about the driver “could not be found.   Reinstall the driver”.   Ignore that error and the next message and the data source will be truly deleted.   Again, don’t do this if you simply want to install a new version of the driver.
 MISCELLANEOUS SETUP NOTES
 FILE LOCATION
 The set of files required for a mosaic OA system do not have to be installed in the root directory.  The following convention is followed to locate files required by CDS and its associated Console Tools.
 
 When CDSV or any of the Console Tools are invoked the MOADIR user environment or Registry key value located at : "HKEY_LOCAL_MACHINE\\SOFTWARE\\Olsy North America\\mosaic OA”  is searched for.  You may set or review the value with the PUTREG.EXE tool.  This defines the directory where the “lib” directory is located by various tools and RunTime components.  The “lib” directory contains message text files.
 
 To illustrate, when "d:\apps\moa\bin\ql.exe" is executed, the file "d:\apps\moa\lib\err_200" will be used  for displaying error message #201.
 
 When CDSV or any of the Console Tools are invoked then the MOAPROJ user environment variable or Registry key value is queried to obtain the location of all mosaic OA project Data Dictionaries and sources.  The default location for mosaic OA projects set by the PUTREG.EXE tool is “c:\moaproj”.   To configure a project you use the DDINIT.EXE tool to optionally create the project directory and its Data Dictionary data files.  The project name may be 30 characters long.
 
 There is no default project built-in.  However, a MOACURPROJ user environment or registry key value is searched for if a project is not explicitly referenced on the command line.  This registry key value may be set by the PUTREG.EXE tool.
 INITIALIZATION FILES
 The Dictionary “.INI” File
 This is a text file which stores information in several sections.  (Refer also to the section titled mosaic OA Initialization File in the mosaic OA RunTime System Reference Manual).   Each section title is enclosed in square brackets, in typical windows ".ini" style.  A default copy of this file is generated by DDINIT.EXE.  Since it’s a text file, it may be copied from another dictionary and renamed for the target dictionary.  Here are some of the sections, along with a description of the information stored in each:
 [CDS]
 For each cdserver there may be a section in the .ini file.  The section name is: cdsSERVNAME, where cds is a constant and SERVNAME is the optional service name suffix of the server, like main or cl.
 CDS_PRIMARY_NP	The name of the designated primary or only NT machine that runs cdserver.   Default is to use UDP broadcast search for the server.    The default is usually fine for customer installation but it is perilous in a development environment because you may randomly connect to someone else’s server with the same service name in your LAN.
 CDS_NWLOG	Optional MCN debug logging mask, for debugging only.
   Access Security
 System administrators can provide a yes/no type of access security to the entire CDS database through the use of Windows NT Server domain security.  For the ODBC drivers to be able to access the CDS database the ODBC driver must have access to the data dictionary that corresponds to the CDS database.  Access to the CDS database is regulated by controlling access to the data dictionary through file access permissions.    For applications other than Mosaic OA RT, the dictionary may be placed on a shared directory on the NT server.   You can do this for those RT applications too, at some cost in performance. 
  Set access security permissions through the NT Explorer application.   One way to do this is to right-click on the file or directory name and select Properties from the popped-up menu.   On Windows NT 3.51, use FileManager/Security menu.
? Avoid placing your data dictionary on a F.A.T. file system.   There is no security on F.A.T. files!
? Do use NTFS file system.
? Don’t grant read permission to “Everyone” on the DD* files in your $MOAPROJ directories!
? Do remove all permissions to “Everyone” on your $MOAPROJ directory.
? Grant only read permission on your dictionary files to all users or groups of NT users to whom you want to grant access to your database.
? Avoid granting read permission on the CDS data directory to anyone other than system administrators.
OUTSTANDING PROBLEMS 
1. After installing, un-installing, and re-installing, some of the icons in the moasaic OA program group may be obscured.  Fix this by pulling down the View menu and clicking on “Arrange Icons”.
2. OFB special field, RETVAL, can’t be passed as a parameter to DLL functions in versions of RT linked before August 7, 1996.    Work around this bug by setting a local variable to RETVAL then pass the local variable to the DLL function.
3. SQLPutData() doesn’t work yet.   Use SQLBindParameter () instead.
4. SQLStatistics() returns cardinality only for the table as a whole, not for Index columns, nor for indexed records on filtered indexes.  There is no plan to change this.
 
5. DBproc() function in ODB.DLL works only for ORACLE and not for SQL Server.   It also doesn’t work for CDS because CDS doesn’t support stored procedures at all. 
6. Crystal Report Writer, version 5.0, doesn’t support the ODBC SQL_TIME column type.  In fact, it doesn’t do anything good with TIME column data.    If you must report time columns, use a different tool, not Crystal Report Writer, or, before reporting, export the relevant tables into a temporary table with ASCII instead of time columns.
7. If you ALTER a variable format table to make columns visible to third party tools, the columns you add must include the columns that already compose the primary key of the table.  Otherwise tools like Access will complain or crash.
8. Internet Provider Sign-in Screen Appears whenever you try to connect to CDS.   Correct this as described in Microsoft Knowledge Base article ID:Q134700:
? Use the right mouse button to click on the Internet icon on your desktop, and then click Properties on the menu that appears.
? Click the Use AutoDial or "Connect to the Internet as needed" check box to clear it.
? Click OK.
 CHANGE LOG
 
 Mosaic OA Central Data Server ODBC Driver "Change & Enhancement" Log
 
 Listed below are all changes implemented in version 4.12 
 of the mosaic OA Central Data Server ODBC Driver
 P/N: 85-35023-D12
 
 Note: These changes are listed in chronological order beginning with the latest changes listed first.
 
 Checkpoint 1.4.12 made here
? No Changes.  This checkpoint was done as part of the CDSV checkpoint.
 Checkpoint 1.4.11 made here
 9-23-97 Osql.exe enhancement (s)
? Entering the word "Tables" or "tables name_quailifier"  as a command will call SQLTables(,,,,name_qualifier,SQL_NTS,"TABLE",5) and fetch and display the results, a list of tables.  The name_qualifier is a LIKE pattern.  For example "Tables P%" lists all tables with names beginning with the letter 'P'.
 
? Entering the word "Views" or "views name_quailifier"  as a command will call SQLTables(,,,,name_qualifier,SQL_NTS,"VIEW",4) and fetch and display the results, a list of views.
 
? Entering the word "TableTypes" or "tabletypes"  as a command will call SQLTables) and fetch and display the results, the list of table type names used by the data source.
 
? Entering the word "Columns" [<table_name>] as a command will call SQLColumns() and display a list of  columns with data type.   This list is similar to that from SQLColumns but it has less information per row.
 
? Entering the word "ColumnNames" <table_name> as a command will call SQLColumns() and display a list of  columns names for the named table.   This list is the same as that from SQLColumns but it has much less information per row.
 
 Checkpoint 1.4.10 made here
 8-12-97 CDSODBC fixes (s)
? Fixed a problem in pointer arithmetic on records longer than 32K. file results.c.
? Fixed a minor bug in str2col() that occasionally raised an error even though the operation was successful.   File str2col.c.
7-18-97 ODB.dll Change (s)
? Left zero fill FT_NUMERIC fields when moving column values to fields.
? Updated the odb.doc to note that the driver used must support the ODBC 2 API.   A driver that supports only the ODBC 3 API is not compatible.   The ODBC 3 driver manager is compatible.
7-02-97 Osql.exe Fix (s)
? Improved the Usage: statement result from "Osql -?" to better explain -F option.
? Default DSN is now "CDS" concatenated with MOACURPROJ from registry, if any.
7-02-97 CDSODBC Fix (s)
? Quoted column name aliases are allowed.  For example: SELECT myint AS 'my little integer' FROM table_T
 6-30-97 ODB.DLL Fix (s)
? Fixed MAJOR memory leak problem in all query processing.
? Added new function, DBfreeEnv() to call SQLFreeEnv() and release the environment control block.   This function also calls DBdisconnect() for all open connections on the environment.
? Fixed minor memory leaks in DBqclose() and DBdisconnect().
? Fixed bug in handling FT_INT fields in dynaset updates.
6-10-97 ODB.DLL Fix (s)
? Fixed problem with single digit FT_NUMERIC fields updating numeric(1) columns.
? Fixed (or worked around) update problem with decimal(1,1) columns.
6-04-97 CDSODBC Fix (s)
? Fix bug of ignoring pcbValue parameter to SQLBindParameter() when it doesn't indicate NULL VALUE.
? Allow setup choice of not installing dictionary tools that are included in RT package.
? Fix bug in setting DISTINCT switch on SELECT projection lists
5-23-97 OSQL.exe Fix (s)
? Fixed problem that caused failure of cdscolumns function when the current default application was not “common”.
 5-23-97 CDSODBC.DLL Fix (s)
? Fixed problem with last digit of values input from FT_FIXED fields.  This problem caused 99.999 input from a fixed (5,3) field to be inserted as 99.990 in a numeric(5,3) column.
5-23-97 ODB.DLL Fix (s)
? Fixed problem with last digit of values input from FT_FIXED fields.  This problem caused 99.999 input from a fixed (5,3) field to be inserted as 100.00 in a numeric(5,2) column.
 5-19-97 ODB.DLL  enhancements (s)
? This list parameter to the following functions may be passed in an indirect field object:
? DBmultiDisplay();
? DBretrieve();
? DBcreateDynasetLst();
? DBcreateQueryLst();
? DBinsertLst().
Checkpoint 4.8 here.
5-13-97 CDS ODBC (s)
? Applied Microsoft service pack of 4/25/97 to ODBC driver manager modules installed with CDS driver.
 5-12-97 ODB.DLL  bug fix (s)
? Fixed bug that caused error 5494, “out of buffer space” on an insert or update with many numeric fields.
 5-08-97 CDS ODBC (s)
? Added support for ANSI SQL join syntax for outer joins.
? Fixed bug in SQLTransact that cause failure when the environment handle parameter was NULL.
? Changed driver package setup to use ODBC 3.0 driver manager and attendant software.  CDS ODBC driver is still at ODBC version 2.5.
? Setup now works from remote unmapped drives.
4-29-97 CDS ODBC (s)
? Fixed bug in returning SQL_LOCK_TYPES from SQLGetInfo().
 
 Checkpoint 1.4.7 hear
 3-26-97 CDS ODBC Fixes (s)
? Got rid of translator options when adding a data source.
? Fixed tab order in "add data source" dialog.  Fixes PSR # 3837.
3-20-97 ODB.dll bug fixes (s)
? Fixed bug in handling FT_NUMERIC fields with maximum length values.
? Return –DB77 when expected.   Fixes PSR # 3826.
3-17-97 CDS ODBC Enhancement (s)
? Added support for SQL ALTER TABLE statement to allow developers to add or drop column definitions for a table.
? ALTER TABLE with ADD column is now supported for variable schema tables to allow use with third party reporting tools like Crystal Reports and MS Access.
3-12-97 Osql.exe Enhancement (s)
? Added SLEEP verb for use in testing scripts.
 3-12-97 ODB.DLL Fix (s)
? Fix bugs in setting column precision, especially for timestamp data.
? Added to dberrs.h #define MOA_PUT_EMPTY_STRING_AS_NULL 2202, option ID for DBsetConnectOption().
3-10-97 Osql.exe  changes (s)
? Allow semi-colon at end of tables, sqltables, and types requests.
? Honor 'commit', 'rollback' and 'begin work' requests.
03-05-97 CDSODBC.dll - Enhancement (s)
? Added support for inserting mulitple records, using bound parameter arrays.
? Added support for ODBC API function SQLParamOptions() as a part of the array insert support.
03-04-97 ODB.dll - Enhancement (s)
? New client side option MOA_PUT_EMPTY_STRING_AS_NULL for DBsetConnectOption().  The default is FALSE, meaning FT_ASCII fields with empty string values are set to the database as a zero length string.  The trouble with this is that SQL-Server silently converts empty strings to single character blank strings.
 02-27-97 CDS ODBC Enhancements (s)
? Allow smalldatetype as a column data-type, meaning DATE
? Allow column definition option of NULL, which the default, meaning ‘allow null value’.
? support error SQLState 21S01 when insert values list doesn’t match the column list.
? Give a more explicit error message when user tries to update current of cursor when that cursor was not defined with a FOR UPDATE clause in the select statement.
02-25-97 CDS bug fixes (s)
? Use exclusive record update locks on ODBC fetches when reading on an updatable context within a LUW, when the SQL_TXN_ISOLATION option is SQL_TXN_READ_COMMITTED (the default) or higher.
? Use exclusive lock inside the server when reading for Update_All() and currently in a LUW and current connection option for concurrency is SQL_TXN_READ_COMMITTED.  That option setting is the default for users of the CDS ODBC driver.   Users of the old interface may set that option too, via SetConnectOption(), but their default is SQL_TXN_READ_UNCOMMITTED.
? Wrap the update in a LUW whenever not already in a LUW and the update is a Cds_Update_All() that could affect more than one record.
? Set proper SQLState for bad option ID and bad option parm value for SQLSetConnectOption.
? Make sure that SQL_TXN_ISOLATION option default value at the server is SQL_TXN_READ_COMMITTED.   (For ODBC clients only).
? Added support for updating a column  to NULL value from ODBC.
? Return correct SQLState when given a bad table name on an ODBC INSERT statement.
? Return correct SQLState when given a bad primary key for an insert or a bad secondary key for any update.
02-14-97 CDS Enhancements (s)
? Requests for EXCLUSIVE record locks are silently downgraded to simple update locks when the lock requests are outside of a Logical Unit of Work.
? CDS ODBC SQL now supports insert from a query spec as well as from a values list.
02-13-97 CDS Enhancements (s)
? Ordinal numbers in SQL ‘ORDER BY’ clauses are now supported.  The ordinal number must refer to a column in the projection list.
 02-11-97 CDS Enhancements (s)
? Added batch insert function to client and server.
? Changed QL to use batch insert when inserting from a selected context.
? Changed CDSODBC driver to use batch insert for every insert.  The normal batch size is one.  The batch may contain as many records as will fit in one 64K buffer.
? Allow multiple VALUES lists on an SQL insert statement to create multiple rows with one statement.
? Allow TEXT as a data type specifier in a create table statement.
? Allow user to use dictionary fields from up to 7 different dictionary applications, within a single SQL statement, such as CREATE TABLE.
02-06-97 CDSODBC.dll bug fixes (s)
? Added multi-thread support.   The driver is now ‘thread safe’.  Fixes PSR 4011.
? Detect and report invalid date literals in SQL ‘where’ clauses.
? Cleanup up some other error reporting to return the correct SQLState.
? Change parser to allow table_name.index name in DROP INDEX table_name.index_name.
01-31-97 CDSODBC.dll bug fixes (s)
? Added function SQLNativeSql().  If the parser likes a statement it will return it via SQLNativeSql.   You still can’t see what goes to server execept through prcaptur.exe.
? Changed parser to recognize GRANT statements.  Nothing is done with them but now scripts with GRANTs in them can be executed without error.
01-28-97 CDSODBC.dll bug fixes (s)
? Fixed bugs in parsing and handling hexadecimal (bulk) constants.
 01-22-97 CDSODBC.dll bug fixes (s)
? Fixed bugs in handling SQLSetPos() with unlock.
? Added a table to the client-side list of tables during SQLTables() if needed.   So, tables created by others since the ODBC connection was established can be accessed.
? Fixed a bug in getting the columns of a one-ary table.
? Fix bug in binding date and time variables with ascii separator characters embedded.
? Fix bug in SQL “drop index NAME” interpretation.
01-22-97 ODB.dll bug fixes (s)
? Fixed bug in update of CDS record via update current of cursor.
? Fixed bug in DBdropTable() that caused a crash when an identical table was created later.
01-21-97 CDSODBC.dll bug fixes (s)
? Fixed bugs in handling order by DESCending in selects.
? Added ability to set default dictionary application by name as well as by number.
01-17-97 ODB.dll enhancement (s)
? New function DBgetInfo() an entry to SQLGetInfo().
 01-16-97 CDSODBC.dll bug fixes (s)
? Fixed bugs in handling FT_IND, date and time strings as parameters and as literals for where clause criteria.
? Again allow psuedo multiple connections to a CDS server from a client, since Access uses them.
01-15-97 ODB.dll bug fixes (s)
? Fixed bugs in storing newly created tables in client side array of tables.
? Fixed performance problem on inserts that caused too many calls to SQLTables().
? Return -DB_NO_DATA instead of -DB54 from DBgetColumnValue() when prior fetch failed or was never executed.
01-08-97 CDSODBC.dll fixes and enhancements (s)
? Allow NULL pointer for the pcbValue parameter of SQLBindParameter.
 01-07-97 oSQL.exe fixes and enhancements (s)
? Ignore most errors on ‘application’ statements used to set the default application.
 01-06-97 MKtabSQL.exe fixes and enhancements (s)
? Remember and allow up to two dictionary applications for fields in CDS tables.
? Automatically detect whether or not the DBMS is CDS.
? Stop converting table names to lower case.
01-06-97 CDSODBC.dll fixes and enhancements (s)
? Trim the garbage from the end of yytext when showing SQL syntax error messages.
? Allow select FOR UPDATE (with no updatable column list) as well as FOR UPDATE OF column_list.
12-20-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug in handling of attempts to read a locked record.
? Change to allow setting of a time-out period on a stmt for fetches, thru SQLSetStmtOption().  This is effective on locking conflicts but not on simply lengthy searches.
? Allow an ORDER BY clause in a select for update.
? Added an empty wrdview6.opt to the distribution to improve the uninstall.

Checkpoint 1.4.4 here.
12-18-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug in handling of quoted quote characters in string literals.
? Change to allow setting of a time-out period on a stmt for fetches.  This is effective on locking conflicts but not on simply lengthy searches.
11-25-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug in support of the USER keyword as a value in updates and selection criteria.
? Added support for CURRENT_DATE and CURRENT_TIME as values in updates and where-clause expressions.
? More fixes to present the correct SQLState code for invalid object names.
11-23-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug in using SQL_C_DEFAULT C type for bound parameters.
? Changed to set SQLState ‘S0022’ instead of ‘37000’ for bad column name specifiers.
? Changed to return correct SQLState code 'S0001' when returning error "duplicate table".
? Fixed a bug in SQLStatistics() for unique only selection criteria.
? Fixed bugs in retrieval of SQLStatistics()+ data.
? Changed handling of decimal integer input to FT_BULK fields.
11-22-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug that caused crash when using DROP INDEX without specifying a table name.
? Improved handling of multiple dictionary applications.
? Changed SQLRowCount() to return -1 when not applicable
? Changed SQLRowCount() to return number of rows affected by an update or delete.
? Changed Osql.exe to accept application commands for setting the default dictionary app.
11-21-96 ODB.dll fixes and enhancements (s)
? Added DBsetConnectOption(), which can be used for setting appl_id.
? Added possibility of setting or reseting dictionary application between create statments.
? Added application name change facility between create statements in mktabsql.exe.
11-18-96 CDSODBC.dll fixes and enhancements (s)
? Fixed bug that caused crash of SQLDescribeCol() when it was called for an INSERT statement.
 11-18-96 ODB.dll fixes and enhancements (s)
? Moved all required #define macros from include\ofb\dbdeclar.ofb to include\ofb\dberrs.h so they can be included where needed.
 11-14-96 CDSODBC bug fixes (s)
? Fixed more bugs in using SQL_C_DEFAULT binding type with SQLGetTypeInfo() SQL_C_short columns.
? Enforce table owner always == NULL_DATA to make MS QUERY work as desired, (instead of returning an empty string for the table owner).
11-09-96 CDS client bug fixes (s)
? Terminate the heartbeat thread during MCNClose() if there are no more active connections.
? Deregister the class used for the private window in all clients but rt.
11-08-96 ODB.dll fixes and enhancements (s)
? Work around bug in MS SQL ODBC Driver that causes ‘numeric value out of range’ when value == 0 and scale == precision.
? Fix bug that cause crash when comparing cleared FT_IND field to valid non-null column.
11-07-96 ODB.dll fixes and enhancements (s)
? Fixed bugs. Previously, if a field had numchars == 0 and dataentered == 0, the code assumed that the field held a NULL value.  That was incorrect.  In the new version of odb.dll:
? * field->numchars will be ignored except for BULK data.  For example, a field of type ASCII with numchars == 0 may contain a string with any number of valid characters.  
? * field->flags.dataentered will always be ignored except for in the DBupdate() function.  The DB_update() function is similar to DBupdate except that it completely ignores the dataentered flag.
? * You may NOT use DB_update() to change a column’s value to NULL by clearing the field with clearfield except for fields of type DATE and IND (indirect).   After a clearfield operation, an SQL update or insert using the cleared field will yield a column value of zero or empty-string instead of NULL, except for DATE and IND values, which will yield NULL value in corresponding column.
? * If you insert or update from a cleared date field the result date is NULL, as before, because the year zero is always invalid and because the year 1 is often invalid, as it is for SQL-Server ‘smalldatetime’ columns.
? Crashes caused by internal detection of error conditions, (calls to erbug()) no longer occur unless the appropriate bit, DBLOG_CRASH_ON_BUG, is set via DBsetDebug().  Instead, a message is appended to stderr and the NT Application Event Log, when available via the OS.
10-30-96 CDS ODBC Driver changes (s)
? Fixed a bug in join with ANSI SQL fetch behavior.
? Added CDScolumns and SQLColumns to osql to respond to PSR #3858-5.
? Fixed bugs in osql data types display when using ‘types” command.
10-24-96 CDS ODBC Driver changes (s)
? Added Osql.exe to the distribution package and the \moa\src\makefile.
? Fixed another bug in detecting ‘fetch before select’ sequence errors.
? Fixed bug in converting 'yyyy-mm-dd' literal values to FT_DATE field values.
10-21-96 CDS ODBC Driver fixes (s)
? Fix bug in length of CDS context name used in SQLStatistics().  This bug appears only with very long table names.
? Added support for SQLColAttributes().
? Fixed bugs in fetch retrieval of bound columns not retrieved in physical order.
? Fixed bug in handling superfluous table name qualifiers in selection criteria.  Example: select * from TEST where TEST.mycolumn < 12.   In previous versions, table name qualifiers were allowed only in join selection criteria.
? Added cdsodbcs.mak for slim version make.
10-16-96 CDS ODBC Driver fixes (s)
? Fixed bugs in handling null values.
? Fixed bugs in handling IS NULL in selection criteria.
? Fixed bug in SQLFreeStmt() with SQL_CLOSE option.
10-15-96 ODB.dll fixes and enhancements (s)
? Fixed bug in calculation of input precision for input from FT_FIXED fields.
? Improved debug logging.
10-14-96 CDS ODBC Driver fixes (s)
? Fixed bug in “order by” that caused descending order when ascending was wanted.
? Fixed bugs in creating table of errors for return by SQLError().
? Fixed memory leaks.
? Fixed bugs in handling truncation of decimal fractions when the returned value must be truncated.
? Fixed bugs in SQLExtendedFetch().
? Better reporting of SQL Syntax errors.
? Fixed bugs in handling null values on columns of type FT_IND.
? Fixed bugs in handling zero length values of types FT_INT and FT_DECIMAL.
? Fixed bug in reuse of a stmt via SQLExecDirect() when the stmt has parameters.
09-24-96 ODB.DLL fix (s)
? Changed to support ONLY optimistic concurrency for Microsoft SQL Server V6.5 and earlier.  This is because of massive locking problems in the demo application.
? Changed DBgetColumnValue() to be more forgiving of conversion errors going from SQL_TIMESTAMP to FT_ASCII.  If the time stamp value won’t fit and the hours, minutes and seconds are zero, we try again with only the YYYYMMDD value.
? If the conversion still fails the user gets a more explicit error message.

