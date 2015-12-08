
var layoutVM = null;
var layoutViewModel = function () {
    layoutVM = this;
    evalViewport(); // This is contained in the master page _layout to hold a .js version of bootraps's sizing in use. is set the javascript var 'viewport'
    layoutVM.viewport = ko.observable(viewport); // adjusts later using window.onresize
    layoutVM.contextMenuType = ko.observable('contextMain');
    layoutVM.breadCrumbs = ko.observableArray([]);
    layoutVM.currentUser = ko.observable({})
    layoutVM.mainContainerType = ko.observable('home');

    layoutVM.selectMenuItemNumber = ko.observable(0);
    layoutVM.lastCall_setActiveItem = 0;

    layoutVM.confirmDialog = ko.observable(false);
    layoutVM.confirmMessage = ko.observable('');
    layoutVM.confirmButton = ko.observable('');
    layoutVM.confirmResult = false;
    layoutVM.confirmTitle = ko.observable('');
    layoutVM.confirmTarget = "";
    layoutVM.confirmButtonOk = ko.observable('');
    layoutVM.confirmButtonCancel = ko.observable('');

    layoutVM.alertDialog = ko.observable(false);
    layoutVM.alertMessage = ko.observable('');
    layoutVM.alertTitle = ko.observable('');
    layoutVM.alertTarget = "";
    layoutVM.alertButtonOk = ko.observable('');

    layoutVM.clearConfirm = function () {
        layoutVM.confirmDialog(false);
    }

    layoutVM.clearAlert = function () {
        layoutVM.alertDialog(false);
    }

    layoutVM.errorMessage = ko.observable(false);
    layoutVM.togglePlus = function () {
        $(event.target).toggleClass('fa-plus-square-o fa-minus-square-o');
    }

    layoutVM.soporteMenuitems = ko.observableArray([
        { name: 'Usuario' },
        { name: 'Modulo Curso' },
        { name: 'Programacion' }
    ]);

    layoutVM.procesoMenuitems = ko.observableArray([
        { name: 'Registro Matricula' },
        { name: 'Calificaciones' }
    ]);

    layoutVM.horarioMenuitems = ko.observableArray([
        { name: 'Horario por Curso' },
        { name: 'Horario por Aula' }
    ]);

    layoutVM.pagoMenuitems = ko.observableArray([
        { name: 'Registrar Pago' }
    ]);

    layoutVM.menuClick = function (data, event) {
        if (data.name == "Usuario") {
            loadUsuario();
        }
        else if (data.name == "Modulo Curso") {
            loadModuloCurso();
        }
        else if (data.name == "Programacion") {
            loadProgramacion();
        }
        else if (data.name == "Registro Matricula") {
            location.href = 'http://dev-sigaeducando.com/Matricula';
        }
        else if (data.name == "Calificaciones") {
            location.href = 'http://dev-sigaeducando.com/Calificacion';
        }
        else if (data.name == "Registrar Pago") {
            location.href = 'http://dev-sigaeducando.com/Pago';
        }
    };
    
}


function setActiveItem(target) {

    var now = new Date();
    var lastCallTime = layoutVM.lastCall_setActiveItem;
    if (lastCallTime != null && ((now - layoutVM.lastCall_setActiveItem) / 2000) < 1) return;
    layoutVM.lastCall_setActiveItem = now;

    layoutVM.selectMenuItemNumber(target);
    return true;
}

window.onresize = function () {
    evalViewport();
    layoutVM.viewport(viewport); 
}

var viewport = null;
function evalViewport() {
    viewport = $(".viewport:visible").html(); // find the visible span based on native bootstrap classes
    $("#viewport").html(viewport);
    $("#jqWidth").html($(window).width());
    return;
}

function loadUsuario() {

    var txtPrimerNombre = ($("#txtPrimerNombre").val() == null || $("#txtPrimerNombre").val() == "")
                        ? "" : $("#txtPrimerNombre").val();

    var txtApellidoPaterno = ($("#txtApellidoPaterno").val() == null || $("#txtApellidoPaterno").val() == "")
                        ? "" : $("#txtApellidoPaterno").val();

    var txtEmail = ($("#txtEmail").val() == null || $("#txtEmail").val() == "")
                        ? "" : $("#txtEmail").val();

    var cboTipoUsuario = ($("#cboTipoUsuario").val() == null || $("#cboTipoUsuario").val() == "")
                        ? "Todos" : $("#cboTipoUsuario").val();


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

function loadModuloCurso() {
    $("#mainContainer").load('/ModuloCurso');
    //var mcVM = new modulocursoViewModel();
    //ko.applyBindings(mcVM, $('#ModuloCurso')[0]);
    //mcVM.getModulos();
}

function loadProgramacion() {

    var txtProgNombre = ($("#txtProgNombre").val() == null || $("#txtProgNombre").val() == "")
                        ? "" : $("#txtProgNombre").val();

    var txtModuloNombre = ($("#txtModuloNombre").val() == null || $("#txtModuloNombre").val() == "")
                        ? "" : $("#txtModuloNombre").val();

    var params = new Array();
    params.push("?progNombre=" + encodeURI(txtProgNombre));
    params.push("moduloNombre=" + encodeURI(txtModuloNombre));

    $("#mainContainer").load('/Programacion/Programacion' + params.join('&'), function (response, status, xhr) {
        if (status == "error") {
            var msg = "Sorry but there was an error: ";
            $("#error").html(msg + xhr.status + " " + xhr.statusText);
        }
    });
    return true;
}

function confirmDialogCallBack() {
    layoutVM.clearConfirm();
}

function showConfirmDialog(callback, title, message, okButtonText, cancelButtonText, param1) {

    layoutVM.dialogReturnVal = null;

    layoutVM.confirmTarget = callback;
    layoutVM.confirmTargetObject = param1;

    layoutVM.confirmTitle(title);
    layoutVM.confirmMessage(message);

    layoutVM.confirmButtonOk(okButtonText);
    layoutVM.confirmButtonCancel(cancelButtonText);
    layoutVM.confirmDialog(true);

}

function showAlertDialog(title, message, okButtonText, param1) {

    layoutVM.alertTitle(title);
    layoutVM.alertMessage(message);

    layoutVM.alertButtonOk(okButtonText);
    layoutVM.alertDialog(true);

}