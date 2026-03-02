mosaic OA
Central Data Server
INSTALLATION NOTES

85-35011-D02
Release 1

(Version 4.10)
August 14, 1997



 
MOSAIC OA OVERVIEW	3
Compatability	3
WHAT’S NEW IN THIS CHECKPOINT	3
WHAT’S NEW IN THIS RELEASE	4
WHAT’S NOT IN THIS RELEASE	4
SUMMARY OF DIFFERENCES BETWEEN MOA CDS  V3 AND V4	4
RELEVANT MANUALS	5
PREREQUISITES FOR MOSAIC OA INSTALLATION	5
HARDWARE	5
SOFTWARE Prerequisites	5
mosaic OA CDS INSTALLATION	6
mosaic OA CDS DEINSTALLATION	8
MISCELLANEOUS SETUP NOTES	9
New Fields Required in Dictionary	9
FILE LOCATION	10
INITIALIZATION FILES	10
The Dictionary “.INI” File	10
SYSTEM BACKUP	11
Emergency Workstation Server Setup	11
OUTSTANDING PROBLEMS	12
CHANGE LOG	13


MOSAIC OA OVERVIEW
mosaic OA   (MOA) is for use with the Microsoft Windows NT or Windows 95 operating system.  The 
CDS client software can run happily on Windows 95.   The server software can also run on Windows 95 
but we recommend that you run it only on Windows NT.  This package contains the Central Data Server 
software.  It may be used in conjunction with a separately-released workstation software piece known as 
“Mosaic OA Development and Runtime”.  It may also be used with separately released workstation 
software product know as “Mosaic OA CDS ODBC Driver”.

Compatability
mosaic OA  provides a migration path from Pinnacle Plus Release 4/5.  The CDS table data is compatible 
with Release 1.1 and 1.2.  No data conversion is required to upgrade from mosaic OA Release 1.1 to 
mosaic OA Release 1.4, simply import your table data after exporting with Release 1.  Or, verify that the 
field tables are the same and remove the ddtime file(s).  There is no conversion for moving from Release 
1.3 to 1.4.   Simply install the new software and access the old data without any data changes!   This server 
package may be used with MOA runtime package version 1.3.7 or later.
WHAT’S NEW IN THIS CHECKPOINT
1.4.10
? Added the ability to do CDS log recovery to a select set of tables rather than the entire 
database.  This is accomplished by listing the tables to recover in the 'apply log' file.
? Corrected bugs in the system-failure recovery logic.
? The setup data is no longer split into diskette size pieces.  It must be run from a CD-ROM or 
hard disk. 
? Patches are now easily added to the distribution via a patch.bat in directory disk1.

1.4.9	
? The setup script was changed to not install msvcrt40.dll, which was causing problems on 
Win95 systems.
? The setup script was changed to accommodate the option of not installing the dictionary tools 
which are also available in the rt package.   If you use the rt package, it is better to install the 
dictionary tools from that package only.
? The setup script was changed to accommodate the option of installing only the client side 
utility programs, like cdsstat.exe and not the server programs like cdsv.exe. 
? The server configuration program, svrcfg.exe, was improved to hide advanced options unless 
requested by the user.
? Bug Fixes.

1.4.8	This checkpoint was skipped. 
1.4.7
? Two-phase-commit functions as it should.   In previous versions, two-phase commit worked only on 
Unix servers.
? Cdinstsv.exe has a new option to list the installed servers in one line per server.  This list includes 
UDP port numbers.
? ALTER TABLE supports adding or dropping column definitions.  This can be used to enable third 
party reporting tools like Crystal Reports and MS Access to read variable schema CDS tables.
? Batch insert is used by the ODBC interface and by QL when copying table records.
? Svrcfg, the cdserver configuration program invoked by the install process will warn you of attempts to 
use a single UDP port number for more than one server on NT.
? WordView is not installed with this package.  The WordView package is include on the CD-ROM 
with this CDS package and you may install it if you need it to read the CDS documentation.   You may 
use Microsoft Word instead.  If you are on Windows 95 or Windows NT 4.0 or later, you can use 
WordPad, which come with the O/S.
WHAT’S NEW IN THIS RELEASE
? Server side functionality necessary to support ODBC clients. 
? CDS utility programs all use a new DLL, cdscl.dll so the disk footprint of the package is 
smaller than in previous versions.
? Installation via InstallShield 3, provides an uninstaller, which works only on Windows95 and 
Windows NT 4.0, not on Windows NT 3.51.
WHAT’S NOT IN THIS RELEASE
? CDSERVER resilience on Windows NT.   Resilience is still only available with UNIX 
servers.
SUMMARY OF DIFFERENCES BETWEEN moa CDS  V3 and V4
? A new catalog table, ‘fields’ for supporting ODBC catalog functions like SQLColumns().
? New required fields in the data dictionary to support the fields table.  These are listed in 
$MOAPROJ\min\newflds.
? New selection criteria comparators:  is_not_null; is null; [SQL] like pattern match; and 
not_like pattern match.  These are available through QL.exe and CDS OFB verbs.  They are 
available with a slightly different syntax via ODBC.
? Some more support for fixed-schema tables.
? Fixed-schema tables are defined with a column list.
? Columns may be defined as ‘required’ or ‘null OK’.   The default is ‘required’.
? On insert and update on fixed-schema tables the server verifies that required fields 
are present and fields not defined as columns for the table are not present.
? Fixed-schema tables may be defined only through the ODBC interface, not via QL.
? Common CDSCL.DLL for all clients other than rt.  This makes the disk footprint much 
smaller.
? Enhanced query optimizer to recognize comparisons to empty string values for fields in 
indexes.  Always read the minimum or zero index and base records.
? Enhanced query optimizer to recognize IS_MISSING criteria for fields in indexes.
? Added more explanation of the optimizer’s index choices when the -E option is used
? Added printing of number of index and base records read when the Explanation level option 
is relevant and set non-zero.
? Increased the maximum number of variables in a criteria expression from 100 to 255.
? Optional ANSI SQL cursor fetch behavior, instead of historical CDS fetch behavior.   The 
ANSI behavior is the default for applications using ODBC.  Programs using the old 
proprietary interface default to the historical behavior.
? Optional ANSI SQL NULL value behavior on fetches with a projection list.  Old default 
behavior is to return zero for numerics and empty string for ASCII fields that are missing.  
The default for programs using the ODBC interface is the ANSI behavior.
? LIST option in command line for cdinstsv.exe.
? Two phase commit is now functional on NT.
? Batch insert is used by the ODBC driver for all inserts.
? QL uses batch insert when inserting records from a select context.

