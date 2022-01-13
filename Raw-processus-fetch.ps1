get-content .\process.txt -ReadCount 1000 |
foreach { $_ -match "Name=" } | sort | get-unique > fetched_processes.txt
diff (cat .\fetched_processes.txt) (cat .\processes_windows.txt) > abnormale.txt