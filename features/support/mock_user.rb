# coding: utf-8

Before do
  facebook_authorization = double('facebook_authorization', token: "123")

  @mock_user = mock_model(
    User, 
    admin?: false, 
    avatar_url: "/assets/default-avatar.png", 
    name: "Nícolas Iensen", 
    phone: "(21) 9232-1233", 
    email: "foo1@bar.com",
    has_poked: false,
    can_poke?: true,
    facebook_authorization: facebook_authorization
  )

  User.stub(:find_by_id).and_return @mock_user
  Campaign.any_instance.stub(:user).and_return @mock_user
  Authorization.any_instance.stub(:user).and_return @mock_user
  Update.any_instance.stub(:user).and_return @mock_user
end