RELEVANT MANUALS

Mosaic OA Central Data Server Programmer’s Reference	ISD-00025
(formerly “CDS Notes”)

mosaic OA RunTime Systems Reference Manual		ISD-00023

mosaic OA CDS ODBC Programmer’s Reference		ISD-00028
PREREQUISITES FOR mosaic OA INSTALLATION
HARDWARE
The minimum requirements for the server machines are as follows.

? 33MHz 80486
? 16MB of ram (minimum 24MB recommended)
? 200MB of disk
? Intel Ether Express or equivalent network board 

NOTE:	To avoid conflicts between the wincom board and your network board, the IRQ for the wincom 
card should be set to 2, and the IRQ for the network card should be set to 10.  The wincom board 
has a hardware jumper that must be used to select interrupt 2.  The Intel Ether Express board has 
no hardware jumpers, a software configuration utility must be used to select interrupt 10.
SOFTWARE Prerequisites
? One of : Microsoft Windows 95;  Windows NT 3.51; Windows NT Server 3.51; Windows 
NT 4.0; Windows NT Server 4.0.   Use of Windows 95 for the server is not recommended.
? TCP/IP
? mosaic OA runtime 1.3.6 + patch 2 or a later version, if you want to use the run time 
interface.  Part # 88-00056-C06.   You don’t need this if you are using VB, Access or some 
other third party tool to access your data via ODBC.
? To read this product’s documentation, you will need one of :
? Microsoft Word, version 7 or later. 
? Microsoft WordPad, version 4 or later
? Microsoft WordView, Version 8 or later.  [ Included on the CD-ROM with this package.]

mosaic OA CDS INSTALLATION
The following steps must be taken to install mosaic OA CDS.

1) Install Microsoft Windows NT or Microsoft Windows NT Server or Window 95.
2) Set up and configure TCP/IP.
3) If your machine is using a Domain Name Server, your machine must be registered with that DNS,  
- or -
 You must have an entry in the hosts file for the machine upon which you are installing.  That is 
the machine must have an entry in its hosts file for itself.
4) If you don’t already have your data dictionary on the target machine, copy your moa data 
dictionary from a work station to the server machine.  You may need to create directories to do 
this.   The install process creates a test dictionary named ‘min’ if you don’t use the customization 
choice dialog to deselect ‘sample programs’.  
5) For each  CDS server that is running, truncate the recovery log file with cdsclrlg.exe.   The old log 
files may hold recovery records that are incompatible with the new server.   For each server that is 
not running, delete its old recovery log file, which is usually named ‘cds_log’.
6) On NT, run ‘cdinstsv -all stop’ to stop all old CDS servers, if any,  in the services manager 
database.   This allows cdsv.exe to be replaced, it will not delete your data!! You must logged 
on as a member of the administrators group!   If you are changing MOADIR or 
MOAPROJ, run: ‘cdinstsv –all remove’ instead to remove all of the old CDS entries in the 
services manager database.
7) If you have an existing dictionary from V3, delete all of the related ddtime files 
[\moaproj\*\*cds*\ddtime].  The install puts newly required fields into your data dictionary.
8) If you previously installed so that you have a remove option for this package in My Computer/ 
Control Panel / Add-Remove, run the remove/uninstall to properly decrement the registry 
counts of shared files.   Note that UnInstall is not supported on Windows NT 3.51.
9) If you are running on Window NT 3.51, you may wish to install WordView at this point, to enable 
you to read the CDS documentation, which is in Microsoft Word 6.0/95 format.   The WordView 
package is included on the CD-ROM with the CDS package.  It is not installed automatically.  To 
install WordView: cd \wordview\disk1 and run setup.exe.
10) Install mosaic OA Central Data Server..   On NT you must logged on as a member of the 
administrators group. If you have existing CDS application tables, they will not be changed and 
they will remain accessible.   New entries may be added to the table of tables and the table of 
indexes to accommodate the new ‘fields’ table.   New entries may also be added to the field table 
in your project data dictionary to accommodate the fields table and the ODBC interface.  
   
 From local CD_ROM or network (letter) mapped drive:
a) Run SRVSETUP.BAT to install CDS server package V1.4.5. 
b) If you are installing for emergency journalling on a workstation, use the custom 
installation option and deselect moa Message Switch (moamsw). 
c)    Reboot when prompted to do so to reset application environment variables and to start 
the server(s).
 From remote CD_ROM or unmapped drive:
1) Browse to MOACDSV\disk1\SETUP.exe and run that. 
 
 Windows 95 setup bugs work-around: 
 
1. Make sure DNS has correct IP address for your machine.
2. If DNS is not present or not correctable, update your windows\hosts file. If you have no 
windows\hosts file copy \windows\hosts.sam to \windows\hosts. Then create an entry for your 
machine in the hosts file.
3. Make sure that the new field definitions are in your dictionary with ‘findobj -nYourProject 
common:DomainName’.   You will see “findobj: Can't find object” if the new definitions are 
missing.
4. If you install a second sever process on one machine, be sure to use a non-default UDP port 
address for one of the servers.  The servers won’t work with a shared UDP port number on 
Windows 95.
 
Setup prompts you for the parameters required by CDS.  Use the Help feature of setup if you need more 
information on what to enter for the parameter.

mosaic OA CDS DEINSTALLATION
The following steps must be taken to un-install mosaic OA CDS. None of these work completely.

? On Windows NT 4.0:
? run cdinstsv -all remove
? from Control Panel, run Add/Remove Programs, click on MOA CDSV and remove it.
 
