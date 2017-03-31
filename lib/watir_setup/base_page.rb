module Pages
  class BasePage
    include PageHelper

    def initialize(browser)
      @browser = browser
    end

    def self.url(url)
      define_method("url") do
        if url.is_a?(Hash)
          build_url(url)
        else
          url
        end
      end
    end

    def method_missing(sym, *args, &block)
      @browser.send(sym, *args, &block)
    end

    def goto
      @browser.goto(self.url)
      self
    end

    private
    def build_url(options={})
      path     = options[:path] || ''
      port     = options[:port] || ENV['PORT'] || '9292'
      password = options[:basic_auth_password] || ENV['BASIC_AUTH_PASSWORD']
      hostname = options[:hostname] || ENV['HOSTNAME'] || "localhost"
      protocol = options[:protocol] || 'http'

      user     = options[:basic_auth_user] || ENV['BASIC_AUTH_USER']
      password = options[:basic_auth_password]
      basic_auth = user && password ? "#{user}:#{password}" : nil

      url =  "#{protocol}://"
      url += "#{basic_auth}@" if basic_auth
      url += "#{hostname}"
      port ? url += ":#{port}/" : url += "/"
      if path
        url += "/" if url[-1] != "/" && path[0] != "/"
        url += path
      end
    end
  end
end
