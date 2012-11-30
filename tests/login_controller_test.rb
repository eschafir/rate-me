require 'test/unit'
require 'mocha'
require_relative '../controllers/login_controller.rb'

class LoginControllerTest < Test::Unit::TestCase

    def test_create_account_should_save_user_when_unique

        # arrange
        username = "Nicolas"
        password = "Password!"
        password_confirmation = "Password!"
        user_repository = mock()
        user_repository.expects(:get_by_username).returns(nil)
        user_repository.expects(:save)

        controller = LoginController.new(user_repository)
        
        # act
        result =  controller.create_account(username, password, password_confirmation)

        # assert
        assert_equal("SUCCESS", result)
    end


    def test_create_account_should_not_save_user_when_duplicated

        # arrange
        username = "Nicolas"
        password = "Password!"
        password_confirmation = "Password!"
        user_repository = mock()
        user_repository.expects(:get_by_username).returns(true)

        controller = LoginController.new(user_repository)
        
        # act
        result =  controller.create_account(username, password, password_confirmation)

        # assert
        assert_equal("FAIL", result)
    end

    def test_create_account_should_not_save_user_when_passwords_not_match

        # arrange
        username = "Nicolas"
        password = "Password!"
        password_confirmation = "zaraza"

        controller = LoginController.new(nil)
        
        # act
        result =  controller.create_account(username, password, password_confirmation)

        # assert
        assert_equal("FAIL", result)
    end

    def test_log_in_when_user_exists_and_his_password_is_correct
      
       # arrange
       username = "Nicolas5"
       password = "Password"

       user_repository = mock()
       user_repository.expects(:get_by_username).returns(User.new("Nicolas5","Password"))

       controller = LoginController.new(user_repository)

       #  act
       result = controller.log_in(username, password)

       #  assert
       assert_equal("WELCOME", result)
    end

    def test_log_in_when_user_exists_and_his_password_is_incorrect
      
       # arrange
       username = "Nicolas5"
       password = "Passwor"

       user_repository = mock()
       user_repository.expects(:get_by_username).returns(User.new("Nicolas5","Password"))

       controller = LoginController.new(user_repository)

       #  act
       result = controller.log_in(username, password)

       #  assert
       assert_equal("FAIL", result)
    end

end

