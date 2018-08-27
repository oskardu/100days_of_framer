# 创建flowComponent
flow=new FlowComponent
flow.showNext(screenA)

# 创建透明图层
bg=new Layer
	backgroundColor: "transparent"

# 将「smallcover」的初始位置大小参数和阴影参数赋值给「frame」和「shadows」；设置clouds的初始位置；设置bigcover的透明度
frame=smallcover.frame
shadows=smallcover.shadow
clouds.y+=40
bigcover.opacity=0

# 设置初始动画选项
Framer.Defaults.Animation=
	time: 0.6
	curve: Spring(0.84)


# 点击「smallcover」时
smallcover.onClick ->

# 将smallcover的父级设置为bg，使其在页面最上层
	smallcover.parent=bg

# 在屏幕底部向上覆盖一个模态图层
	flow.showOverlayBottom(screenB)

# smallcover的变换动画
	smallcover.animate
		frame:bigcover.frame
		shadow:bigcover.shadow

# clouds的位置变换动画
	clouds.animate
		y: -80

# 点击关闭按钮时
cancel.onClick ->
	flow.showPrevious()
	clouds.y+=40
	smallcover.animate
		frame:frame
		shadow:shadows

