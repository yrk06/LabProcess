//Biblioteca sonora
import processing.sound.*;

//Esse enum serve como uma maquina de estado, pra chamar a funcão "Draw" do jogo escolhido
enum game {memory,choice,menu}

//COmeçamos no Menu
game c_game = game.menu;

SoundFile music;

boolean isMusicPaused = false;


// por conta de conflito com oo jogo de memoria, essa variavel controla os botões globais
boolean globalWasPressed_1 = false;
boolean globalWasPressed_2 = false;


//explicação longa:

/* A função que testa se os botões do jogo da memoria foram apertados acontece antes de testar os botões globais,
por isso o programa não deixaria apertar o botão global. pois para o botão global o mouse não teria sido pressinado naquele frame*/

// Esses dois botões são globais, o Return to Menu e o Reset
button bTm = new button(new Vector2(640-5-100,720-72),new Vector2(200,40));
button rset = new button(new Vector2(640+4+100,720-72),new Vector2(200,40));

//Botão toggle musica
button togMB = new button(new Vector2(640-10-500,720-72),new Vector2(200,40));


//Esse Array controla as opções do Menu
button[] menuButtons = new button[3];
void setup()
{
  //Configurando o Label dos botões "globais"
  bTm.SetLabel("To Menu");
  rset.SetLabel("Reset");
  togMB.SetLabel("Toggle Song");
  
  // Inicialização da janela em 720p e alinhando o texto com o centro
  background(0);
  size(1280,720); 
  textAlign(CENTER,CENTER);
  
  // Por razões de Debug, conferir se estamos no Menu antes de inicializar os botões
  if(c_game == game.menu){
  // Criando botões
  menuButtons[0] = new button(new Vector2(640,240),new Vector2(400,80));
  menuButtons[0].SetLabel("Memory Game");
  menuButtons[1] = new button(new Vector2(640,340),new Vector2(400,80));
  menuButtons[1].SetLabel("Choice Game");
  menuButtons[2] = new button(new Vector2(640,440),new Vector2(400,80));
  menuButtons[2].SetLabel("Quit");
  
  //Começando a musica
  music = new SoundFile(this,"data/Music/Electronic Voluntary.mp3");
  music.play();
  music.amp(0.1);
  }
}

// esse Bool controla se o mouse foi apertado nesse frame ou se ja estava apertado anteriormente
boolean was_pressed = false;


// Aqui é o draw 'global'
void draw()
{
  //Se a musica parar, recomeçamos
  if(!music.isPlaying() && !isMusicPaused){music.play();}
  background(0);
  
  //Caso seja o jogo da memoria ou de escolhas, chamamos a função 
  //correspondente o 'draw' ou tick do jogo
  if(c_game == game.memory){
     tick();} 
  if(c_game == game.choice) {c_tick();}
 
 
 
   // Se estivermos no Menu
  if(c_game == game.menu){
   // Colocar a cor azulada
   background(64,224,208);
   textSize(64);
   //Escrever o tiotulo
   text("LabProcess",640,72);
   // Esse For Loop desenha todos os botões
   for(int i = 0; i < menuButtons.length;i++)
   {
    menuButtons[i].Draw(); 
     
   }
   //Caso o mouse seja apertado, percorremos todos os botões
   if(mousePressed && (mouseButton == LEFT))
   {
     for(int i = 0; i < menuButtons.length;i++)
     {
      // E testamos se o botão foi apertado ou Não
     if(menuButtons[i].test_pressed(new Vector2(mouseX,mouseY)))
     {
       //A função test_pressed retorna verdadeiro se foi apertado ou falso se não foi
       
       // Dependendo do botão que foi precionado, chamamos o Setup do jogo correspondente
       // Mudamos também o estado (aquele Enum lá de cima)
       if(i == 2){exit();}
       if(i == 0){mem_gameSetup(); c_game = game.memory; was_pressed = true;}
       if(i == 1){c_setup(); c_game = game.choice;}  
     }
     }  
   } 
  }
  else // Só queremos desenhar os Botões globais se não estivermos no menu
  {
  bTm.Draw();
  rset.Draw();
  //Testamos se o mouse apertou algum desses botões
  if(mousePressed && (mouseButton == LEFT) && !globalWasPressed_1)
  {
    
    globalWasPressed_1 = true;
    if(bTm.test_pressed(new Vector2(mouseX,mouseY)))
    {
     //Se apertamos pra voltar ao menu, só precisamos mudar o estado do jogo (aquele ENUM)
     c_game = game.menu;  
     togMB.pos = new Vector2(640-10-500,720-72);
    } 
    else if(rset.test_pressed(new Vector2(mouseX,mouseY)))
    {
      //Aqui, se pedirmos pra resetar, é apenas rodar o setup novamente
      if(c_game == game.memory){mem_gameSetup();}
      if(c_game == game.choice){c_setup();}
     }
     
     }
   }
  togMB.Draw();
  if(mousePressed && (mouseButton == LEFT) && !globalWasPressed_2)
  {
    globalWasPressed_2 = true;
    if(togMB.test_pressed(new Vector2(mouseX,mouseY))){
     if(!music.isPlaying()) 
     {
      music.play(); 
      isMusicPaused = false;
     }
     else
     {
       isMusicPaused = true;
      music.pause(); 
     }
     
 }}
}
