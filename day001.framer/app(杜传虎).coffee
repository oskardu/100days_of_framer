#创建卡片、切换圆和背景集合
allCards=[]
allIndicators=[]
allBg=[]

#将所有卡片、切换圆和背景放入对应的集合中
allCards.push(card1,card2,card3,card4)
allIndicators.push(indicator1,indicator2,indicator3,indicator4)
allBg.push(bg1,bg2,bg3,bg4)

#设置卡片状态
for items in allCards
	items.states.add
		default:
			scale:0.6
			shadowY:2
			shadowBlur:5
			shadowColor:"rgba(0,0,0,0.25)"
		normal:
			scale:1
			shadowY:2
			shadowBlur:5
			shadowColor:"rgba(0,0,0,0.25)"
		active:
			scale:1.2
			shadowY:4
			shadowX:4
			shadowBlur:10
			shadowColor:"rgba(0,0,0,0.25)"


#设置切换圆的状态
for items in allIndicators
	items.states.add
		active:
			scale:1.2
			opacity:1

#设置背景的激活状态以及状态切换的动画参数
for items in allBg
	items.states.add
		active:
			opacity=1
	items.states.animationOptions=
		time:0.3



#创建页面滚动组件
page=new PageComponent
	width: Screen.width
	height: Screen.height
	scrollVertical: false
	opacity: 1


#设置卡片的x值
card1.x=414-334
card2.x=414*2-334
card3.x=414*3-334
card4.x=414*4-334


#将一系列卡片添加到页面滚动组件
for items in allCards
	items.parent=page.content




for items in allCards
	items.onClick ->
		this.states.next("active","normal")
		this.states.animationOptions = 
			curve: "spring(480, 22, 0)"
			time:0.1

page.content.subLayers[3].x = page.content.subLayers[3].x - 80

#页面切换时
page.on "change:currentPage", -> 
	current = page.horizontalPageIndex(page.currentPage) #获取当前页面的水平排列页面索引值，其值等于页面数减一
	items.states.switch("default") for items in allIndicators #切换圆的状态转换成「默认」
	allIndicators[current].states.switch("active") #当前切换圆切换成激活状态
	
	items.states.switch("default") for items in allCards  #卡片集合中的所有卡片状态转换成「默认」
	allCards[current].states.switch("normal") # 当前卡片状态转换成「正常」

	allBg[current].states.switch("active") #当前背景的状态切换成「激活」











