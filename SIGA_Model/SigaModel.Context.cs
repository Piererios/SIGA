﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class SIGAEntities : DbContext
    {
        public SIGAEntities()
            : base("name=SIGAEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<Administrador> Administrador { get; set; }
        public virtual DbSet<Alumno> Alumno { get; set; }
        public virtual DbSet<Aula> Aula { get; set; }
        public virtual DbSet<Calificacion> Calificacion { get; set; }
        public virtual DbSet<Curso> Curso { get; set; }
        public virtual DbSet<Horario> Horario { get; set; }
        public virtual DbSet<Matricula> Matricula { get; set; }
        public virtual DbSet<Modulo> Modulo { get; set; }
        public virtual DbSet<Pago> Pago { get; set; }
        public virtual DbSet<Persona> Persona { get; set; }
        public virtual DbSet<Profesor> Profesor { get; set; }
        public virtual DbSet<Programacion> Programacion { get; set; }
        public virtual DbSet<Recibo> Recibo { get; set; }
        public virtual DbSet<sysdiagrams> sysdiagrams { get; set; }
        public virtual DbSet<TipoUsuario> TipoUsuario { get; set; }
        public virtual DbSet<Usuario> Usuario { get; set; }
        public virtual DbSet<Author> Author { get; set; }
    
        public virtual int Profesor_Get()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Profesor_Get");
        }
    
        public virtual int Profesor_Insert(Nullable<int> per_Dni, string per_Nombre, string per_ApePaterno, string per_ApeMaterno, string per_Sexo, string per_Dir, string per_Cel, string per_Tel, string per_Email, Nullable<int> tipoUser_ID, string user_Nombre, string user_Pass, Nullable<int> cur_Id, string prof_Especialidad)
        {
            var per_DniParameter = per_Dni.HasValue ?
                new ObjectParameter("Per_Dni", per_Dni) :
                new ObjectParameter("Per_Dni", typeof(int));
    
            var per_NombreParameter = per_Nombre != null ?
                new ObjectParameter("Per_Nombre", per_Nombre) :
                new ObjectParameter("Per_Nombre", typeof(string));
    
            var per_ApePaternoParameter = per_ApePaterno != null ?
                new ObjectParameter("Per_ApePaterno", per_ApePaterno) :
                new ObjectParameter("Per_ApePaterno", typeof(string));
    
            var per_ApeMaternoParameter = per_ApeMaterno != null ?
                new ObjectParameter("Per_ApeMaterno", per_ApeMaterno) :
                new ObjectParameter("Per_ApeMaterno", typeof(string));
    
            var per_SexoParameter = per_Sexo != null ?
                new ObjectParameter("Per_Sexo", per_Sexo) :
                new ObjectParameter("Per_Sexo", typeof(string));
    
            var per_DirParameter = per_Dir != null ?
                new ObjectParameter("Per_Dir", per_Dir) :
                new ObjectParameter("Per_Dir", typeof(string));
    
            var per_CelParameter = per_Cel != null ?
                new ObjectParameter("Per_Cel", per_Cel) :
                new ObjectParameter("Per_Cel", typeof(string));
    
            var per_TelParameter = per_Tel != null ?
                new ObjectParameter("Per_Tel", per_Tel) :
                new ObjectParameter("Per_Tel", typeof(string));
    
            var per_EmailParameter = per_Email != null ?
                new ObjectParameter("Per_Email", per_Email) :
                new ObjectParameter("Per_Email", typeof(string));
    
            var tipoUser_IDParameter = tipoUser_ID.HasValue ?
                new ObjectParameter("TipoUser_ID", tipoUser_ID) :
                new ObjectParameter("TipoUser_ID", typeof(int));
    
            var user_NombreParameter = user_Nombre != null ?
                new ObjectParameter("User_Nombre", user_Nombre) :
                new ObjectParameter("User_Nombre", typeof(string));
    
            var user_PassParameter = user_Pass != null ?
                new ObjectParameter("User_Pass", user_Pass) :
                new ObjectParameter("User_Pass", typeof(string));
    
            var cur_IdParameter = cur_Id.HasValue ?
                new ObjectParameter("Cur_Id", cur_Id) :
                new ObjectParameter("Cur_Id", typeof(int));
    
            var prof_EspecialidadParameter = prof_Especialidad != null ?
                new ObjectParameter("Prof_Especialidad", prof_Especialidad) :
                new ObjectParameter("Prof_Especialidad", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Profesor_Insert", per_DniParameter, per_NombreParameter, per_ApePaternoParameter, per_ApeMaternoParameter, per_SexoParameter, per_DirParameter, per_CelParameter, per_TelParameter, per_EmailParameter, tipoUser_IDParameter, user_NombreParameter, user_PassParameter, cur_IdParameter, prof_EspecialidadParameter);
        }
    
        public virtual int sp_alterdiagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_alterdiagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_creatediagram(string diagramname, Nullable<int> owner_id, Nullable<int> version, byte[] definition)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var versionParameter = version.HasValue ?
                new ObjectParameter("version", version) :
                new ObjectParameter("version", typeof(int));
    
            var definitionParameter = definition != null ?
                new ObjectParameter("definition", definition) :
                new ObjectParameter("definition", typeof(byte[]));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_creatediagram", diagramnameParameter, owner_idParameter, versionParameter, definitionParameter);
        }
    
        public virtual int sp_dropdiagram(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_dropdiagram", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagramdefinition_Result> sp_helpdiagramdefinition(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagramdefinition_Result>("sp_helpdiagramdefinition", diagramnameParameter, owner_idParameter);
        }
    
        public virtual ObjectResult<sp_helpdiagrams_Result> sp_helpdiagrams(string diagramname, Nullable<int> owner_id)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<sp_helpdiagrams_Result>("sp_helpdiagrams", diagramnameParameter, owner_idParameter);
        }
    
        public virtual int sp_renamediagram(string diagramname, Nullable<int> owner_id, string new_diagramname)
        {
            var diagramnameParameter = diagramname != null ?
                new ObjectParameter("diagramname", diagramname) :
                new ObjectParameter("diagramname", typeof(string));
    
            var owner_idParameter = owner_id.HasValue ?
                new ObjectParameter("owner_id", owner_id) :
                new ObjectParameter("owner_id", typeof(int));
    
            var new_diagramnameParameter = new_diagramname != null ?
                new ObjectParameter("new_diagramname", new_diagramname) :
                new ObjectParameter("new_diagramname", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_renamediagram", diagramnameParameter, owner_idParameter, new_diagramnameParameter);
        }
    
        public virtual int sp_upgraddiagrams()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("sp_upgraddiagrams");
        }
    
        public virtual int Usuario_Get(Nullable<int> userID, string primerNombre, string apellidoPaterno, string email, string tipoUsuario)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(int));
    
            var primerNombreParameter = primerNombre != null ?
                new ObjectParameter("PrimerNombre", primerNombre) :
                new ObjectParameter("PrimerNombre", typeof(string));
    
            var apellidoPaternoParameter = apellidoPaterno != null ?
                new ObjectParameter("ApellidoPaterno", apellidoPaterno) :
                new ObjectParameter("ApellidoPaterno", typeof(string));
    
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var tipoUsuarioParameter = tipoUsuario != null ?
                new ObjectParameter("TipoUsuario", tipoUsuario) :
                new ObjectParameter("TipoUsuario", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("Usuario_Get", userIDParameter, primerNombreParameter, apellidoPaternoParameter, emailParameter, tipoUsuarioParameter);
        }
    }
}
