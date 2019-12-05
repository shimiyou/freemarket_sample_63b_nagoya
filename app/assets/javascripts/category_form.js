$(document).on('turbolinks:load', function() {
  function buildHTML() {
    var html = `<%= f.collection_select :category_id, @parents, :id, :name, {prompt: '---'}, {class: 'form-select form-style select-default', id: "parent-form", name: 'item[category_id][]'} %>`
    return html;
  }

  $("#parent-form").on("change",function(e){
    e.preventDefault();
    var parentValue = document.getElementById("parent-form").value;
    $.ajax({
      url: '/items/category',
      type: "GET",
      data: {
        parent_id: parentValue
      },
      dataType: 'json'
    })
  })

  .done(function(data) {
    var html = buildHTML(data);
    $('.sell-form__item__detail__content__category').append(html)
  })
  .fail(function(){
    alert('error');
  })
})