? On Windows 95:
? Bring up each CDSV task from the task bar and stop it by clicking on the X box.
? Bring up the “Startup” window from the task bar and delete all of the entries for CDSV.
? From Control Panel, run Add/Remove Programs, click on “MOA CDSV” and remove it.

? On Windows NT 3.51.   No automatic uninstall is provided but the following steps will undo most of 
the install.   These are hints for knowledgeable, brave administrators.
? run cdinstsv -all remove
? cd    to MOADIR directory
? del *.*
? cd MOAPROJ directory
? del *.*
? This procedure is quite dangerous, should be considered only for Window NT 3.51, and 
is catastrophic if you want only to remove the server package and keep other mosaic OA 
components.   NOT RECOMENDED!
 

MISCELLANEOUS SETUP NOTES
New Fields Required in Dictionary
The setup process adds the new required fields to your dictionary, if they aren’t already there.   You may 
want to update your source for later re-makes of the dictionary.  The new fields source in 
\moa\ibamindd\newflds are:
CdsFldSeq 	INT 4  	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
CdsFldNo 	INT 4  	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
CdsApplNo 	INT 4  	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
CdsApplName ASCII 20  	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsFldName 	ASCII 20  	scdeascurdmpbdh 0 0 0 0 0 0 0
CdsNullOk 	ASCII 1  	SCDEAscurDmpbdh 0 0 0 0 0 0 0
Cds_count  	INT  4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
CdsDefault 	ASCII 32 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsRowVer 	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
CdsLockType ASCII 12 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsUser 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsMachine 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsApp 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
DomainName 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsDomain 	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0 
IndexFilter ASCII 128 	scdeascurdmpbdh 0 0 0 0 0 0 0
CdsScope  	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsDataType	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsTypeName ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
PseudoColumn INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsScale	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsPrecision INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
Cdslength 	INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
Cardinality INT 4 	SCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsPrivilege ASCII 11 	scdeascurdmpbdh 0 0 0 0 0 0 0
CdsGrantable ASCII 3  	scdeascurdmpbdh 0 0 0 0 0 0 0
CdsGrantor 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsGrantee 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsTableType ASCII 12 	scdeascurdmpbdh 0 0 0 0 0 0 0
CdsApp 	ASCII 20 	scdeascurdmpbdh 0 0 0 0 0 0 0 
IPaddress 	SCII 12  	scdeascurdmpbdh 0 0 0 0 0 0 0 
CdsProcess 	INT 4 	sCDEascuRDmpbdh 0 0 0 0 0 0 0
CdsCoordinator ASCII 20 scdeascurdmpbdh 0 0 0 0 0 0 0

In the unlikely event that your application previously defined one of these 
fields with exactly the same name and a different data type or length, you 
must modify your application.  The field flag settings may differ because 
they have no significant effect on the action or performance of CDS.

FILE LOCATION
The set of files required to operate a mosaic OA system do not have to be installed in the root directory.  
The following convention is followed to locate files required by CDS and its associated Console Tools.

When CDSV or any of the Console Tools are invoked the MOADIR user environment or Registry key 
value located at : "HKEY_LOCAL_MACHINE\\SOFTWARE\\Olivetti North America\\mosaic OA”  is 
searched for.  You may set or review the value with the PUTREG.EXE tool.  This defines the directory 
where the “lib” directory is located by various tools and RunTime components.  The “lib” directory 
contains useful include files and error message text files.

To illustrate, when "d:\apps\moa\bin\ql.exe" is executed, the file "d:\apps\moa\lib\err_200" will be used  
for displaying error message #201.

When CDSV or any of the Console Tools are invoked then the MOAPROJECT user environment  
variable or Registry key value is queried to obtain the location of  all mosaic OA project Data 
Dictionaries and sources.  The default location for mosaic OA projects set by the PUTREG.EXE tool is 
“c:\moaproj”.   To configure a project you use the DDINIT.EXE tool to optionally create the project 
directory and its Data Dictionary data files.  The project may be 30 characters long.

There is no default project built-in.  However, a MOACURPROJ user environment or registry key value 
is searched for if a project is not explicitly referenced on the command line.  This registry key value may 
be set by the PUTREG.EXE tool.

We encourage the use of the registry to contain these mosaic OA variable definitions.
INITIALIZATION FILES
The Dictionary “.INI” File
This is a text file which stores information in several sections.  (Refer also to  the section titled mosaic OA 
Initialization File in the mosaic OA RunTime System Reference Manual).   Each section title is enclosed 
in square brackets, in typical windows ".ini" style.  A default copy of this file is generated by 
DDINIT.EXE.  Since it’s a text file, it may be copied from another dictionary and renamed for the target 
dictionary.  Here are some of the sections, along with a description of the information stored in each:
[CDS]
For each cdserver there may be a section in the .ini file.  The section name is: cdsSERVNAME, 
where cds is a constant and SERVNAME is the optional service name suffix of the server, like 
main or cl.
CDS_PRIMARY_NP	The name of the designated primary or only NT machine that 
runs cdserver.   Default is to use UDP broadcast search for the 
server.    The default is usually fine for customer installation 
but it is perilous in a development environment because you 
may randomly connect to someone else’s server with the 
same service name in your LAN.
CDS_SHADOW_NP	Needed only for resilient (UNIX server) systems. The name of 
the designated resilient shadow machine or none. (must be 
lower case ‘none’)
CDS_DIRECTORY	Needed only when cdserver runs on an NT machine and only if 
the default is not taken.  The default is a subdirectory within the 
dictionary directory.
CDS_LOG_PATH	Path to the recover log file.  Needed only when the default 
“cds_log”  is not wanted.  The only reason to set this is to get 
the recovery log on a separate disk drive.
CDS_NWLOG	Optional MCN debug logging mask, for debugging only.
CDS_DEBUGSW	Optional debug logging mask for cdsv.   This is re-read when 
you run cdsstat -D
SYSTEM BACKUP
The backup capabilities provided by Windows NT should be used to create system backups.  No provisions 
are provided by MOA for system backup.   After system backup is complete, run cdsclrlg to truncate 
the recover log file.
Emergency Workstation Server Setup
To ensure that all the required files are installed properly, please run a complete server install for each NT 
workstation that needs the emergency Journalling server,  selecting the ‘COMPACT’ option to avoid 
installing anything undesirable, such as the moa message switch server.   When you see the server 
configuration dialog panel, “CDS Configuration Options”, check the Emergency Server check box.  That 
option directs the setup to copy the required files but to not install any particular server in the service 
manager database of NT or in the START window of Windows 95.   The emergency server is started by 
the application when required.
You can’t directly change an existing server to reconfigure it to be an Emergency Server.  Instead, delete 
the server with cdinstsv remove.   Then run the CDServer Configuration utility to describe a new server, 
using the Emergency Server check-box option.

