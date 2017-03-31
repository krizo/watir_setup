module PageHelper
  def goto(page_class)
    page_class.new(@browser).goto
  end

  def on(page_class)
    page_class.new(@browser)
  end
end
