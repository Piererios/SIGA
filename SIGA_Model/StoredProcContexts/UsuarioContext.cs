﻿using System.Data.Entity;
using CodeFirstStoredProcs;

namespace SIGA_Model.StoredProcContexts
{
    public partial class UsuarioContext : DbContext
    {
        static UsuarioContext()
        {
            Database.SetInitializer<UsuarioContext>(null);
        }

        public UsuarioContext()
            : base("Name=SIGAConnection")
        {
            this.InitializeStoredProcs();
        }

        [StoredProcAttributes.Name("[Usuario.Get]")]
        [StoredProcAttributes.Schema("[dbo]")]
        [StoredProcAttributes.ReturnTypes(typeof(UsuarioInformation))]
        public StoredProc<UsuarioInfoInputParams> getUsuarios { get; set; }

    }
}
