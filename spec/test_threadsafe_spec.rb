require 'spec_helper'

describe "Thread Tester" do
  before(:all) { @users_num = 5 }

  context "user not signed in" do
    # Selenium use FireFox. 1 session / 1 firefox / 100 MB memory
    # 10 session ~ 1 GB memory useage
    before(:all) do
      @users = create_user_sessions(@users_num)
      visit_localpage(@users)
    end

    after(:all) { close_sessions(@users) }

    # use capybara to test web applications
    # https://github.com/jnicklas/capybara

    %w(page1 page2 page3).each do |page|
      it "testing pageload with threads on #{page} page" do
        visit_localpage(@users, page)
        sleep 1
      end
    end

    it "testing test message page with threads" do
      @users.with_threads do |n|
        n.visit "http://localhost:3000/message"
        n.fill_in "Email Address", with: "test#{@users.key(n)}@test.hu"
        n.fill_in "Message", with: "test message"
        n.click_on "send message"
      end
    end
  end

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
