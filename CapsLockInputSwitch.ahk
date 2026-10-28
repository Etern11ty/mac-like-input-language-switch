#Requires AutoHotkey v2.0
#SingleInstance Force

; Short tap toggles between the Chinese and English Windows input sources.
; Hold for 350 ms toggles CapsLock after release.
$CapsLock::{
    if KeyWait("CapsLock", "T0.35") {
        ToggleChineseEnglishSource()
    } else {
        KeyWait "CapsLock"
        if GetKeyState("CapsLock", "T")
            SetCapsLockState "Off"
        else
            SetCapsLockState "On"
    }
}

ToggleChineseEnglishSource() {
    hwnd := WinExist("A")
    if !hwnd
        return

    currentLang := GetForegroundLangId(hwnd)
    targetChinese := (currentLang != 0x0804)

    ; Keep exactly two input sources installed for a true two-state toggle.
    Send "#{Space}"

    if targetChinese {
        ; One short wait, then one check (no polling).
        Sleep 60
        if GetForegroundLangId(hwnd) = 0x0804
            EnsureChineseMode()
    }
}

GetForegroundLangId(hwnd) {
    threadId := DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "Ptr", 0, "UInt")
    hkl := DllCall("GetKeyboardLayout", "UInt", threadId, "UPtr")
    return hkl & 0xFFFF
}

EnsureChineseMode() {
    hwnd := WinExist("A")
    if !hwnd || GetForegroundLangId(hwnd) != 0x0804
        return

    imeHwnd := DllCall("Imm32\ImmGetDefaultIMEWnd", "Ptr", hwnd, "Ptr")
    if !imeHwnd
        return

    ; Set native Chinese mode through the IME window, without toggling Shift.
    DllCall("SendMessageW", "Ptr", imeHwnd, "UInt", 0x0283, "UPtr", 0x0002, "Ptr", 0x0401, "Ptr")
    DllCall("SendMessageW", "Ptr", imeHwnd, "UInt", 0x0282, "UPtr", 0x0002, "Ptr", 0, "Ptr")
}

