# CapsLock 中英文输入切换（Windows）

长按阈值为 **0.35 秒（350 毫秒）**。

- **短按 CapsLock**：切换 Windows 输入源。切回微软拼音时，脚本等待 60 毫秒并检查一次输入源；确认切换完成后，直接设为中文模式，不使用 `Shift` 翻转模式，也不轮询。
- **长按至少 350 毫秒**：松开后切换 CapsLock 大小写状态。

## 运行 EXE

双击 `CapsLockInputSwitch.exe` 即可运行，不需要另外安装 AutoHotkey。要开机启动，将 EXE 的快捷方式放进启动文件夹：按 `Win+R`，输入 `shell:startup`，回车后把快捷方式复制进去。

建议 Windows 输入源列表只保留“微软拼音”和一个英文键盘布局，以实现中英双态切换。

`CapsLockInputSwitch.ahk` 是可编辑的源码版本；运行源码需要 AutoHotkey v2。
