$(function(){
  $('#price').on('input', function(){
    var data = $('#price').val();
    if ((data >= 300) && (data <= 9999999)) {
      var profit = Math.round(data * 0.9)
      var fee = (data - profit)
      $('.sell-form__price--right__fee--right').html(fee)
      $('.sell-form__price--right__fee--right').prepend('¥')
      $('.sell-form__price--right__profit--right').html(profit.toLocaleString())
      $('.sell-form__price--right__profit--right').prepend('¥')
      $('#price').val(data)
    }
    else if(data == '') {
      $('.sell-form__price--right__profit--right').html('');
      $('.sell-form__price--right__fee--right').html('');
    }
  
  else if ((data >= 300) && (data <= 9999999)) {
    $('.sell-form__price--right__fee--right').html('');
    $('.sell-form__price--right__profit--right').html('');
  }
  })
})