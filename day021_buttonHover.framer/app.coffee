Framer.Device.customize
	deviceType: "fullscreen"
	screenWidth: 800
	screenHeight: 600


layer=new Layer
	width: 120
	height: 44
	borderRadius: 44
	backgroundColor: "#0003E6"
	shadowY: 2
	shadowBlur: 8
	shadowColor: "rgba(0,0,0,.15)"

layer.center()


text=new TextLayer
	text: "Button"
	fontSize: 16
	fontWeight: 600
	color: "white"
	parent: layer

text.center()


layer.states.stateA=
	y: 120
	backgroundColor: "#0003B3"
	shadowY: 4
	shadowBlur: 16
	shadowColor: "rgba(0,0,0,.25)"
	options: 
		time:0.2
		curve: Bezier.easeOut

layer.states.stateB=
	y: 128
	backgroundColor: "#0003E6"
	shadowY: 2
	shadowBlur: 8
	shadowColor: "rgba(0,0,0,.15)"
	options: 
		time:0.2
		curve: Bezier.easeOut


layer.onMouseOver ->
	layer.animate "stateA"

layer.onMouseOut ->
	layer.animate "stateB"










