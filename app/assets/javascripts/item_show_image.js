$(function() {
  $('.item__page__data__photo-box__photos__main').mouseover(function(){
    var selectedSrc = $(this).attr('src')
  $('.item__page__data__photo-box__photo__image').stop().fadeOut(100,
    function(){
    $('.item__page__data__photo-box__photo__image').attr('src', selectedSrc);
    $('.item__page__data__photo-box__photo__image').stop().fadeIn(100);
  }
  );
  $(this).css({"border":"1px solid #fff"});
  });
  $('.item__page__data__photo-box__photos__main').mouseout(function(){
    $(this).css({"border":""});
  });
 });