OUTSTANDING PROBLEMS

When you run a Winsock application (such as CDS or its clients), your Internet provider (such as The 
Microsoft Network) sign-in screen may appear. This behavior occurs when you have a network adapter and 
a modem installed in your computer and the AutoDial feature is enabled
RESOLUTION 

To prevent this behavior from occurring, follow these steps: 
1. Use the right mouse button to click the Internet icon on your desktop, and then click 
Properties on the menu that appears.
2. Click the Use AutoDial check box to clear it. 
3. Click OK. 

When you want Internet access, connect using The Microsoft Network desktop icon or your 
Internet provider icon. 

When upgrading from version 1.3, moa message switch server (moamsw) usually crashes during the install 
process.   If this brings up Dr. Watson, simply clear it and continue.   This is a known bug in version 1.3 of 
moamsw.exe and the install process replaces it with a new version.

QL will not attempt to use the pager, even on ql commands that request the pager.  This is due to a bug in 
Microsoft Visual C++ 4.2 which generally does not properly support the popen function.  Microsoft is 
working on this problem.  We recommend that the ql user resize the command window and use the scroll 
bar until a future release makes the pager again available.

A CDS client cannot access tables created by other clients unless those tables were created before the client 
connected to the database server.  This sometimes gives odd results.  For example: 
	“select prime_key from X “  gives “table X does not exist”
    immediately followed by:
	“create table X (prime_key int primary key)”  gives “Attempt to create duplicate table X”.

Moa Investigator print function fails on Windows NT 4.0.

Documentation about required nightly administration of the CDS server on NT is not clear.


CHANGE LOG
Mosaic OA Central Data Server "Change & Enhancement" Log

Listed below are all changes implemented in version 4.10
of the mosaic OA Central Data Server
&
Console Tools  P/N: 85-35011-D02

Note: These changes are listed in chronological order beginning with the latest changes listed first.

8-4-97 CDSV smatch/rmatch fix (bjo)
? Fixed a problem where the server would crash when trying to compare a non-character field 
with a smatch/rmatch pattern. PTR#: 97070901, Files:optbl.c
8-1-97 CDSV rename table fix (bjo)
? Rename table did not change the internal file name.  This lead to the potential of trying to 
create duplicate file names or worse!  Rename now computes the new internal file name 
based on the new table name.  Files: cdstable.c
7-28-97 CDSV enhancement, misc. fixes (bjo)
? Added the ability to do CDS log recovery to a select set of tables rather than the entire 
database.  This is accomplished by listing the tables to recover in the apply log file.  See the 
CDS notes for more information on this feature. Files: cdsv.c, rollfor.c, rollback.c, cdsinit.c, 
cdslog.c, logread.c – PTR#95111103
? Fixed a recently introduced problem where CDS would not properly recover a replace with 
index change. Rollfor.c
? Fixed a problem where CDS would not process rollbacks during recovery. Rollback.c
? Fixed a problem where CDS would complain of a bad log when applying a log that contained 
create table commands. Logread.c
 7-18-97 CDSV.exe Fix (s)
? Fixed bug which caused a NOT match operation to become a MATCH operation when the 
pattern was a simple string with no pattern characters.
7-8-97 moa\src\MAKEFILE change (s)
? Removed CDS package specific makes and moved them to MakeCDS  to avoid getting the 
wrong part numbers.
 6-26-97 CDSV minor fixes/enhancements (bjo)
? out file now contains explicit message when NT application event log is full. File: cdsfatal.c
? Fixed an obscure problem that could cause a cds 1855 error.  Problem would happen when 
RT has an empty FIXED field (defined with no decimal places – eg: 5.0), increments the field 
by 0.5, and attempts to insert it into CDS. File: tablist.c, PTR# 96050601
 6-25-97 CDS client change (s)
? cds_udp_port() now returns a negative if it fails rather than calling an exit function (ersysn()).  
So now calling programs should check for an error and handle it.  The function 
cds_udp_port() is exposed in cdscl.dll.
 6-25-97 CDS install fix (s)
? Close the program group window before finishing so it won't obscure the completion 
message.
 
 6-24-97 CDS and CDSODBC R1V4 Checkpoint 9 Complete	
