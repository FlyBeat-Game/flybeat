# include <stdio.h>
# include <stdlib.h>
# include <windows.h>
# define BUFSIZE 4096

HANDLE g_hChildStd_IN_Rd = NULL;
HANDLE g_hChildStd_IN_Wr = NULL;
HANDLE g_hChildStd_OUT_Rd = NULL;
HANDLE g_hChildStd_OUT_Wr = NULL;

PROCESS_INFORMATION launch(const char* path){
	STARTUPINFO si;     
   	PROCESS_INFORMATION pi;
   	si.hStdError = g_hChildStd_OUT_Wr;
   	si.hStdOutput = g_hChildStd_OUT_Wr;

   	ZeroMemory(&si, sizeof(si));
   	si.cb = sizeof(si);
   	ZeroMemory(&pi, sizeof(pi));

	CreateProcess(path,
		NULL,        // Command line
	    NULL,           // Process handle not inheritable
	    NULL,           // Thread handle not inheritable
	    FALSE,          // Set handle inheritance to FALSE
	    CREATE_NEW_CONSOLE,              // No creation flags
	    NULL,           // Use parent's environment block
	    NULL,           // Use parent's starting directory 
	    &si,            // Pointer to STARTUPINFO structure
	    &pi );           // Pointer to PROCESS_INFORMATION structure

	CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
}

void CreateChildProcess(const char* path) { 
   TCHAR szCmdline[]=TEXT("child");
   PROCESS_INFORMATION piProcInfo; 
   STARTUPINFO siStartInfo;
   BOOL bSuccess = FALSE; 
 
   ZeroMemory( &piProcInfo, sizeof(PROCESS_INFORMATION) );

   ZeroMemory( &siStartInfo, sizeof(STARTUPINFO) );
   siStartInfo.cb = sizeof(STARTUPINFO); 
   siStartInfo.hStdError = g_hChildStd_OUT_Wr;
   siStartInfo.hStdOutput = g_hChildStd_OUT_Wr;
   siStartInfo.hStdInput = g_hChildStd_IN_Rd;
   siStartInfo.dwFlags |= STARTF_USESTDHANDLES;
 
    
   bSuccess = CreateProcess(path, 
      szCmdline,     // command line 
      NULL,          // process security attributes 
      NULL,          // primary thread security attributes 
      TRUE,          // handles are inherited 
      CREATE_NEW_CONSOLE,             // creation flags 
      NULL,          // use parent's environment 
      NULL,          // use parent's current directory 
      &siStartInfo,  // STARTUPINFO pointer 
      &piProcInfo);  // receives PROCESS_INFORMATION 
   
   if (!bSuccess) 
      return;
   else {
      CloseHandle(piProcInfo.hProcess);
      CloseHandle(piProcInfo.hThread);
   }
}

void ReadFromPipe(void) { 
   DWORD dwRead, dwWritten; 
   CHAR chBuf[BUFSIZE]; 
   BOOL bSuccess = FALSE;
   HANDLE hParentStdOut = GetStdHandle(STD_OUTPUT_HANDLE);

   for (;;){
      bSuccess = ReadFile( g_hChildStd_OUT_Rd, chBuf, BUFSIZE, &dwRead, NULL);
      if( ! bSuccess || dwRead == 0 ) break;

      //server started message
      break;

      bSuccess = WriteFile(hParentStdOut, chBuf, 
                           dwRead, &dwWritten, NULL);
      if (! bSuccess ) break; 
   } 
}

int main(){
	SECURITY_ATTRIBUTES saAttr;
	saAttr.nLength = sizeof(SECURITY_ATTRIBUTES); 
   	saAttr.bInheritHandle = TRUE; 
   	saAttr.lpSecurityDescriptor = NULL;

	//STDOUT
	if (!CreatePipe(&g_hChildStd_OUT_Rd, &g_hChildStd_OUT_Wr, &saAttr, 0)) 
      return 1;

  	if (!SetHandleInformation(g_hChildStd_OUT_Rd, HANDLE_FLAG_INHERIT, 0))
      return 1;
  	
	ShowWindow(GetConsoleWindow(), SW_HIDE);
	CreateChildProcess("Data\\FlybeatMatlabModule.exe");
	ReadFromPipe();

	system("Data\\FlyBeat.exe");
	system("TASKKILL -IM FlybeatMatlabModule.exe -f");
	return 0;
}
