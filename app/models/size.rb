class Size < ActiveHash::Base
  self.data = [
    {id: 1, text: 'XXS以下'},
    {id: 2, text: 'XS(SS)'},
    {id: 3, text: 'S'},
    {id: 4, text: 'M'},
    {id: 5, text: 'L'},
    {id: 6, text: 'XL(LL)'},
    {id: 7, text: '2XL(3L)'},
    {id: 8, text: '3XL(4L)'},
    {id: 9, text: '4XL(5L)以上'},
    {id: 10, text: 'FREE SIZE'}
  ]
end