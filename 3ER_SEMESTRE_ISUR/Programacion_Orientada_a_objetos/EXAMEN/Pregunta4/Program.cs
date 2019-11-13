using System;
using System.Collections.Generic;

namespace Pregunta4
{
    interface IEquatable<Ingrediente>
    {
        bool Equals(Ingrediente t);
    }
    interface IComparable<Ingrediente>
    {
        int CompareTo(Ingrediente T);
    }

    public delegate void CriterioOrdenamiento();
    class Pastel{
        private List<Ingrediente> ListaIngredientes=new List<Ingrediente>();
        private string _strNombre;
        public string Nombre
        {
            get { return _strNombre; }
            set { _strNombre = value; }
        }
        public void AgregarIngrediente(Ingrediente ingre){
            ListaIngredientes.Add(ingre);
        }
        public bool EliminarIngrediente(Ingrediente ingre){
            if(ingre != null){
                ListaIngredientes.Remove(ingre);
                return true;
            }
            return false;
        }
        ~Pastel(){

        }

        public override string ToString(){
            return $"Este es una pastel {this.Nombre}";
        }

        public void Ascendente(){
            
        }

        public void Descendente(){
            
        }
        public CriterioOrdenamiento Ctr;

        public void OrdenarIngrediente(CriterioOrdenamiento ctr){
            Ctr=new CriterioOrdenamiento(ctr);
            Ctr();
        }



        
    }
    class Ingrediente:IEquatable<Ingrediente>,IComparable<Ingrediente>{

        private string _strNombre;
        private double _dblCantidad;
        public string Nombre
        {
            get { return _strNombre; }
            set { _strNombre = value; }
        }
        public double Cantidad
        {
            get { return _dblCantidad; }
            set { _dblCantidad = value; }
        }
        

        public bool Equals(Ingrediente Ingre)
        {
            
            if (Ingre == null || GetType() != Ingre.GetType())
            {
                return false;
            }
            
            
            return true;
        }
        public int CompareTo(Ingrediente Ingre){
            return 1;
        }
        
        public override string ToString(){
            return $"El Objeto ingrediente es {this.Nombre} y hay una cantidad {this.Cantidad}";
        }

        
    }

    class Program
    {
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello World!");
            Pastel p1=new Pastel();
            p1.OrdenarIngrediente(p1.Ascendente);
        }
    }
}
