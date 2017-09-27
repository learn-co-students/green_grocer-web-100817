require 'pry'
=begin cart = [
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"AVOCADO" => {:price => 3.0, :clearance => true }},
  {"KALE"    => {:price => 3.0, :clearance => false}}
]

coupons={:item => "AVOCADO", :num => 2, :cost => 5.0}
=end
def consolidate_cart(cart)
  cart_hash={}
  cart.each do |hash|
    hash.each do |item,attr|
      if !cart_hash.key?(item)
        cart_hash[item] = attr
        cart_hash[item][:count]=0
      end
      cart_hash[item][:count] = cart_hash[item][:count] + 1
    end
  end
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
coupons.each do |coupon|
 item = coupon[:item]
 if cart[item]
   remainder = cart[item][:count] % coupon[:num]
   sets = cart[item][:count] / coupon[:num]
   if sets >= 1
     cart[item + " W/COUPON"] = {
       price: coupon[:cost],
       clearance: cart[item][:clearance],
       count: sets}
     end
     if remainder >= 1
        cart[item][:count] = remainder
      else
        cart[item][:count] = 0
      end
 end
 end
 cart
end

def apply_clearance(cart)
  # code here
  cart.each_with_object({}) do |(items,attr),results|
    results[items]=attr
    if attr[:clearance]
      results[items][:price] = (attr[:price] * 80)/100
    end
  end
end

def checkout(cart, coupons)
  # code here
  new_cart= apply_clearance(apply_coupons(consolidate_cart(cart),coupons))
  subtotal = 0
  total = 0
  new_cart.each {|items,attr|subtotal = subtotal +  (attr[:price] * attr[:count])}
  (subtotal > 100) ? (total = (subtotal * 90)/100):(total = subtotal)
end
