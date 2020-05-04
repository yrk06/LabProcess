// Essa é a classe base dos botões
class button
{
 Vector2 size; // Vector 2 é outra classe base feita para o projeto
 Vector2 pos;
 float timeout = 1.0; // descontinuado, não foi utilizado no projeto
 float currentTime; // descontinuado (era usado com o timeout)
 boolean pressed = false; // Guarda o estado se o botão esta apertado ou não
 int totalpressed = 0; // COntrola quantas vezes o botão foi apertado no total
 String label = ""; // É o texto colocado no botão
 
 //Contrutor da classe
 button(Vector2 p,Vector2 s)
 {
   pos = p;
   size = s;
 }
 
 //Setter do Label
 void SetLabel(String New)
 {
  label = New; 
 }
 
 //função draw do botão, não precisa ser chamada para o botão funcionar (no jogo de escolhas
 // os botões são invisiveis)
 void Draw()
 {
  pressed = false; 
  fill(255);
  //Como temos o centro (pos) e o tamanho (size) podemos encontrar os 4 cantos do retangulo
  rect(pos.x-size.x/2.0,pos.y-size.y/2.0,size.x,size.y);
  //Se tiver um label, escrever ele no botão
  if(label != ""){
    fill(0);
    textSize(32);
    text(label,pos.x,pos.y);
  }
  // Se o botão fosse persistente, aqui é o condigo que controla o Timeout do botão 
  //até ser apertado de novo
  if(currentTime > 0){currentTime -= 1/60.;} 
 }
 
 //Essa função testa se o botão foi apertado
 boolean test_pressed(Vector2 where)
 {
   // primeiro testamos se o botão está em timeout ou não
   if(currentTime <= 0){
     //se não estiver, testamos a posição do mouse (Vector2 where) se esta dentro do Bounding box
     if(float(where.x) > pos.x-size.x/2.0 && float(where.x) < pos.x+size.x/2.0 && float(where.y) > pos.y-size.y/2.0 && float(where.y) < pos.y+size.y/2.0)
     {
       //Aqui se tiver tudo certo, aumentamos o total de apertados e colocamos o timeout
       currentTime = timeout;
       totalpressed++;
       
       // A função retorna verdadeiro pra sinalizar que foi apertado
       return true;
     }
     
   }
   // Se estivermos em timeout ou se não foi apertado, retornamos falso
     return false;
 }
  
}
