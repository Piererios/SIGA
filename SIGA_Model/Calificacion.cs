//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace SIGA_Model
{
    using System;
    using System.Collections.Generic;
    
    public partial class Calificacion
    {
        public int CalifId { get; set; }
        public int Prof_Id { get; set; }
        public int Alu_Id { get; set; }
        public int ModId { get; set; }
        public int Cur_Id { get; set; }
        public Nullable<System.DateTime> Cal_Fech { get; set; }
        public string Cal_N1 { get; set; }
        public Nullable<decimal> Cal_N2 { get; set; }
        public Nullable<decimal> Cal_N3 { get; set; }
        public Nullable<decimal> Cal_N4 { get; set; }
        public Nullable<decimal> Cal_N5 { get; set; }
        public Nullable<decimal> Cal_N6 { get; set; }
    
        public virtual Alumno Alumno { get; set; }
        public virtual Curso Curso { get; set; }
        public virtual Modulo Modulo { get; set; }
        public virtual Profesor Profesor { get; set; }
    }
}
