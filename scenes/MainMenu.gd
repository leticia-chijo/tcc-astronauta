extends Node2D
var savegame = File.new()
var savepath = "user://astronauta.save"

func _ready():
	if not savegame.file_exists(savepath):
		get_node("continue").hide()
	else:
		get_node("continue").show()

func _on_newGame_pressed():
	var savedata = {
		"startPlanet": true,
		"endgame": false,
		"games": {
			"rocket": {"status": 0, "score": "0", "listname": null},
			"mario": {"status": 0, "score": "0", "listname": "Fazer compras para a geleia"},
			"flappy": {"status": 0, "score": "0", "listname": "Levar o gato para passear"},
			"candy": {"status": 0, "score": "0", "listname": "Comprar roupas decentes no shopping"},
			"timber": {"status": 0, "score": "0", "listname": "Comprar presente para as crianças"},
			"pacman": {"status": 0, "score": "0", "listname": "Recolher peças da nave na floresta", "metadata": {"eaten":[], "score":0}},
			"ferramentas": {"status": 0, "score": "0", "listname": "Separar ferramentas"},
		},
		"npcs": {
			"default": {
				"show": true,
				"dialogs": [["Que dia bonito!"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"ajudante": {
				"show": true,
				"dialogs": [["Nossa, a chefe tinha pedido para o marido dela arrumar a oficina, mas ele largou um monte de coisa aqui", 
				"Você vai ter que limpar essa bagunça, para eu poder achar as ferramentas", 
				"descarte tudo que não for ferramenta, você sabe o que são ferramentas né?"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"mecanica": {
				"show": true,
				"dialogs": [["Olá alienígena!", { "pergunta": "Vi que sua nave caiu na floresta, você está sozinho? Precisa de ajuda?", "resp1": "Sim", "resp2": "Não"}],
				["Não importa, você é só um homenzinho... Te ajudaria de qualquer jeito. Sozinho você não vai conseguir."], 
				["Para que eu posso te ajudar você precisa me ajudar com algumas tarefas. Já que você parece meio lentinho, vou te explicar bem devagar.", 
				"Meu marido deixou uma grande bagunça na oficina, então vou precisar que você arrume para que eu possa consertar sua nave. Amanda, minha assistente, está lá fora pra te ajudar.",
				"Também vou precisar que você vá na floresta recolher as peças da sua nave. Ouvi dizer que o esquisitão que mora numa casa velha pode ter pego algumas coisas. Tenha cuidado ao andar sozinho por lá, é perigoso pra um docinho que nem você.",
				"Também tinha falado que ia passear com o gato da minha amiga pra ela, mas não to a fim de ficar fazendo essas coisas de homenzinho, então você pode ir. Ela mora na maior casa da cidade.",
				"Hoje é aniversário da minha filha, então vou precisar que você compre morangos pro meu marido fazer a geléia favorita dela e colocar de recheio no bolo.",
				"Também preciso que compre um presente pra ela, um brinquedo. Mas tem que ser algo bem incrível pra minha filhona!",
				"Por fim, meu marido precisa de umas roupinhas decentes pra gente poder sair pra jantar sem ninguém ficar olhando pras pernas dele. Ele adora aparecer...",
				"As tarefas estão listadas numa folha que você pode ver apertando esse botão de pause.", 
				"Boa sorte!"], ["Parece que você fez tudo o que eu pedi.","Terminei de arrumar sua nave, ela está pronta na floresta.",
				"Cuidado para não estragar ela de novo!"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"velho": {
				"show": true,
				"dialogs": [["Então foi você que causou toda aquela barulheira!?", 
				"Meu labirinto agora está cheio de partes da sua nave", 
				"Pode procurar por lá, mas tome cuidado para não encontrar ninguém", 
				"Há boatos de mulheres fazendo coisas horríveis com homens lá",
				"A entrada fica no meu caldeirão, no quarto à sua esquerda"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"mercadora": {
				"show": true,
				"dialogs": [["Oi bonitinho! A mecânica disse que você viria para comprar umas coisas para a geleia. Vou por na conta dela", 
				"Você tem pernas muito bonitas", "Não demore muito que a mecânica pode ficar brava", 
				"As frutas estão no corredor do fundo, não esqueça de pegar nenhuma",
				"Venha me ver de novo quando puder, gatinho"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"vendedor": {
				"show": true,
				"dialogs": [["Olá, a senhora mecânica avisou que você viria comprar roupas para o marido dela",  
				"Você é homem como eu, deve saber de moda. Temos vários tipos de roupas aqui, mas...", 
				"Ela disse que não queria nada vulgar, então melhor não pegar nada muito curto ou justo",
				"Nada de regatas, camisetas de manga curta ou shorts, para poder pegar uma roupa junte conjuntos de três"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"vendedorDeBrinquedo": {
				"show": true,
				"dialogs": [["Oi, hoje é aniversário da filha da mecânica né?", "Aquela menina é muito inteligente!", 
				"Escolha os brinquedos que você acha adequados para meninas"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"ricassa": {
				"show": true,
				"dialogs": [[ "Finalmente você chegou, achava que a mecânica ia mandar o marido dela, mas você deve servir também.", 
				"Meu marido vive reclamando que está sobrecarregado, fica me pedindo pra ajudar com as tarefas de casa. Um absurdo!", 
				"Preciso que você vá passear com o gato, ele está no quarto do meio. Ele é um gato meio bobo, não deixe ele ficar batendo nas coisas."]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"maridoDaRicassa": {
				"show": true,
				"dialogs": [["Oi, tudo bem? Sou o marido da Victória", 
				"desculpa não poder te dar muita atenção, estou cheio de coisas para fazer", 
				"preciso cuidar do bebê que acabou de nascer, ele não parou de chorar a noite toda, mal pude dormir!", 
				" Ainda preciso levar as crianças para a escola, limpar essa casa enorme inteira e preparar o jantar de hoje!"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"vendedorDeCarros": {
				"show": true,
				"dialogs": [["Olá moçinho! Sou a melhor vendedora de carros da cidade. Sua mulher está procurando um bom carro?"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"controles": {
				"show": true,
				"dialogs": [["Esse é um quadro de diálogo, pressione a seta ao lado para continuar",
				"Pressione as setas do canto inferior direito para se movimentar!"],
				["Se aproxime de uma pessoa e aperte o balão para falar com ela."]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"tutorial1": {
				"show": true,
				"dialogs": [["Hoje é o grande dia da sua missão, astronauta!", 
				"O planeta XYZ-423 possui muitos recursos que precisamos aqui na Terra.",
				{ "pergunta": "Você está animado?", "resp1": "Sim", "resp2": "Não"}], 
				["Bem, não é como se isso fosse mudar alguma coisa, de toda forma."]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"tutorial2": {
				"show": true,
				"dialogs": [["Sua nave está quase preparada, senhor.", 
				"Converse com o seu supervisor antes de partir.", "Boa viagem!"]],
				"current_dialog": 0,
				"current_speech": 0
			},
			"tutorial3": {
				"show": true,
				"dialogs": [["Olá, Astronauta! Finalmente chegou o dia da sua missão.", 
				"Para chegar ao planeta XYZ-423, você precisará pilotar a sua nave com cautela.",
				"Mas é claro que você já sabe de tudo isso, treinou bastante antes deste momento.",
				"Entre na sua nave e boa viagem!", 
				"Para entrar em missões aproxime-se e pressione o balão"]],
				"current_dialog": 0,
				"current_speech": 0
			},
		}
	}
	Savedata.save(savedata)
	Transition.fade_to("res://scenes/Mapas/Tutorial.tscn")

func _on_continue_pressed():
	var savedata = Savedata.read()
	if savedata["games"]["rocket"]["status"] != 1:
		Transition.fade_to("")
	else:
		Transition.fade_to("res://scenes/Mapas/MapaPlaneta.tscn")
