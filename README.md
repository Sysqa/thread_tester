ThreadTester
============

Test a webpage throughput with rspec and capybara on more than one threads.

Used gems
---------
```ruby
gem install rspec
gem install selenium-webdriver
gem install capybara
gem install capybara-webkit
```

Useage
------
Edit the `spec/test_threadsafe_spec.rb` file, e.g.

```ruby
describe "Thread Tester" do
  before(:all) { @users_num = 5 }
  
  context "user signed in" do
    # Selenium use FireFox. 1 session / 1 firefox / 100 MB memory
    # 10 session ~ 1 GB memory useage
    before(:all) do
      @users = create_user_sessions(@users_num)
      visit_localpage(@users)
    end
    
    after(:all) { close_sessions(@users) }
    
    # Should have valid users at this point.
    it "testing signin process with threads" do
      @users.with_threads do |n|
        n.visit "http://localhost:3000"
        n.fill_in "email", with: "testuser#{@users.key(n)}@test.hu"
        n.fill_in "password", with: "test"
        n.click_on "Login"
      end
    end
  end
end
```

Run the next command.

```
rspec spec --color
```
