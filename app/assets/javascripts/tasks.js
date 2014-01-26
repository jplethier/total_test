$('ul.tasks li a.edit').click(function(){
  $(this).parent().find('.input').show()
  $(this).parent().find('.label').hide()
})

$('ul.tasks li a.cancel').click(function(){
  $(this).parents().find('li').find('.input').hide()
  $(this).parents().find('li').find('.label').show()
})
