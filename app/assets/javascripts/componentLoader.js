$document.ready(function() {
  var componentName = null;
  $('[data-component]').each(function(index, element) {
    var $element = $(element);
    componentName = $element.data('component');
    new Components[componentName](element);
  });
});
