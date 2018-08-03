require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar", password_confirmation: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "      "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name can be long" do
    @user.name = "a" * 50
    assert @user.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email can be long" do
    @user.email = "a" * 243 + "@example.com"
    assert @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "invalid addresses" do
    valid_addresses = %w[u U@ user.foo.org user.name@example. foo@bar+baz.com]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert_not @user.valid?, "#{valid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email address should be saved as lower-case" do
    mixed_case_email = "LanceJohnson@SomewhereJFJKD.coM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password can be long" do
    @user.password = @user.password_confirmation = "a" * 6
    assert @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "valid password authenticates" do
    password = "myPassword"
    @user.password = password
    @user.password_confirmation = password
    @user.save
    @user.reload

    assert @user.authenticate(password)
  end

  test "invalid password does not authenticate" do
    password = "myPassword"
    @user.password = password
    @user.password_confirmation = password
    @user.save
    @user.reload

    assert_not @user.authenticate("bad")
  end
end
