# Windows-process-comparison
## Identify Maliciouse processes
This script will hepl to indetify abnormale processus by listing running processus with tasklist, then compare the result with a list of Windows legitime processes in order to extract the non-Windows processus
### Raw processes list file
```bash
CommandLine=
Description=csrss.exe
Handle=512
HandleCount=798
Name=csrss.exe
ProcessId=512
ThreadCount=11


CommandLine=
Description=wininit.exe
Handle=612
HandleCount=173
Name=wininit.exe
ProcessId=612
ThreadCount=1


CommandLine=
Description=services.exe
Handle=764
HandleCount=768
Name=services.exe
ProcessId=764
ThreadCount=7


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


CommandLine="fontdrvhost.exe"
Description=fontdrvhost.exe
Handle=924
HandleCount=37
Name=fontdrvhost.exe
ProcessId=924
ThreadCount=5


CommandLine="C:\Windows\System32\WUDFHost.exe" -HostGUID:{193a1820-d9ac-4997-8c55-be817523f6aa} -IoEventPortName:\UMDFCommunicationPorts\WUDF\HostProcess-7b6799fc-be30-456e-9a30-786a4e02e1fd -SystemEventPortName:\UMDFCommunicationPorts\WUDF\HostProcess-e31f6273-799a-448c-85dc-0c9480e3dac3 -IoCancelEventPortName:\UMDFCommunicationPorts\WUDF\HostProcess-fc8c23f0-a0ac-4474-8875-72122a72e16e -NonStateChangingEventPortName:\UMDFCommunicationPorts\WUDF\HostProcess-a097b075-0598-4a47-a8cd-2bfe2f9f6110 -LifetimeId:559ca1bd-7c97-4b63-89f8-48b126842a94 -DeviceGroupId:ViddGroup -HostArg:0
Description=WUDFHost.exe
Handle=996
HandleCount=247
Name=WUDFHost.exe
ProcessId=996
ThreadCount=6


CommandLine=C:\WINDOWS\system32\svchost.exe -k RPCSS -p
Description=svchost.exe
Handle=656
HandleCount=1597
Name=svchost.exe
ProcessId=656
ThreadCount=11


CommandLine=C:\WINDOWS\system32\svchost.exe -k DcomLaunch -p -s LSM
Description=svchost.exe
Handle=796
HandleCount=377
Name=svchost.exe
ProcessId=796
ThreadCount=7


CommandLine=C:\WINDOWS\system32\svchost.exe -k LocalServiceNoNetwork -p
Description=svchost.exe
Handle=1212
HandleCount=180
Name=svchost.exe
ProcessId=1212
ThreadCount=2
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
