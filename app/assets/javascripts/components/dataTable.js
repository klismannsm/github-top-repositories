(function(Components) {
  var DataTable = function(element) {
    var $element = $(element);

    $element.dataTable( {
      'processing': true,
      'serverSide': true,
      'ajax': {
        'url': $element.data('source')
      },
      'pagingType': 'full_numbers',
      'columns': $element.data('datatables-columns'),
      'language': {
        'sEmptyTable': 'Nenhum registro encontrado',
        'sInfo': 'Mostrando de _START_ até _END_ de _TOTAL_ registros',
        'sInfoEmpty': 'Mostrando 0 até 0 de 0 registros',
        'sInfoFiltered': '',
        'sInfoPostFix': '',
        'sInfoThousands': '.',
        'sLengthMenu': '_MENU_ resultados por página',
        'sLoadingRecords': 'Carregando ...',
        'sProcessing': 'Processando ...',
        'sZeroRecords': 'Nenhum registro encontrado',
        'sSearch': 'Pesquisar',
        'oPaginate':  {
          'sNext': 'Próximo',
          'sPrevious': 'Anterior',
          'sFirst': 'Primeiro',
          'sLast': 'Último'
        },
        'oAria': {
          'sSortAscending': ': Ordenar colunas de forma ascendente',
          'sSortDescending': ': Ordenar colunas de forma descendente'
        }
      }
    });
  }

  Components.DataTable = DataTable;
})(Components);
