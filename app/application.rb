class Application

  @@items = ["Apples","Carrots","Pears","Figs"]
  @@cart = ["stuff"]

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      @@items.each do |item|
        resp.write "#{item}\n"
      end
    elsif req.path.match(/search/)
      search_term = req.params["q"]
      resp.write handle_search(search_term.capitalize)
    elsif req.path.match(/cart/)
      if !@@cart.empty?
      @@cart.each do |items|
        resp.write "#{items}\n"
      end
    else 
      resp.write "Your cart is empty"
    end
    elsif req.path.match(/add/)
        cart_addition = req.params["item"]
        if @@items.include?(cart_addition)
          @@cart << cart_addition
          resp.write "added #{cart_addition}"
        else resp.write "We don't have that item"
        end
      else
      resp.write "Path Not Found"
    end

    resp.finish
  end

  def handle_search(search_term)
    if @@items.include?(search_term)
      return "#{search_term} is one of our items"
    else
      return "Couldn't find #{search_term}"
    end
  end
end
