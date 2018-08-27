# 垂直方向使用ScrollComponent，水平方向对每个卡片集使用PageComponent；限制只能在一个方向产生拖拽行为


allCards=[]
colors=[]
cardH=200

# 创建滚动组件 「screen」要大写，不然会出问题
scroll=new ScrollComponent
	width: Screen.width
	height: Screen.height
	scrollHorizontal: false
	backgroundColor: "black"


# 创建14个页面滚动组件，每个组件的间距为4
for i in [0..14]
	card=new PageComponent
		width: scroll.width
		height: cardH
		x: 0
		y: (cardH+4)*i
		backgroundColor: "black"
		parent: scroll.content
		scrollVertical: false
	card.animationOptions =
		curve: "spring(100,10,0)"
	allCards.push(card)

# 将14个页面滚动组件加入到集合中
	allCards.push(card)

# 对于每一个页面滚动组件，创建5个子内容，其颜色随机
	for i in [0..4]
		colors[i]=Utils.randomColor(1)
		page=new Layer
			html:card.id + ","+ (i+1)
			width: scroll.width
			height: cardH
			style: background:"-webkit-linear-gradient(110deg,"+colors[i]+" 10%, #332626 98%)"
			x: scroll.width*i
			parent: card.content

# # 定义子卡片上的HTML文字内容
		page.style=
			"color":"white"
			"font-size":"80px"
			"font-family":"futura"
			"font-weight": 700
			"text-align": "center"
			"padding-top": "280px"

# 对拖拽方向上锁
scroll.content.draggable.directionLock = true

# 方向锁定触发时，设置时间处理程序
scroll.content.draggable.on Events.DirectionLockDidStart, (event)->
	for card in allCards
		# 若x方向上锁，则水平方向不可拖拽
		if event.x then card.scrollHorizontal = false
		# 若y方向上锁，则水平方向可拖拽
		if event.y then card.scrollHorizontal = true

