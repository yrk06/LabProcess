/* Essa classe foi a primeira a ser contruida
    é um vetor bidimensional. ela seria importante caso eu tivesse que lidar com
    movimento de posições. poderia simplesmente escrever aqui apenas uma função de soma
    ou de comprimento do verto sem me preocupar em escrever a mesma função varias vezes*/
    
class Vector2
{
 int x;
 int y;
 
 /* a classe suporta 2 construtores 
 para iniciar com 2 valores diferentes ou um valor igual*/
 Vector2(int value)
 {
  x = value;
  y = value;
 }
 Vector2(int valueX, int valueY)
 {
  x = valueX;
  y = valueY;
 } 
  
}
