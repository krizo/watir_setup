class CurrentBrowser < SimpleDelegator
  include Singleton

  attr_accessor :browser, :client

  BROWSER_RES_X = 1366 #1280
  BROWSER_RES_Y = 768 #924

  def initialize
    super(self.browser)
  end

  def start_browser(env)
    self.browser ||= browser_builder(env)
    resize_browser
  end

  def resize_browser(x = BROWSER_RES_X, y = BROWSER_RES_Y)
    browser.window.resize_to(x, y)
  end

  private

  def browser_builder(env)
    env = env.to_sym if env
    Watir::Browser.new(env || :chrome)
  end
end
