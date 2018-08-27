# 创建flowComponent
flow=new FlowComponent
flow.showNext(home)

# 创建「sound」图层
sound=new Audio("sounds/notification.m4a")
sound.volume=1

# 创建置于最上层的「bg」图层，无填充，用于包裹「bigicon」以改变其层级
bg=new Layer
	backgroundColor: "transparent"

# 1.75s后播放音效
Utils.delay 1.75,->
	sound.play()

# 2s后从底部弹出「notification」
Utils.delay 2,->
	flow.showOverlayBottom(notification)

# 4s后
Utils.delay 4,->
	bigicon.parent=bg              # 设置父级为bg，使其置于顶层
	bigicon.animate                # 设置位置变化动画
		frame:smallicon.frame
		options: 
			curve: Spring(0.9)
			time:0.5

	overview.opacity=0             # 设置notification中「overview」不可见

	message.parent=notification    # 设置父级为「notification」，保持层级正确
	message.y=Screen.height        # 设置message位置，以便其从底部弹出
	message.animate
		y: 0
		options: 
			curve: Spring(0.85)
			time:0.6

# 7.5s后
Utils.delay 7.5,->
	flow.showPrevious()            # 显示notification页面
	bigicon.opacity=0              # 使bigicon不可见