class SendMethod < ActiveHash::Base
  self.data = [
    {id: 1, text: '未定'},
    {id: 2, text: 'らくらくメルカリ便'},
    {id: 3, text: 'ゆうメール'},
    {id: 4, text: 'レターパック'},
    {id: 5, text: '普通郵便(定形、定形外)'},
    {id: 6, text: 'クロネコヤマト'},
    {id: 7, text: 'ゆうパック'},
    {id: 8, text: 'クリックポスト'},
    {id: 9, text: 'ゆうパケット'}
  ]
end