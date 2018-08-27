# scroll初始y值
scrollStart=Header.maxY-20

# 创建滚动框架
scroll=new ScrollComponent
	parent: Home
	size: Screen.size
	scrollHorizontal: false
	contentInset: 
		top:scrollStart     # 设置滚动内容离滚动框架顶部的初始距离

# 将滚动框架置于底层
scroll.sendToBack()

# 将「Feed」放入滚动框架
Feed.parent=scroll.content

scroll.onMove (feed) ->
	range=[scrollStart,50]
	Header.y=Utils.modulate(feed.y,range,[40,20],true)
	Header.height=Utils.modulate(feed.y,range,[94,60],true)
	HeaderNew.opacity=Utils.modulate(feed.y,range,[1,0],true)
	HeaderDay.fontSize=Utils.modulate(feed.y,range,[36,18],true)
	HeaderBackground.opacity=Utils.modulate(feed.y,range,[0,1],true)




TabBar.states.add
	hide:
		y:668
		animationOptions:
			time:0.2


scroll.onScroll ->
	if scroll.direction is "down"
		TabBar.animate "hide"
	if scroll.direction is "up"
		TabBar.animate "default"
