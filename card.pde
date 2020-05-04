// Essa é a classe das cartas do jogo da memoria

class gameCard
{
 color front; // descontinuado
 color back = color(100); // A cor do fundo da carta
 color selected = color(200); // a cor quando carta é selecionada
 int UniqueID; // ID unico da carta, caso seja necessario
 int TeamID; // Qual o Par dessa carta
 PImage my_front; // O lado da frente da carta
 boolean is_front = false; // se a carta está de frente ou não
 Vector2 pos = new Vector2(240); // Igual as outras classes, a posição e tamanho da carta
 Vector2 size = new Vector2(100,int(100*4/3.)); // o Tamanho é pre-definido
 button my_button = new button(pos,size); // O botão dessa carta
 boolean onTimeout = false; // Se a carta pode ser apertada
 
 void ready()
 {
  
  // Essa função é chamada durante o construtor da carta
  // Responsavel por carregar qual a imagem dessa carta em especifico
  if(TeamID == 0){front = color(255,0,0);
  my_front = loadImage("data/Images/Pig.jpg");} 
  if(TeamID == 1){front =  color(0,255,0);
  my_front = loadImage("data/Images/Janitor.jpg");} 
  if(TeamID == 2){front =  color(255,255,0);
  my_front = loadImage("data/Images/OldMan.jpg");} 
  if(TeamID == 3){front =  color(255,255,255);
  my_front = loadImage("data/Images/SciFi.jpg");} 
  if(TeamID == 4){front =  color(0,0,255);
  my_front = loadImage("data/Images/Samurai.jpg");} 
  if(TeamID == 5){front =  color(255,150,150);
  my_front = loadImage("data/Images/Warrior.jpg");} 
  if(TeamID == 6){front =  color(100,0,100);
  my_front = loadImage("data/Images/Ginger.jpg");} 
  if(TeamID == 7){front =  color(100,0,100);
  my_front = loadImage("data/Images/Cowboy.jpg");}
  if(TeamID == 8){front =  color(100,0,100);
  my_front = loadImage("data/Images/PizzaDude.jpg");} //<>//
 }
 // o construtor recebe apenas os dois IDs da carta e chama a função ready
 gameCard(int uID,int tID)
 {
  UniqueID = uID; 
  TeamID = tID;
  ready();
 }
 
 // Essa função cuida do tick (draw) da carta, é chamado pelo jogo todo frame
 void Draw()
 {
   // Desenhamos o botão mas logo em seguida a carta é desenhada por cima
   my_button.Draw();
   // Como padrão, utilizamos a cor do fundo da carta
   fill(back);
   if(onTimeout){fill(selected);} // Se a carta estiver em timeout, significa que não pode
   // Ser escolhida, portanto colocamos a cor de selecionada
   //Desenhamos a carta
   rect(pos.x-size.x/2.0,pos.y-size.y/2.0,size.x,size.y);
   
   //Se a carta estiver de frente, desenhamos a imagem
   if(is_front){ image(my_front,pos.x - size.x/2.0,pos.y - size.y/2.0);}
   
   // Código que cuidava do Timeout da carta
   /*
   if(currentTimeout > 0.)
   {
    currentTimeout -= 1/60.;
   } else {
   if(is_front) {removeSelected();}
   is_front = false;}*/
   // Na versão mais atual, os timeouts são controlados pelo jogo em si
   
 }
 
 //Por ultimo a mesma função que determina se a carta foi escolhida
 boolean test_button(Vector2 where)
 {
  boolean result = false ;
  if(!onTimeout){
    //Se a carta puder ser escolhida, testar o botão
    result  = my_button.test_pressed(where);
    //Se o botão der positivo, marcar a carta como selecionada
    if(result){onTimeout = true;}
  }
  //Retornar o resultado
  return result;
 }
  
  
  
}
