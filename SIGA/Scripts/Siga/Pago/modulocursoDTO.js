
var Modulo = function (data) {
    this.ModId = data.ModId || 0;
    this.ModNivel = data.ModNivel || '';
    this.ModCategroria = data.ModCategroria || '';
    this.ModNombre = data.ModNombre || '';
    this.ModNumHoras = data.ModNumHoras || '';
    this.ModNumMes = data.ModNumMes || '';
    this.ModNumCursos = data.ModNumCursos || '';
    this.Cursos = $.map(data.Cursos, function (item) { return new Curso(item) });
    //this.Cursos = ko.observableArray(typeof (data.Cursos) == 'undefined' ? [] : $.map(data.Cursos, function (item) { return new Curso(item) }));
    
    return this;
}

var Curso = function (data) {
    this.CurId = ko.observable(data.CurId || 0);
    this.CurName = ko.observable(data.CurName || '');
    this.CurNumHoras = ko.observable(data.CurNumHoras || '');
    this.CurPrecio = ko.observable(data.CurPrecio || '');
    //this.SelectedEvent =  data.SelectedEvent || false);
}