6-20-97 CDS install fix (s)
? Run Drop-1A.exe on NT machines to get rid of control-Z characters at the end of \etc\services 
before running svrcfg.exe to update that file.
6-20-97 CDS fix for more recovery problems (s)
? Don't crash rolling forward a drop table when the table to be dropped already doesn’t exist.
? Allow three days of out file instead of only two before discarding it on open.
6-16-97 CDS fix for duplicate record problem (bjo)
? Fixed a problem where CDServer could create duplicate records in the database.  The 
specific problem occurred when CDS recovered after a record replace followed by a replace 
with index change on the same record.  CDS compression can be used to remove the 
duplicate records after the index is rebuilt.  PTR# 97052901, files: rollfor.c
6-11-97 SVRCFG (CDS configurator) Fixes (s)
? Fixed problems dealing with service name suffixes
? Use lower case for CDS section names in ddproj.ini
6-6-97 QL.exe Fix (s)
? Allow the date value "0" for backward compatibility.
6-05-97 CDS Fix (bjo)
? Fixed a problem in CDS where CDS would terminate with an out file message: Caught signal 
21 and Terminated by signal 21.  This problem was related to a user signing off of the server 
sometime after compression was run.  PTR# 97060402.  Files: cdscmprs.c
5-28-97 CDS Fixes (s)
? Fixed problem that caused crash in cdsv.exe when project name was longer than 30 
characters.
? Changed package to not install msvcrt40.dll, to avoid problems on Win95.
? Fixed bugs in svrcfg.exe and svrcfgh.dll, the CDS configuration utility.  Made enhancements 
suggested by John Lowry:
? Provide a pick list for project name, based on subdirectories of MOAPROJDIR.
? Hide advanced options unless called for by the user.
? Show previously configured advanced options when reconfiguring a server.
? Fix bugs in showing previously configured UDP port number.
5-15-97 CDS & RT header modules (s)
? Removed cds_errno from rtdef.h.  It is no longer exported.  Use clenv.h instead.
? Removed cds_errno as an export from cdserror.h.   It is no longer exported, as of checkpoint 
8.
? There is a new function, CdsErrNo(clenv *env), exported by cdscl.dll, which returns the 
cds_errno value for an environment.
V1.4.7 here
4-7-97 CDS Table Rename When Using Multiple CDServers (bjo)
? When renaming a table while connecting to multiple CDServers, a duplicate table error would 
be reported if the new table name existed on ANY of the CDServers.  Changed so that the 
name only has to be unique on the server with the table that is being renamed.  File: clstubs.c

4-7-97 QL.EXE Data Length Validation (bjo)
? ql has been changed to validate the length of data being inserted into CDS.  The default 
action for data larger than the defined field size is to report an error.  Optionally, ql can be set 
to truncate the excess data or to ignore the length validation and allow the data into CDS. 
Files changed: ql.h, ql.c, qldml.c, qlaux.c.  PTR# 97030504 
? Minor change to allow specific index to be displayed on table using named service 
specification (show indexes on service:table).  Files: ql.c, PTR#: 97032401
04-02-97 CDSV change (s)
? Create a debug map from the link of cdsv.exe and put it in the distribution.
3-21-97 CDS Enhancement (s)
? When cdsv is started from the command line it shows a minimized window only unless the 
command line option –W is used.  This addresses PSR# 3968.
3-20-97 CDS prcapture bug fixes (s)
? Fixed print of statistics evoked by the –s command line option by using vsprintf() instead of 
wvsprintf() in misc\hexdmp.c.   Only vsprintf() supports the %f format.
? Get ticks per second from capture file, if available, so prcapture can accurately show the time 
used per function at the original server machine.
3-18-97 CDS Enhancement (s)
? Added LIST option to cdinstsv.exe.  This is an abbreviated list of the VIEW info plus showing 
the UDP port number used. 
3-17-97 CDS Setup Fixes (s)
? Changed svrcfg.exe and svrcfgh.dll to accept only a full path for the cds recovery log file.   
This fixes PSR 4000.   The program now tries to show the option previously chosen when re-
configuring.
? Changed svrcfg.exe handling of UDP port numbers so that the existing previously configured 
port number for a server is preserved unless explicitly overridden by the developer.
? Changed svrcfg.exe handling of UDP port numbers so that if a user specifies an existing 
previously configured port number for a different server, that user gets a warning message 
and a chance to reconsider the port number.  This fixes PSR #4005.
? Changed svrcfg.exe to insist on a valid project name.  This fixes PSR #4037.

3-17-97 CDS ODBC Enhancement (s)
? Added support for SQL ALTER TABLE statement to allow developers to add or drop column 
definitions for a table.
? ALTER TABLE with ADD column is now supported for variable schema tables to allow use 
with third party reporting tools like Crystal Reports and MS Access.
3-12-97 cdsstat.exe Enhancement (s)
? Added option “–C” to show count of current connections.
3-12-97 ql.exe Enhancement (s)
? Added SLEEP verb for use in testing scripts.
3-12-97 Osql.exe Enhancement (s)
? Added SLEEP verb for use in testing scripts.
3-12-97 ODB.DLL Fix (s)
? Fix bugs in setting column precision, especially for timestamp data.
? Added to dberrs.h #define MOA_PUT_EMPTY_STRING_AS_NULL 2202, option ID for 
DBsetConnectOption().

