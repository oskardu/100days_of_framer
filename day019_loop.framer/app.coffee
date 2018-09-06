# UI Designer  Wechat:kcufuoyd  Email:2292552585@qq.com

# 用來旋轉物件的rotation；用來放大縮小某軸的scaleX、scaleY；用來定時觸發的Utils.interval

# 来自：https://medium.com/framer-js-taiwan/framer-in-action-day1-7954463732cb

# Define and set custom device 
Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 1600
	screenHeight: 1200

color1="#00BAEF"
color2="#9127EF"
color3="white"



# 包含数个集合的集合
#0:w,    1:h,    2:y,      3:x,      4:op,5:y,     6:x,     7:颜色, 8:sX,  9:sY]
circleArray=[[310,310,7.38095,7.38095,0.9,7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    2.706350, 2.706350, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    7.380950, 7.380950, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    1.722220, 1.722220, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    7.380950, 7.380950, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    0.738095, 0.738095, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    7.380950, 7.380950, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    7.380950, 7.380950, 0.9, 7.38095, 7.38095, color1, 0.93, 1.01],
[310,    310,    0.738095, 0.738095, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    7.380950, 7.380950, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    1.722220, 1.722220, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    7.380950, 7.380950, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    2.706350, 2.706350, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    7.380950, 7.380950, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[310,    310,    3.690480, 3.690480, 0.1, 7.38095, 7.38095, color2, 0.96, 1.01],
[239.134,239.134,35.43300, 35.43300, 0.5, 4.42857, 0.00000, color3, 0.94, 1.00],
[239.134,239.134,35.43300, 35.43300, 0.5, 4.42857, 0.00000, color3, 0.94, 1.00],
[239.134,239.134,35.43300, 35.43300, 0.5, 4.42857, 0.00000, color3, 0.94, 1.00],
[239.134,239.134,35.43300, 35.43300, 0.5, 4.42857, 0.00000, color3, 0.94, 1.00],
[239.134,239.134,35.43300, 35.43300, 0.5, 4.42857, 0.00000, color3, 0.94, 1.00],]



# 图层旋转的函数
rotateLayer=(layer,isP)->
	if isP
		layer.rotation=layer.rotation+Utils.randomNumber(1,5)    # 正向旋转
	else
		layer.rotation=layer.rotation-Utils.randomNumber(3,5)    # 逆向旋转


index=0


for item in circleArray
	SqureParent=new Layer               # 创建20个正方形（310x310或239.134x239.134）
		height:item[1]                  # 高为310或239.134
		width:item[0]                   # 宽为310或239.134
		parent: LayerMain               # 设置父级为LayerMain
		x:item[3]
		y:item[2]
		name:index                     # 用index命名
		backgroundColor: "Transparent" # 使其透明

	Circle=new Layer                   # 创建20个圆（310x310或239.134x239.134）
		borderRadius: item[0]/2        # 使其为圆
		height: item[1]                # 高为310或239.134
		width: item[0]                 # 宽为310或239.134
		backgroundColor: item[7]
		parent: SqureParent            # 设置父级为SqureParent
		opacity: item[4]
		x:item[6]
		y:item[5]
		scaleX: item[8]                # 水平方向缩放
		scaleY: item[9]                # 垂直方向缩放
	index++


# LayerMain居中
LayerMain.center()

timeInterval=0.05

# 每隔0.05秒
Utils.interval timeInterval,->
	for item in LayerMain.children		
		if parseInt(item.name)%2==0    # 若item.name除以2的余数为0则逆向旋转。parseInt() 函数可解析一个字符串，并返回一个整数。
			rotateLayer(item,false)
		else
			rotateLayer(item,true)

