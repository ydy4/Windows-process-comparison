# Windows-process-comparison
## Indetify Maliciouse processes
This script will hepl to indetify abnormale processus by listing running processus with tasklist, then compare the result with a list of Windows legitime processes in order to extract the non-Windows processus
### Raw text file
```bash
CommandLine=C:\WINDOWS\system32\lsass.exe
Description=lsass.exe
Handle=784
HandleCount=1775
Name=lsass.exe
ProcessId=784
ThreadCount=12


CommandLine=C:\WINDOWS\system32\svchost.exe -k DcomLaunch -p
Description=svchost.exe
Handle=896
HandleCount=1623
Name=svchost.exe
ProcessId=896
ThreadCount=14
```

We use this powershell script to remove unwanted line and export only lines which stat with "Name=":

```bash
get-content .\process.txt -ReadCount 1000 |

foreach { $_ -match "Name=" } | sort | get-unique > fetched_processes.txt
```
Now that we have fetched the first file, we could compare it with our Windows_Legitime_Processes file.
```bash
diff (cat .\fetched_processes.txt) (cat .\processes_windows.txt) > abnormale.txt
```
Take a look at the suspicious processes
```bash
PS C:\Traces> type .\abnormale.txt                                                                                                                         
Name=aitagent.exe                                                                                                                    
Name=AtBroker.exe                                                                                                                    
Name=autochk.exe                                                                                                                     
Name=BESClient.exe                                                                                                                   
Name=bzip2.exe                                                                                                                       
Name=CleanupWindowsDefenderTasks.exe                                                                                                 
Name=CompatTelRunner.exe                                                                                                             
Name=comreg.exe                                                                                                                      
Name=consent.exe                                                                                                                     
Name=cpuid.exe                                                                                                                       
Name=cscript.exe 
```
### FYI
the text file windows_processes.txt can be customized depending on you environement, you can add processes that you trust in the file in order to ignore then while investigating unless if you are hunting **process injections**