3-10-97 Osql.exe  changes (s)
? Allow semi-colon at end of tables, sqltables, and types requests.
? Honor 'commit', 'rollback' and 'begin work' requests.
3-5-97 CDSV Running as Service Fix (bjo)
? Fixed a problem where CDSV would fail to run as a service, reporting event information 
related to a different project than expected for the service.  PTR 97012302, Files: cdsv.c, 
start.c
03-05-97 CDSODBC.dll - Enhancement (s)
? Added support for inserting mulitple records, using bound parameter arrays.
? Added support for ODBC API function SQLParamOptions() as a part of the array insert 
support.
03-04-97 ODB.dll - Enhancement (s)
? New client side option MOA_PUT_EMPTY_STRING_AS_NULL for DBsetConnectOption().  
The default is FALSE, meaning FT_ASCII fields with empty string values are set to the 
database as a zero length string.  The trouble with this is that SQL-Server silently converts 
empty strings to single character blank strings.
02-28-97 CDS import and export fix/enhancement (bjo)
? Modified cdsimprt and cdsexprt to support connection to multiple servers.  See cds notes for 
more details on this feature.
? Added -T switch to cdsimprt to allow truncation of ascii and numeric data that exceeds 
defined field size.
? Made cdsexprt and cdsimprt compatible with previous versions.  Old export files can be 
imported on current version and export files from current version can be imported on older 
versions.  Files: imexport.h, cdsimprt.c, cdsexprt.c.  For PTRs: 97022703, 97022704, 
97020501, 97012902.
02-28-97 CDS setup bug fixes (s)
? Changed cdinstsv.exe to prevent install when MOAPROJDIR is a remote drive or a RAM 
drive.
? Changed cdsv.exe to prevent logging of superfluous start and stop events.  In particular 
“StartServiceCtrlDispatcher failed” information is no longer written.  It wasn’t helpful.
02-27-97 CDS bug fixes (s)
? Postpone checking for server running on designated machine to allow a mix of machine for 
different service name suffixes with the same dictionary.
? Fixed bug that caused crash in CDS ODBC driver when selecting with a very long projection 
list.
02-27-97 CDS ODBC Enhancements (s)
? Allow smalldatetype as a column data-type, meaning DATE
? Allow column definition option of NULL, which the default, meaning ‘allow null value’.
? support error SQLState 21S01 when insert values list doesn’t match the column list.
? Give a more explicit error message when user tries to update current of cursor when that 
cursor was not defined with a FOR UPDATE clause in the select statement.
02-27-97 CDS prcaptur.exe bug fix (s)
? Fixed bug that caused failure when -S option was used in the command line.
02-25-97 CDS bug fixes (s)
? Use exclusive record update locks on ODBC fetches when reading on an updatable context 
within a LUW, when the SQL_TXN_ISOLATION option is SQL_TXN_READ_COMMITTED 
(the default) or higher.
? Use exclusive lock inside the server when reading for Update_All() and currently in a LUW 
and current connection option for concurrency is SQL_TXN_READ_COMMITTED.  That 
option setting is the default for users of the CDS ODBC driver.   Users of the old interface 
may set that option too, via SetConnectOption(), but their default is 
SQL_TXN_READ_UNCOMMITTED.
? Wrap the update in a LUW whenever not already in a LUW and the update is a 
Cds_Update_All() that could affect more than one record.
? Set proper SQLState for bad option ID and bad option parm value for SQLSetConnectOption.
? Make sure that SQL_TXN_ISOLATION option default value at the server is 
SQL_TXN_READ_COMMITTED.   (For ODBC clients only).
? Added support for updating a column  to NULL value from ODBC.
? Return correct SQLState when given a bad table name on an ODBC INSERT statement.
? Return correct SQLState when given a bad primary key for an insert or a bad secondary key 
for any update.
02-24-97 CDS QL bug fix (s)
? Adjust at run time to not use batch insert on insert from select when the server can’t handle it.
02-21-97 CDS crash on find_n (bjo)
? Fixed a problem where CDS could crash on find_n if a previous find_n on the same context 
failed for some reason.  The example used to produce the failure was encountering an 
exclusive locked record. Files changed: cdsfind.c. PTR #97021301
02-21-97 CDS bug fix (s)
? Fixed bug that prevented the closing of a pseudo-connection created during restart general 
recovery for rollback of an incomplete LUW.   Changed only ccb.c.
02-14-97 CDS Enhancements (s)
? Requests for EXCLUSIVE record locks are silently downgraded to 
simple update locks when the lock requests are outside of a Logical 
Unit of Work.
? CDS ODBC SQL now supports insert from a query spec as well as from a values list.
02-13-97 CDS Enhancements (s)
? Ordinal numbers in SQL ‘ORDER BY’ clauses are now supported.  The ordinal number must 
refer to a column in the projection list.
02-11-97 CDS Enhancements (s)
? Added batch insert function to client and server.
? Changed QL to use batch insert when inserting from a selected context.
? Changed CDSODBC driver to use batch insert for every insert.  The normal batch size is one.  
The batch may contain as many records as will fit in one 64K buffer.
? Allow multiple VALUES lists on an SQL insert statement to create multiple rows with one 
statement.
? Allow TEXT as a data type specifier in a create table statement.
? Allow user to use dictionary fields from up to 7 different dictionary applications, within a single 
SQL statement, such as CREATE TABLE.
02-06-97 CDSODBC.dll bug fixes (s)
? Added multi-thread support.   The driver is now ‘thread safe’.  Fixes PSR 4011.
? Detect and report invalid date literals in SQL ‘where’ clauses.
? Cleanup up some other error reporting to return the correct SQLState.
? Change parser to allow table_name.index name in DROP INDEX table_name.index_name.
01-31-97 CDS Two-Phase Commit Fixes (bjo)
? Made fixes necessary for NT CDServer to pass the two-phase commit tests in the CDS 
regression test suite.  Prior to these changes, CDS would fail on all two phase commit or 
rollback attempts.  Changed both CDS and RT. Files: clstubs.c, cmfparms.c, cdslog.c, cds.c, 
ccb.c, svdofunc.c, svsvproc.h, svinit.c, svunpack.c, servnt.c, server.c, svsetup.c.  PTR 
96112001, 97011401.
01-31-97 CDS 873 Causes RT to Crash (bjo)
? Changed RT to not catastrophe on CDS 873 errors.  Application is now responsible for 
checking for such errors and taking appropriate action.  File: execcds.c, clstusbs.c.  PTR 
96120601
01-31-97 CDSODBC.dll bug fixes (s)
? Added function SQLNativeSql().  If the parser likes a statement it will return it via 
SQLNativeSql.   You still can’t see what goes to server execept through prcaptur.exe.
? Changed parser to recognize GRANT statements.  Nothing is done with them but now scripts 
with GRANTs in them can be executed without error.
01-30-97 CDSODBC.dll bug fixes (s)
? don't release the context created for an insert and don't create a new CDS context when the 
existing stmt->contxt will work for an insert.  This speeds performance on insert.
? Announce that only one connection per user is allowed via 
SQLGetInfo(SQL_ACTIVE_CONNECTIONS).
01-28-97 LOGDUMP utility fix (bjo)
? The CDS logdump utility would crash or report incorrect information when processing some 2-
phase commit log records.  It now reports those records properly.
01-28-97 RT - do not catastrophe on CDS 873 errors (bjo)
? Changed RT to not catastrophe on CDS 873 (CDS_NOT_IN_LUW) errors.  Any application 
request for rollback will result in a rollback at all the CDServers that the client is connected to.  
The application is responsible for taking the proper action when a rollback occurs.
01-28-97 ODB.dll - Fix DBbegin() to work with the above fix for LUWs. (s)
? Changed DBbegin to work with new cdscl.dll changed in clstubs.c Cds_Rollback().
01-28-97 CDSV.exe bug fixes (s)
? Fixed bug in displaying debug stuff before connect->ftab was setup.
? Fixed bug of incorrectly returning a value from a no_ret function.
01-28-97 CDSODBC.dll bug fixes (s)
? Fixed bugs in parsing and handling hexadecimal (bulk) constants.
01-27-97 CDSV.exe bug fixes (s)
? stop ignoring lengths in comparison of two bulk values.
01-22-97 mi.exe bug fixes (s)
? Fixed bug that caused mi to crash on an assert in _spawnl() when attempting to run 
udpinfo.exe.
? Fixed bug that caused mi to not find udpinfo.exe when run from a directory where udpinfo.exe 
did not reside.    [both changes to module network.cpp only]
01-20-97 CDSV.exe bug fixes (s)
? Fixed bugs in handling next fetch on a cursor after an update that changed the key of the 
current record for the index used for the cursor.
01-15-97 QL.exe (s)
? Fixed bug inserting from one table to another that cause creation of a context name that was 
too long.
1-14-97 CBS.exe (s)
? Added and extra 3 bytes for each FT_FIXED decimal field.
01-06-97 CDSV.exe fixes   (s)
? Allow an 8 character suffix name with a 30 character project name.   Previous version allowed 
only a total of 34 characters.  Now allow a total of 58 characters.  Published, supported limit is 
30 + 8.
? Use a case insensitive name search when looking for duplicate table names.  Names weren’t 
truly case insensitive since we moved to NT from unix.
12-20-96 CDSV setup fixes and enhancements (s)
? Added an empty wrdview6.opt to the distribution to improve the uninstall.
? Changed to not allow selection of moa message switch on win95.
? Use c:\temp, if it exists, as the working directory for moa investigator, to receive mi.log files.
V1.4.4 checkpoint made here.
12-18-96 CDSV setup fixes and enhancements (s)
? Fixed bug in svrcfg.exe that prevented upgrade of dictionary field tables with ‘newflds’ file.
? Fixed bug in svrcfg.exe that stopped the moa message switch server.
12-09-96 CDSV Install fixes and enhancements (s)
? Fixed binary version number info in all programs.
? Fixed rcbump to correctly set the binary version number in _v.rc files.
? Fixed svrcfg.exe to work correctly with Windows 95.  
11-30-96 CDSreasn.exe bug fix (s)
? Fixed bug preventing print of last line in a segment of the out file.
11-27-96 MKdist.mak ported to msvc 4. (s)
11-27-96 setup.mak  files ported to msvc 4. (s)
? moasetup.mak  and moved files from setupcmn to moasetup directory.
? svrcfgh.mak
? svrcfg.amk
? ssetuph.mak
? ssetup.mak
11-15-96 QL - disabled pager while popen broke in Visual C 4.2 (bjo)
? QL will not attempt to use the pager, even on ql commands that request the pager.  This is 
due to a problem in VC 4.2 that generally does not properly support the popen command.  
Microsoft is working on this problem.  Recommend that the ql user resize the command 
window and use the scroll bar until the pager is again available. Changed ql.h, ql.c, qldml.c, 
and qlaux.c.
11-09-96 CDS bug fixes (s)
? Terminate the heartbeat thread during MCNClose() if there are no more active connections.
? Deregister the class used for the private window in all clients but rt.
11-04-96 CDS bug fixes (s)
? Fixed a V4 bug in cdsv.exe that caused the server to crash (unrecoverably!) during some 
node merges and some node split recovery logging.   The changed touched cbtree.h, 
cbtree.lib and cdscl.dll as well as cdsv.exe.
? Fixed a V4 bug in QL.exe that caused it to load incorrectly rotated values from ascii source for 
FT_IND fields.
11-04-96 CDSexprt changes (s)
? More descriptive and informative messages about failures, especially FT_IND translation 
failures.
? Give a second chance on FT_IND translation failures, rotating the integer value before the 
second try.
11-01-96 CDS changes (s)
? Changed cdsnight.cmd to include an option for an rdate server.
? Changed cdsnight.cmd to use long enough sleep periods to allow the services manager to 
flush out its time-out queues before restarting or stopping cdsv.
? Fixed bug in cdsrtest.ksh to remove a dependency on the location of MOAPROJ.
? Added MFC42d.DLL to distribution for use by mi.exe.
10-21-96 CDS fixes (s)
? Fixed bug in handling superfluous table name qualifiers in selection criteria.  Example: select 
from TEST where TEST.common:mycolumn < 12.   In previous versions, table name 
qualifiers on column references were allowed only in join selection criteria.
? Changed is_null and is_not_null to single operand operators, binding left.  Retained 
is_missing as allowing and sometimes requiring two operands, with the second operand 
being a meaningless placeholder.
10-14-96 CDS enhancements and fixes (s)
? Enable a client to think it has multiple connections to a single server at one push level.  - 
Added a use count for each connect.
? Enable a single client to connect to servers with different interface levels.
? Fixed a bug in prcapture’s display of zero length decimal values.
? Fixed a bug in prcapture’s display of hexadecimal (bulk) values, so that extra blank lines are 
not printed.
? New function clFreeEnv() destroys environment object created by clAllocEnv().
10-01-96 CDS fix (s)
? Added optional ANSI-SQL cursor fetch behavior.
? New, more flexible and backward compatible interface specification for client/server functions.
? Removed cdsv global variable This_connect.  It is now passed as a parameter where needed.
? Added two new functions to listmgr.c to reduce the need for malloc() and free() of list heads.

