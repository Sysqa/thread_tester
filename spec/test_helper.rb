module TestHelper
  def create_user_sessions(num_of_session)
    users = {}
    num_of_session.times do |i|
      users[i] = Capybara::Session.new(:selenium)
    end
    return users
  end

  def close_sessions(users)
    users.each_key do |i|
      users[i].driver.browser.close
    end
  end

  def visit_localpage(users, page = '')
    users.with_threads do |n|
      n.visit "http://localhost:3000/#{page}"
    end
  end

  def visit_webpage(users, domain, page = '')
    users.with_threads do |n|
      n.visit "http://#{domain}/#{page}"
    end
  end

  def random_string
    (0...8).map { (65 + rand(26)).chr }.join
  end
end

class Hash
  def with_threads
    threads = []
    self.each_key do |i|
      threads << Thread.new { yield(self[i]) }
    end
    threads.each { |thr| thr.join }
  end
end
