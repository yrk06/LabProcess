import processing.video.Movie;


// Esse Jogo precisa de 4 recursos, os dois videos e duas imagens


Movie intro;
Movie doorA;
PImage introImg;
PImage doorAImg;

// as duas Intro são sempre fixas, já os Door são carregados no momento que o jogador escolher

int c_selection;
int c_prize;
boolean c_win;

// Estas variaveis controlam qual porta é a premiada e qual o jogador escolheu, alem dele ter vencido ou não

// Esse Enum controla em qual parte o jogo está
enum choiceState {intro, waitingChoice,ChoiceVideo,Reveal,End}


// Essa é a classe de cada porta
class door
{
  Vector2 pos = new Vector2(240);
  Vector2 size = new Vector2(100,int(100*4/3.));
  
  // A porta tem um botão, para poder detectar se foi apertada ou não
  button my_button;
  
  //O Contrutor da porta, leva como argumento o tamanho e posição
  door(Vector2 p, Vector2 s)
  {
    pos = p;
    size = s;
    //Cria um botão na mesma posição
    my_button = new button(p,s);
  }
  
  
  boolean selected;
  
  //essa função testa a porta se ela foi apertada ou não
  boolean test_button(Vector2 where)
  {
  boolean result = false;
  //testando o botão
  result  = my_button.test_pressed(where);
  return result;
 }
 
 // as portas são invisiveis
 void draw(){ 
 }
}

//Aqui é criado o array das portas e a variavel de estado do jogo
door[] Doors = new door[3];
choiceState currentChoiceState = choiceState.intro;


void c_setup()
{
 // Os botões globais são colocados em outra posição na tela
 bTm.pos = new Vector2(300-5-100-65,720-72);
 rset.pos = new Vector2(300+5+100-65,720-72);
 togMB.pos = new Vector2(640-10-500,720-72-(85));
 
 //Novamente colocamos como o estado de introdução e setamos variaveis
 currentChoiceState = choiceState.intro;
 c_win = false;
 // Carregar o primeiro vídeo e ja dar play
 intro = new Movie(this,"Videos/Intro.mp4");
  intro.play();
 //Carregar a primeira imagem
 introImg = loadImage("data/Videos/Intro_720p.jpg");
 // Criar as portas e definir a posição
 Doors[0] = new door(new Vector2(397+178/2,394+140),new Vector2(178,280));
 Doors[1] = new door(new Vector2(660+178/2,394+140),new Vector2(178,280));
 Doors[2] = new door(new Vector2(911+178/2,394+140),new Vector2(178,280));
 c_prize = int(random(3)); // Definir qual porta tem o premio
}

void c_tick()
{
  background(0);
  if(currentChoiceState == choiceState.intro)
  {
   //Se estivermos na intro, apenas passar o video
   image(intro,0,0); 
   if(intro.time() == intro.duration()){currentChoiceState = choiceState.waitingChoice;} 
  }
  if(currentChoiceState == choiceState.waitingChoice){
    //Aqui nos deixamos a imagem estática
    image(introImg,0,0);
    textSize(64);
    // Instrução
    text("Please Select a Door",640,144);
    
    //Se o mouse for apertado, vamos percorrer por todas as portas
    if(mousePressed && (mouseButton == LEFT))
    {
      for(int i =0; i<3;i++){
    
       //Testar se a porta foi apertada
      if(Doors[i].test_button(new Vector2(mouseX,mouseY)))
      {
       c_selection = i;
       currentChoiceState = choiceState.ChoiceVideo;
       
       //Aqui carregamos o video relativo a qual porta foi apertada
       // (os nomes são padronizados)
       doorA = new Movie(this,"Videos/door_" + str(i+1)+".mp4");
       doorA.play();
       // O break é para evitar que alguma outra porta de positivo
       break; 
      }}}}
  // Esse estágio é o que controla o vídeo do personagem andando até a porta
  if(currentChoiceState == choiceState.ChoiceVideo)
   {
   image(doorA,0,0);
   if(doorA.time() == doorA.duration()) // Quando o video acabar, mudar para o estado final
     { currentChoiceState = choiceState.Reveal;
     // Se a porta escolhida for a certa, fazer o load da imagem de vitoria
     if( c_selection == c_prize)
     {
      c_win = true;
      doorAImg = loadImage("data/Videos/door_"+ str(c_selection+1)+ "_win"+".jpg");
     } else
     //Caso contrario a imagem de derrota
     {doorAImg = loadImage("data/Videos/door_"+ str(c_selection+1)+ "_loose"+".jpg");}
 
   }
   }
   if(currentChoiceState == choiceState.Reveal)
   {
    //No ultimo estágio, para revelar, mostramos a imagem que foi carregada
    image(doorAImg,0,0,width,height); 
    textSize(64);
    // E colocamos o texto se o jogador ganhou ou perdeu
    if(c_win){text("You Win",640,144);}else{text("You Lost",640,144);}
   }
}



// Padrão do processing para ler frames dos videos
void movieEvent(Movie m) {
  m.read();
}
