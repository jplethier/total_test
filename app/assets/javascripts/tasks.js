$('body').on('click', 'ul.tasks li a.edit', function(){
  $(this).parent().find('.input').show()
  $(this).parent().find('.label').hide()
})

$('body').on('click', 'ul.tasks li a.cancel', function(){
  $(this).parents().find('li').find('.input').hide()
  $(this).parents().find('li').find('.label').show()
})
