// JOGO DA MEMORIA
// Dificuldade do jogo (numero de pares)
import java.util.Random;

int par = 9; // controla o numero total de pares
int currentPar; // quantos pares ja foram descobertos
gameCard[] Cards; // todas as cartas do jogo


// Essa função embaralha a lista
void ShuffleList(gameCard[] List)
{
  //Percorremos toda a lista
  for(int i = List.length;i >= 1; i--)
  {
   int random = int(random(List.length));
   //e trocamos de posição com alguma outra carta
   gameCard temp = List[i-1];
   List[i-1] = List[random];
   List[random] = temp;
   
    
    
  }
  //for(int i = List.length;i >= 1; i--) {println(i);println(List[i-1]);}
  
  
}

void mem_gameSetup()
{
  //Ajustar a posição dos botões globais
 bTm.pos = new Vector2(640-5-100,720-72);
 rset.pos = new Vector2(640+4+100,720-72);
 togMB.pos = new Vector2(640-10-500,720-72);
 
 //Definir quantos pares faltam
 currentPar = par;
 //Redimensionar o Array de cartas
 Cards = new gameCard[par*2] ;
 // Criar os pares
 int uID = 0;
 for(int i = 0; i < par;i++)
 {
  // Para cada par, criar uma carta com um
  // ID de time (que mostra que são pares)
  // e um ID Unico, que server para cada carta
  gameCard card1 = new gameCard(uID,i);
  Cards[uID] = card1;
  uID++;
  gameCard card2 = new gameCard(uID,i);
  Cards[uID] = card2;
  uID++;
 }
 // Depois de criar as cartas, embaralhar
 ShuffleList(Cards);
 
 /* Aqui a função define a posição das cartas
 o Y depende da linha, a primeira metade fica na primeira linha
 e o X depende da formula i*(1000/par) + 640 - par/2 * 1000/par
 sendo I a posição no Array
 */
 for(int i = 0;i < Cards.length; i++)
  {
    // 640 - Metade * 1000/par = X
   Vector2 pos; 
   if(i < par)
   {
     //se for primeira linha
     pos = new Vector2(i*(1000/par) + 640-par/2*1000/par,240);
   }
   else
   {
     // se for segunda
     pos = new Vector2((i-par)*(1000/par)+640-par/2*1000/par,480);
   }
   //aqui colocamos as posições calculatas na carta e no botão
   Cards[i].pos = pos;
   Cards[i].my_button.pos = pos;
  }
}

//Controla quantas cartas foram selecionadas
int selected = 0;

//Array das cartas selecionadas
gameCard[] CardsSelected = new gameCard[2];

// enum dos estados do jogo
enum GameState { ToSelect,
                  Comparing,
                }
             
// O tempo para mostrar as cartas ao jogador
float CompareTimeout;
float maxTimeout = 1.;
// estado inicial
GameState state = GameState.ToSelect;
int points; // pontos feitos

void tick()
{
  background(0,150,0);
  
  // Se o jogador tiver selecionado todos os pares, mostrar que ganhou
  // também é necessario que não esteja no modo de comparação
  if(currentPar == 0 && state == GameState.ToSelect){
  textSize(64);
  text("You Win",640,72);
}
  
  
  //Desenhar as cartas
  for(int i = 0;i < Cards.length; i++)
  {
   Cards[i].Draw();
  }
  
  //Se estivermos no estado de selecionar
  if(state == GameState.ToSelect){
    //quando as cartas selecionadas forem menos que 2, podemos selecionar mais algumas
    if(selected < 2){
        //Se o botão for apertado
        if(mousePressed && (mouseButton == LEFT) && !was_pressed)
        {
          // Essa variavel não permite que mais de uma carta seja selecionada com o mesmo clique
          was_pressed =true;
          // Agora passamos por todas as cartas e testamos se foram selecionadas
          for(int i = 0;i < Cards.length; i++)
          {
           //Buttons[i].test_pressed(new Vector2(mouseX,mouseY));
           //Teste da carta
           boolean result = Cards[i].test_button(new Vector2(mouseX,mouseY));
           if(result)
           {
            //se foi selecionada, aumentamos a variavel que controla a seleção
           selected ++; 
           //Colocamos a carta no array de selecinadas, na ordem em que foi escolhida
           CardsSelected[selected-1] = Cards[i]; 
           //Se essa foi a segunda seleção, passamos pro estágio de comparação
           if(selected == 2) {state = GameState.Comparing;CompareTimeout = maxTimeout;}
           break;
   }}}}}
   
   
   if(state == GameState.Comparing)
   {
    //Nesse estágio, marcamos para a carta estar virada e desenhamos de novo
    for(int i = 0;i<2;i++)
    {
      CardsSelected[i].is_front = true;
      CardsSelected[i].Draw();
    }
    
    // Se as duas cartas forem da mesma equipe (mesmo par)
    if(CardsSelected[0].TeamID == CardsSelected[1].TeamID) {
      // Para fazer isso apenas no primeiro frame, adicionamos um ponto e retiramos um dos pares
      // pois acertamos
      if(CompareTimeout == maxTimeout){points ++; currentPar --;} 
    } else 
    //Se as duas cartas não forem pares, resetamos as variaveis para os valores normais
    {CardsSelected[0].is_front = false;CardsSelected[1].is_front = false;CardsSelected[0].onTimeout = false;CardsSelected[1].onTimeout = false;}
    //Se o timeout ja acabou, avaçar ao proximo estado
    if(CompareTimeout <= 0.) {state = GameState.ToSelect;selected = 0;CardsSelected = new gameCard[2];}
   }
   //reduzir o timeout pelo tempo de um frame
   CompareTimeout -= 1/60.;
}


void mouseReleased()
{
  //Se o mouse for solto, resetar a variavel de primeiro frame
  was_pressed = false;
}
