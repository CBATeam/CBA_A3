// PabstMirror
// Polls joystick for button presses, sends to CBA as a mission extCallback

#include <windows.h>
#pragma comment(lib, "winmm.lib")
#include <iostream>
#include <thread>
#include <chrono>
#include <bitset>
#include <sstream>
#include <functional>

constexpr auto VERSION_STR = "v0.0.1";


extern "C" {
    __declspec(dllexport) void __stdcall RVExtension(char* output, int outputSize, const char* function);
    __declspec(dllexport) void __stdcall RVExtensionVersion(char* output, int outputSize);
    __declspec (dllexport) void __stdcall RVExtensionRegisterCallback(int(*callbackProc)(char const* name, char const* function, char const* data));
}

void watchJoystick();
std::thread watcher(watchJoystick);

// Get callback pointer
std::function<int(char const*, char const*, char const*)> callbackPtr = [](char const*, char const*, char const*) { return -2; };
void __stdcall RVExtensionRegisterCallback(int(*callbackProc)(char const* name, char const* function, char const* data)) {
    callbackPtr = callbackProc;
}

void sendKeyEvent(unsigned int buttonID, bool pushed) {
	std::stringstream ss;
	ss << "[" << buttonID << "," << (pushed ? "true":"false") << "]";

	bool callback_recieved = false; // call back buffer can only hold 100 messages a frame (doubt will ever hit this limit)
	while (!callback_recieved) {
		int callback_buffer_remaining = callbackPtr("CBAX_joyButton", ss.str().c_str(), "");
		if (callback_buffer_remaining > -1) {
			callback_recieved = true;
		} else {
			std::this_thread::sleep_for(std::chrono::milliseconds(1));
		}
	}
}

void handleButtonChange(DWORD on, DWORD nn) {
	std::bitset<32> ob(on);
	std::bitset<32> nb(nn);
	for (unsigned int i=0; i < 32; i++) {
		if (ob[i] != nb[i]) {
			sendKeyEvent(i, nb[i]);
		}
	}
}

void watchJoystick() {
	UINT joystickId = JOYSTICKID1;
	MMRESULT errorCode;
	JOYINFOEX joystickInfo;
	DWORD lastButtonState = 0;
	while (true) {
		errorCode = joyGetPosEx(joystickId, &joystickInfo);
		if (!errorCode) {
			if (joystickInfo.dwButtons != lastButtonState) {
				handleButtonChange(lastButtonState, joystickInfo.dwButtons);
				lastButtonState = joystickInfo.dwButtons;
			}
			std::this_thread::sleep_for(std::chrono::milliseconds(10));
		} else {
			std::this_thread::sleep_for(std::chrono::milliseconds(5000));
		}
	}
}

void __stdcall RVExtensionVersion(char* output, int outputSize) {
    strncpy(output, VERSION_STR, outputSize);
}
void __stdcall RVExtension(char* output, int outputSize, const char* function) {
    if (!strcmp(function, "version")) {
        RVExtensionVersion(output, outputSize);
    } else {
        strncpy(output, "Active", outputSize);
    }
}
