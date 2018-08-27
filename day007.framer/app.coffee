# 创建背景图层，设置其颜色
bg=new BackgroundLayer
	backgroundColor: "hotpink"
	width: Screen.width
	height: Screen.height

layerH = 90
margin = 30
totalH = layerH + margin
Layers = []
animateTime = 0.18
movingY = 0     # 设置movingY初始值,很重要

# 定义createLayers
createLayers=() ->
	for i in [0..3]
		layer=new Layer
			width: 310
			height: layerH
			x: Align.center
			y: totalH*(i+1)
			borderRadius: 4
			backgroundColor: "white"
			shadowX: 2
			shadowY: 2
			shadowBlur: 4
			shadowColor: "rgba(0,0,0,0.15)"
			style: 
				"color":"#888"
				"font-size":"24px"
				"paddingTop":"10px"
				"paddingLeft":"10px"
#		layer.html=i      # 使图层内显示序号
		layer.draggable.enabled=true
		layer.draggable.horizontal=false
		layer.draggable.speedX=0.2
		Layers.push(layer)
createLayers()


# 定义checkDrag()
checkDrag=() ->
	Layers[0].onDrag ->
		this.z=5
		movingY=this.y

		if movingY>=totalH*1.5 and movingY<totalH*2.5  #.animate和{}之间必须有一个空格，不然会报错
			Layers[1].animate
				y:totalH*1
				options:
					curve:"linear"
					time:animateTime

		if movingY>=totalH*2.5 and movingY<totalH*3.5
			Layers[2].animate {properties:(y:totalH*2),curve:"linear",time:animateTime}

		if movingY>= totalH * 3.5
			Layers[3].animate {properties:(y:totalH*3),curve:"linear",time:animateTime}


	Layers[1].onDrag ->
		this.z=5
		movingY=this.y

		if movingY<totalH*1.5
			Layers[0].animate
				y:totalH*2
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*2.5 and movingY<totalH*3.5
			Layers[2].animate
				y:totalH*2
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*3.5
			Layers[3].animate
				y:totalH*3
				options:
					curve:"linear"
					time: animateTime



	Layers[2].onDrag ->
		this.z=5
		movingY=this.y

		if movingY<totalH*1.5
			Layers[0].animate
				y:totalH*2
				options:
					curve:"linear", time: animateTime
			Layers[1].animate
				y:totalH*3
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*1.5 and movingY<totalH*2.5
			Layers[1].animate
				y:totalH*3
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*3.5
			Layers[3].animate
				y:totalH*3
				options:
					curve:"linear", time: animateTime



	Layers[3].onDrag ->
		this.z=5
		movingY=this.y

		if movingY<totalH*1.5
			Layers[0].animate
				y:totalH*2
				options:
					curve:"linear", time: animateTime
			Layers[1].animate
				y:totalH*3
				options:
					curve:"linear", time: animateTime
			Layers[2].animate
				y:totalH*4
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*1.5 and movingY<totalH*2.5
			Layers[1].animate
				y:totalH*3
				options:
					curve:"linear", time: animateTime
			Layers[2].animate
				y:totalH*4
				options:
					curve:"linear", time: animateTime

		if movingY>=totalH*2.5 and movingY<totalH*3.5
			Layers[2].animate
				y:totalH*4
				options:
					curve:"linear", time: animateTime



	for i in [0..3]
		Layers[i].onDragStart ->
			this.animate
				scale:1.1
				shadowX:4
				shadowY:4
				shadowBlur:16
				options:
					curve:"spring(300, 22, 0)"
					time:animateTime

		Layers[i].onDragEnd ->
			this.animate
				scale:1
				shadowX:2
				shadowY:2
				shadowBlur:4
				options:
					curve:"linear"
					time: animateTime


			if movingY<totalH*1.5
				this.animate
					y:totalH
					options:
						curve:"linear"
						time: animateTime

			if movingY>=totalH*1.5 and movingY<totalH*2.5
				this.animate
					y:totalH*2
					options:
						curve:"linear"
						time: animateTime

			if movingY>=totalH*2.5 and movingY<totalH*3.5
				this.animate
					y:totalH*3
					options:
						curve:"linear"
						time: animateTime

			if movingY>totalH*3.5
				this.animate
					y:totalH*4
					options:
						curve:"linear"
						time: animateTime


			Utils.delay animateTime * 1.1, ->   # 0.18*1.1s后执行：拖拽结束时销毁所有图层，然后重新创建初始图层，执行checkDrag使其处于正确位置
				for j in [0..3]
					Layers[j].destroy()         # 销毁图层Layers[j]
				Layers = []	                    # 集合Layers为空
				createLayers()                  # 重新创建四个一样的新图层
				checkDrag()                     # 执行checkDrag()



checkDrag()

