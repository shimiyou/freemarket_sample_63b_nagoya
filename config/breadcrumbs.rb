# パンくずの階層
crumb :root do
  link 'メルカリ', root_path
end

crumb :user_show do
  link 'マイページ', user_path(current_user.id)
  parent :root
end

crumb :user_edit do
  link 'プロフィール', user_path(current_user.id)
  parent :user_show
end

crumb :user_check do
  link '本人情報の登録', user_path(current_user.id)
  parent :user_show
end

crumb :user_logout do
  link 'ログアウト', user_path(current_user.id)
  parent :user_show
end

crumb :item_path do
  @item = Item.find(params[:id])
  link @item.name, item_path
  parent :root
end