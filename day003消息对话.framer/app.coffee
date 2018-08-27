msgCount=0
msgList=[]

# 给发送按钮添加pressed状态
sendButton.states.add
	pressed:
		opacity:0.5
		scale:0.98
sendButton.states.animationOptions=curve:"spring(100,10,0)"


# 点击发送按钮时，状态转换
sendButton.onTouchStart ->
	sendButton.states.switch("pressed")
sendButton.onTouchEnd ->
	sendButton.states.switch("default")



# 定义function：inputBox——创建输入
inputBox = document.createElement("input")

# 定义输入框样式
inputBox.style["width"]  = 950 + "px"
inputBox.style["height"]  = 107 + "px"
inputBox.style["font-size"] = 44 + "px"
inputBox.style["padding-left"] = 40 + "px"
inputBox.style["color"]="black"

# 输入框聚焦时，输入框内容为空，占位内容为「Type a message」
inputBox.focus()
inputBox.value = ""
inputBox.placeholder = "输入内容..."

# 将输入框内容添加到图层 inputBox2
inputBox2._element.appendChild(inputBox)


# 点击发送按钮时，将输入框的值赋值给文本，输入框
sendButton.onClick ->
	text=inputBox.value
	inputBox.value=""
	inputBox.focus()



# 若文字长度不为零 第一个消息气泡的样式
	if text.length != 0
		msgCount += 1
		message = new Layer
			parent: frame02 # 使其父级为frame02，在topNav之下
			index:1
			height: 36
			width: 18*text.length+10
			backgroundColor: "#216fEf"
			html: text
			y: inputBox2.y - 16
			style: 
				"font-size": "16px"
				"text-align": "center"
				"padding-top": "40px"
		message.borderRadius = "100px 100px 100px 100px"
		message.x = Screen.width - message.width - 16
		message.placeBehind(topNav)


# 将所有message放入集合msgList中
		msgList.push(message)

# 消息出来时候的动画
		for i in [0...msgCount]
			msgList[i].animate
				properties:
					y: msgList[i].y - 46    #每个消息气泡的y方向移动距离
				curve: "spring(300, 23, 0)"


