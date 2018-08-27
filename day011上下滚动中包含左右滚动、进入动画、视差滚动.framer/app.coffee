# 创建flowcomponent，背景为白色
flow=new FlowComponent
	backgroundColor: "white"

# 设置悬浮header和footer
flow.header=navBar
flow.footer=tabBar

# 跳转到页面「home」
flow.showNext(home)

# 锁定滚动方向，使content内容在水平滚动的时候不触发flow的上下滚动
flow.scroll.directionLock=true

# 设置水平滚动内容
for elem in [content1,content2,content3]
	scroll=ScrollComponent.wrap(elem)  # 将elem包裹入滚动组件
	scroll.scrollVertical=false        # 禁止垂直方向滚动
	scroll.directionLock=true          # 锁定滚动方向，使content内容在水平滚动的时候不触发flow的上下滚动
	scroll.content.clip=false          # 不做框架mask，避免把阴影切掉
	scroll.contentInset=               # 滚动内容距离滚动框架的距离为20
		right:20



# 设置集合leftLayers,该集合内的内容为从左向右进入屏幕
leftLayers=[{layer:poster,delay:0},{layer:subtitle2,delay:0.6},{layer:icon_search,delay:0}]

# 设置集合rightLayers,该集合内的内容为从右向左进入屏幕
rightLayers= [{layer: subtitle,delay: 0.3}, {layer: title,delay: 0.5}, {layer: star1,delay: 0.6}, {layer: star2,delay: 0.7}, {layer: star3,delay: 0.8}, {layer: star4,delay: 0.9}, {layer: star5,delay: 1}, {layer: card1,delay: 0.6}, {layer: card2,delay: 0.8}, {layer: card3,delay: 1}, {layer: title1,delay: 0.7}, {layer: title2,delay: 0.9}, {layer: title3,delay: 1.1}, {layer: duration1,delay: 0.8}, {layer: duration2,delay: 1}, {layer: duration3,delay: 1.2}, {layer: icon_bell,delay: 0}]


for elem,i in leftLayers
	elem.x=elem.layer.x
	elem.layer.x-=elem.layer.maxX  # elem.layer.x=elem.layer.x-elem.layer.maxX，集合内内容都置于屏幕左侧

for elem,i in rightLayers
	elem.x=elem.layer.x
	elem.layer.x=Screen.width      # 集合内内容都置于屏幕右侧


for elem in leftLayers.concat(rightLayers)   # concat：链接两个集合
	elem.layer.animate                       # elem从设定位置动画到初始位置
		x:elem.x
		options:
			elem.delay


parallaxBlocks=[parallaxBlock1,parallaxBlock2]

# 定义视差滚动函数
caculateParallax = ->
	for elem,i in parallaxBlocks
		image=elem.children[0]            # 子图层中最底层的一个
		image.y=Utils.modulate(elem.screenFrame.y,[-elem.height,elem.height],[0,-110])   # screenFrame为相对于屏幕的绝对位置，当parallaxBlock相对于屏幕在[-parallaxBlock.height,parallaxBlock.height]移动时，图片在[0，-110]之间移动（相对于父级）

caculateParallax()


# flow空间中scroll执行时，执行视差滚动函数
flow.scroll.onMove ->
	caculateParallax()



