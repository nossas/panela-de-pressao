Before do
  @user = double('User').as_null_object
  @user.stub(id: 1)
  @user.stub(phone: '(21) 9999-9999')
  @user.stub(email: 'nicolas@engage.is')
  @user.stub(avatar_url: '/assets/default-avatar.png')
  
  User.stub(:find_by_id) { @user }
  Poke.any_instance.stub(:user) { @user }
  Poke.any_instance.stub(:user_id) { @user.id }
  Campaign.any_instance.stub(:user) { @user }
  Campaign.any_instance.stub(:user_id) { @user.id }
end
