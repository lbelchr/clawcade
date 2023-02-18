extends AnimatedSprite

var tokens
var token_value

func _ready():
	tokens = Global.check_tokens()
	token_value = int(self.name.replace("Token", ""))
	if (tokens < token_value):
		_deplete(token_value)

func _deplete(value):
	if value == token_value:
		self.play()
