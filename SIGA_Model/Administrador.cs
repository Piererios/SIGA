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
    
    public partial class Administrador
    {
        public int Adm_ID { get; set; }
        public int User_Id { get; set; }
        public string Adm_Area { get; set; }
        public string Adm_Rpm { get; set; }
        public string Adm_Nextel { get; set; }
    
        public virtual Usuario Usuario { get; set; }
    }
}
