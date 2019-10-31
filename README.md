# 解决键盘遮挡

1. 接收键盘弹出的通知

2. 获取 UITextField 的第一响应者

3. 计算 View 需要上移的高度，然后改变 View 的 frame

不过现在发现最简单的方式可以通过 [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) 这个框架解决
