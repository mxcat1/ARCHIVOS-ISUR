using System;

namespace Pregunta3
{
    class Taller{
        public Automovil[] AutomovilesTaller;
        public Taller(int cantiaforo){
            AutomovilesTaller=new Automovil[cantiaforo];
        }
        public Automovil this[int x]
        {
            get { return AutomovilesTaller[x]; }
            set { AutomovilesTaller[x]=value; }
        }
    }

    class Automovil{
        private string _marca;
        private int _anio;
        private string _modelo;

        public LLanta[] LLantasAutomovil;
        public Motor MotorAutomovil;
        public Puerta[] PuertasAutomovil;

        public Automovil(LLanta[] llantas, Motor motor,Puerta[] puertas){
            LLantasAutomovil=llantas;
            MotorAutomovil=motor;
            PuertasAutomovil=puertas;

        }
        public string Marca {get{return _marca;}set{_marca=value;}}
        public int Anio {get{return _anio;}set{_anio=value;}}
        public string Modelo {get{return _modelo;}set{_modelo=value;}}
    }
    class LLanta{
        private string _marca;
        private string _modelo;
        private int _tamaniopulgadas;

        public LLanta(){

        }
        public string Marca
        {
            get { return _marca; }
            set { _marca = value; }
        }
        public string Modelo
        {
            get { return _modelo; }
            set { _modelo = value; }
        }
        public int Tamaniopulgadas
        {
            get { return _tamaniopulgadas; }
            set { _tamaniopulgadas = value; }
        }
        
        
        
    }
    class Motor{

        private string _numeroserie;
        private int _cilindros;
        public Motor(){

        }
        public string Numeroserie
        {
            get { return _numeroserie; }
            set { _numeroserie = value; }
        }
        public int Cilindros
        {
            get { return _cilindros; }
            set { _cilindros = value; }
        }
        
        
    }
    class Puerta{
        private string _tipo;

        public Puerta(){

        }
        public string Tipo
        {
            get { return _tipo; }
            set { _tipo = value; }
        }
        
    }



    class Program
    {
        static void Main(string[] args)
        {
            
        }
    }
}