09-26-96 CDS fix (s)
? Slightly better handling of the Event Log.  Almost all messages are now message #1, which is not 
optimal.   The event source and message types are not “unknown” anymore.
? Cdsv.exe automatically sets up the application event log registry values that are required.
? The superfluous “Going down at hh:mm:ss message is no longer appended to the event log.
09-25-96 CDS fix (bjo)
? There was a problem dealing with corrupt indexes.  If the tempdir was null, CDS would attempt to 
move the corrupt index onto itself.  Now the corrupt index will always have a suffix of id-, rather than 
idx.
09-16-96 CDS fix (s)
? Fixed cdinstsv to allow starting servers that are not for MOACURPROJ project by properly 
getting service registry parameters.
 
? Enhanced cdsv.exe to halt with a message during initialization  when the tables directory is 
remotely mounted.
09-15-96 CDS fix (s)
? Don’t post a NOT_RUN after killing a server because there is already a server running on the 
same directory.   Followed Bruce Oscarson’s code for R1V2.
09-13-96 CDS enhancement (s)
? Added more fields used by cdsv to the minimum dictionary in \moa\ibamindd.
? Extended the newflds file use for upgrading to the V1.4 CDS.
09-11-96 CDS tcl makefile  fixes (s)
? Changed all executables to use resource for version info and to use cdscl.dll for smaller 
footprint. 
? Changed to compile and link with MSVC++ 4.2.   Includes changes to DLLs. 
09-08-96 CDS fixes (s)
? Support hexadecimal constants in ASCII where clause criteria.
? zero length is same as NULL_VALUE for FT_BULK, FT_DATE, and FT_IND fields.
? Fixed bug in comparison of two FT_IND values.
? Fixed bug in support of “not null” and “null Ok” in table definitions.   The bug appeared during 
insert and update.
? Support window handle in cds environment control block on clients.  This allows the CDS 
processing to use a different window than other parts of a process.   Global window handles 
are no longer used.
? Don’t raise an error when a client closes a context that has no remote (server-side) pointer.
? Fixed bug in use of hexdmp() when printing a cds record for debugging.
09-02-96 CDS fix (s)
? Fixed bugs in logdump.exe that caused crashes when trying to print database record 
contents.   Now using WriteFile() instead of printf().
08-29-96 CDS log timer (bjo)
? Increased the maximum time allowed for the logging thread to complete a log write from 3 
seconds to 10.  In some extreme cases, 3 was not enough, and when this timer expires, CDS 
fails hard (NOT_RUN). 
08-23-96 CDS client bug fix (s)
? Fix bug of rotating table buffer size on client side for newly created tables.   Size was wrong 
only on client side and only for the task that created the table.
08-05-96 CDS client change (bjo)
? Change in client to eliminate possibility of CDS connect request looping when we get an 
unexpected error code from MCNConnectService.
08-01-96 CDSimport enhancement (bjo)
? Added support for conversion from ASCII to NUMERIC during import.
07-21-96 CDS  changes (s)
? Fixed usage statement response to cdsclrlg -U.
? Added new messages to err_5200 about the new ‘fields’ table.
? Added MSVCR40D.dll to cdsodbc setup.
? Added prevention of direct update of the fields meta-table.
? changed cdinstsv, cdsreasn, and prcaptur to use resource for version info.
06-26-96 CDS  changes (s)
? Increased maximum index trees per table from 20 to 30 on the NT version.
06-25-96 CDSV.EXE changes (s)
? Added File Manager visible version resource.
06-25-96 CDS NOTES
? Changed name of manual from CDS NOTES to “CDS Programmer’s Reference”, as 
requested by Q/A to avoid confusion with the release notes document.
06-13-96 CDS Setup fixes (s)
? Added msvc40d.dll to moasrvr.fil because putreg.exe uses it.   The install puts it in \moa\bin.  
It ordinarily resides in \winnt35\system32.
? Deleted superfluous include files from moasrvr.fil.
? Added cdscl.dll to moasrvr.fil.
? Added new fields to ibamindd\fld file and DDOBJ.*
? CdsFldSeq INT 4 [ ] SCDEascuRDmpbdh 0 0 0 0 0 0 0 
? CdsFldNo INT 4 [ ] SCDEascuRDmpbdh 0 0 0 0 0 0 0 
? CdsApplNo INT 4 [ ] SCDEascuRDmpbdh 0 0 0 0 0 0 0 
? CdsApplName ASCII 20 [ ] scdeascurdmpbdh 0 0 0 0 0 0 0 
? CdsFldName ASCII 20 [ ] scdeascurdmpbdh 0 0 0 0 0 0 0
? CdsNullOk ASCII 1 [ ] SCDEAscurDmpbdh 0 0 0 0 0 0 0
06-05-96 CDSCL.DLL changes (s)
? Fixed bug in rollback of deletes, as per Bruce Oscarson in R1V3.  This bug caused server to 
crash during rollback and recovery.
? Fix reentrancy problem in debugging code.  This made it possible to use cdscl.lib for 
prcaptur.exe.
04-23-96 CDSV.exe Enhancements  (s)
? Added comparators like, not_like, and is_not_null to PQL for support of ODBC interface.   
These comparators are usable through the ASCII interface only (not from OFB).
04-23-96 CDSSTAT.exe Enhancement   (s)
? Added -D command line option to tell cdsv to reset debugsw and mcn tracing from ddproj.ini 
values for CDS_DEBUGSW and CDS_NWLIB.
? Changed usage statement for cdsstat in \moa\lib\err_5800.
04-18-96 CDSV Enhancements (s)
? Added more information to messages about failures of recovery during rollforward from the 
recover log.   Put more into the event log message to compensate for not having a core 
dump.   Updated \moa\lib\err_5800 and cds\rollfor.c
? Improved response to shutdown requests.  Don’t open a new listen if Sv_running = False. 
changes in servnt.c.
? Got rid of DNIX code in ccb.c
04-04-96 CDSV Enhancements (s)
? Enhanced the optimizer to recognize comparisons to empty string values for fields in indexes.  
Always read the minimum or zero index and base records.
? Enhanced the optimizer to recognize IS_MISSING criteria for fields in indexes.
? Added more explanation of the optimizer’s index choices when the -E option is used
? Added printing of number of index and base records read when the Explanation level option is 
relevant and set non-zero.   See CDSNOTES.doc.
? Increased the maximum number of variables in a criteria expression from 100 to 255.
1-19-96 CDS clients enhancement (CDSCL.DLL) (s)
? Created new dynamic link library, cdscl.dll for all cds clients except rt.  New subdirectory 
\moa\src\cdscl, new src\cdscl.mak.

13
08/13/97
