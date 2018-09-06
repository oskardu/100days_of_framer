
Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 1600
	screenHeight: 1200

# 引入module
{InputLayer}=require "input"

# 创建第一个输入框
input1=new InputLayer
	parent:emailbox
	text:"Email or nickname"
	width:323
	height:50
	x:5
	backgroundColor:"transparent"
	fontWeight:700
	fontSize:32
	color:"#E5E5E5"

# 创建第二盒输入框
input2=new InputLayer
	parent:passwordbox
	text:"Password"
	width:323-60               # 比输入框小60，避免覆盖「显示密码」按钮的点击区域
	height:50
	x:5
	backgroundColor:"transparent"
	fontWeight:700
	fontSize:32
	color:"#E5E5E5"

# 显示邮箱的动画
animation1=new Animation davidbowie_bg,
	width:193
	options:
		time:0.3
		curve:Bezier.linear

# 显示密码的动画
animation2=new Animation password2_bg,
	width:93
	options:
		time:0.2
		curve:Bezier.linear

# 加载动画
animation3=new Animation circle,
	rotation:360
	opacity: 1
	options:
		time:0.8


# 第一个输入框聚焦时，开始显示邮箱动画
input1.onInputFocus ->
	this.value="                                                  "
	animation1.start()

# 第二个输入框聚焦时，开始显示密码动画
input2.onInputFocus ->
	this.value="                        "
	animation2.start()
	eye1.opacity=1



# 输入密码时，按钮变为可点击状态
animation2.onAnimationStart ->
	signinbox.backgroundColor="#0057FF"

# 按钮的pressed状态
signinbox.onTapStart ->
	this.backgroundColor="#0044CC"

# 按钮点击后，开始加载动画
signinbox.onTouchEnd ->
	this.backgroundColor="#0057FF"
	signin.opacity=0
	animation3.start()

# 加载动画结束后，显示错误提示
animation3.onAnimationEnd ->
	wrong_password.opacity=1
	circle.opacity=0
	signin.opacity=1
	passwordbox.borderWidth=2
	passwordbox.borderColor="FF808E"



eye1.onTap ->
	this.opacity=0
	eye2.opacity=1
	passwordbox.borderWidth=0
	wrong_password.opacity=0
	password2_bg.width=0
	input2.value="awsomedavid"





















