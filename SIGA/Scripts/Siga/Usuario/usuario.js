﻿var usuarioVM = null;

function usuarioViewModel(usuario) {
    
    usuarioVM = this;

    usuarioVM.ReturnStatus = ko.observable();

    usuarioVM.nombre = ko.observable('Binding is working');

    usuarioVM.tipoUsuarioSelected = ko.observable();

    usuarioVM.setTipoUsuarioSelected = function (data) {
        usuarioVM.tipoUsuarioSelected(data);
        $('#li' + data + '').addClass('active');
        $('#li' + data + ' a').css('color', '#2c7ecc', 'font-weight','bold');
        $('#tipoUsuarioPanel li').not('#li' + data + '').removeClass('active');
        $('#tipoUsuarioPanel li a').not('#li' + data + ' a').css('color', '#454242');
    }

    usuarioVM.usuarioList = ko.observableArray([]);

    usuarioVM.showActionResponseContent = ko.observable(false);

    usuarioVM.tipoUsuarioClick = ko.observable();

    usuarioVM.tipoUsuarioItems = ko.observableArray([
        { name: 'Alumno' },
        { name: 'Profesor' },
        { name: 'Administrador' }
    ]);

    usuarioVM.searchUsuario = function () {
        searchUsuario();
    };

    usuarioVM.createUsuario = function () {
        LoadCreateViewForUsuario();
    };

    usuarioVM.saveCompleted = ko.observable(false);

    usuarioVM.sending = ko.observable(false);
    
    usuarioVM.isCreating = usuario.UsuarioItem.user_id == 0;
    
    usuarioVM.usuario = {
            user_id: usuario.UsuarioItem.user_id,
            per_nombre: ko.observable(usuario.UsuarioItem.per_nombre),
            per_apepaterno: ko.observable(usuario.UsuarioItem.per_apepaterno),
            per_apematerno: ko.observable(usuario.UsuarioItem.per_apematerno),
            per_email: ko.observable(usuario.UsuarioItem.per_email),
            per_dni: ko.observable(usuario.UsuarioItem.per_dni),
            per_dir: ko.observable(usuario.UsuarioItem.per_dir),
            per_cel: ko.observable(usuario.UsuarioItem.per_cel),
            per_tel: ko.observable(usuario.UsuarioItem.per_tel),
            per_sexo: ko.observable(usuario.UsuarioItem.per_sexo),
            tipouser_descrip: ko.observable(usuarioVM.tipoUsuarioSelected),
            alu_apoderado: ko.observable(usuario.UsuarioItem.alu_apoderado),
            alu_fechaingreso: ko.observable(usuario.UsuarioItem.alu_fechaingreso),
            alu_fecharegistro: ko.observable(usuario.UsuarioItem.alu_fecharegistro),
        },

    usuarioVM.validateAndSave = function (form) {
        if (!$(form).valid())
            return false;

        usuarioVM.sending(true);

        $.ajax({
            url: '/api/usuario',
            type: (usuarioVM.isCreating) ? 'Post' : 'Put',
            contentType: 'application/json',
            data: ko.toJSON(usuarioVM.usuario)
        }) 
        .success(usuarioVM.successfulSave) 
        .error(usuarioVM.errorSave)
        .complete(function () { usuarioVM.sending(false) });
    };

    usuarioVM.successfulSave = function () {
        usuarioVM.saveCompleted(true);
        
        $('.body-content').prepend('<div class="alert alert-success"><strong>Success!</strong> El Usuario fue guardado con exito.</div>');
        setTimeout(function () {
            if (usuarioVM.isCreating)
                //location.href = '/';
                loadUsuario();
            else
                loadUsuario();
        }, 1000);
    };

    usuarioVM.errorSave = function () {
        $('.body-content').prepend('<div class="alert alert-danger"><strong>Error!</strong> Se produjo un error al guardar los datos del usuario.UsuarioItem.</div>');
    };

    usuarioVM.resetFilters = function () {
        resetFilters();
    };

    usuarioVM.editUsuario = function (userid) {
        editUsuario(userid);
    };

}

function searchUsuario() {
    var searchParam = ($(".paf-menu-item.active").attr('data-id') == null || $(".paf-menu-item.active").attr('data-id') == "")
                        ? "" : "type:'" + $(".paf-menu-item.active").attr('data-id') + "'";

    var txtPrimerNombre = ($("#txtPrimerNombre").val() == null || $("#txtPrimerNombre").val() == "")
                        ? searchParam : $("#txtPrimerNombre").val();

    var txtApellidoPaterno = ($("#txtApellidoPaterno").val() == null || $("#txtApellidoPaterno").val() == "")
                        ? searchParam : $("#txtApellidoPaterno").val();

    var txtEmail = ($("#txtEmail").val() == null || $("#txtEmail").val() == "")
                        ? searchParam : $("#txtEmail").val();

    var cboTipoUsuario = ($("#cboTipoUsuario").val() == null || $("#cboTipoUsuario").val() == "")
                        ? searchParam : $("#cboTipoUsuario").val();


    var params = new Array();
    params.push("?primerNombre=" + encodeURI(txtPrimerNombre));
    params.push("apellidoPaterno=" + encodeURI(txtApellidoPaterno));
    params.push("email=" + encodeURI(txtEmail));
    params.push("tipoUSuario=" + encodeURI(cboTipoUsuario));

    $("#usuarioSubContainer").load('/usuario/UsuarioList' + params.join('&'));

}

function LoadCreateViewForUsuario() {
    $("#mainContainer").load('/usuario/create');
    return;
}

function resetFilters() {
    $('#txtPrimerNombre').val('');
    $('#txtApellidoPaterno').val('');
    $('#txtEmail').val('');
    $('#cboTipoUsuario').val('Todos');
    searchUsuario();
    return;
}

function editUsuario(userid) {
    $("#mainContainer").load('/Usuario/Edit?userid=' + userid);
    return;
}

function loadUsuario() {

    var txtPrimerNombre = "";
    var txtApellidoPaterno = "";
    var txtEmail = "";
    var cboTipoUsuario = "Todos"

    var params = new Array();
    params.push("?primerNombre=" + encodeURI(txtPrimerNombre));
    params.push("apellidoPaterno=" + encodeURI(txtApellidoPaterno));
    params.push("email=" + encodeURI(txtEmail));
    params.push("tipoUSuario=" + encodeURI(cboTipoUsuario));

    $("#mainContainer").load('/Usuario/Usuario' + params.join('&'), function (response, status, xhr) {
        if (status == "error") {
            var msg = "Sorry but there was an error: ";
            $("#error").html(msg + xhr.status + " " + xhr.statusText);
        }
    });
    return true;

}

//function saveNewUsuario() {
    
//    $.ajax({
//        url: '',
//        type: 'POST',
//        cache: false,
//        data: jQuery("#UsuarioCreateForm").serialize(),
//        success: function (result) {
//            // do accordingly as per your result                 
//        }
//    });
//}


//function settipo(data) {
//    usuarioVM.tipoUsuarioSelected = data;
//}

