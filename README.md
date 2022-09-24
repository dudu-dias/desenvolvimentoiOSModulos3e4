# desenvolvimentoiOSModulos3e4
Repositório para a entrega do trabalho dos módulos 3 e 4 do curso de pós graduação MBA em Mobile Development

FIAP: MBA em Mobile Development - Apps, IOT, Chatbots & Virtual Assistants Professor: Eric Alves Brito
Trabalho de Conclusão Módulos 3 e 4 1. Descrição do Aplicativo a ser desenvolvido
Como todos nós já fomos criança um dia, é bem provável que tenhamos em casa algum brinquedo que não utilizamos mais, ou então temos acesso a crianças (irmãos/irmãs mais novas, primos ou até mesmo filhos e filhas) que possuem em seu armário alguns brinquedos que já não fazem mais parte da brincadeira do dia-a-dia.
Não seria ótimo se tivesse uma forma de divulgarmos esses brinquedos de modo que crianças carentes ou de famílias mais humildes pudessem ter acesso a esses brinquedos? É exatamente isso que iremos construir, um aplicativo onde os usuários irão listar ou procurar por brinquedos para doação!!!
2. Funcionamento
O aplicativo deverá funcionar da seguinte maneira:
1) O aplicativo terá 2 telas:Tela de boas vindas e Tela com Listagem, Cadastro, Exclusão e Alteração
2) A tela inicial será uma tela simples, de boas-vindas,onde o usuário terá alguma mensagem falando do aplicativo e um botão para seguir para a próxima tela.
3) A navegação entre as telas será feita via NavigationController
4) A tela de CRUD será uma TableViewController onde o usuário poderá ver a listagem dos brinquedos. A listagem mostrará o nome do brinquedo e o telefone do doador.
5) Para excluir um brinquedo, basta realizar o gesto de Swipe. A inclusão será feita através de um botão (+) localizado no canto superior da tela, que mostrará um alerta com 2 TextFields para o nome do brinquedo e telefone do doador. O mesmo alerta será usado para edição do brinquedo selecionado (semelhante ao que fizemos no projeto de Firebase do curso)
6) Os dados deverão ser armazenado sutilizando CloudFirestore.
7) Toda a definição de interface (UI) do aplicativo ficará por conta do aluno.
