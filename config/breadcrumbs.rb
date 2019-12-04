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

crumb :user_logout do
  link 'ログアウト', user_path(current_user.id)
  parent :user_show
end