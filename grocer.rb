def consolidate_cart(cart)
  organized_cart = {}
  cart.each do |element|
    element.each do |fruit, hash|
      organized_cart[fruit] ||= hash
      organized_cart[fruit][:count] ||= 0
      organized_cart[fruit][:count] += 1
    end
  end
  return organized_cart
end

def consolidate_cart(cart)
  organized_cart = {}
  count = 0
  cart.each do |element|
    element.each do |fruit, hash|
      organized_cart[fruit] ||= hash
      organized_cart[fruit][:count] ||= 0
      organized_cart[fruit][:count] += 1
    end
  end
  return organized_cart
end

def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    name = coupon[:item]
    if cart[name] && cart[name][:count] >= coupon[:num]
      if cart["#{name} W/COUPON"]
        cart["#{name} W/COUPON"][:count] += 1
      else
        cart["#{name} W/COUPON"] = {:count => 1, :price => coupon[:cost]}
        cart["#{name} W/COUPON"][:clearance] = cart[name][:clearance]
      end
      cart[name][:count] -= coupon[:num]
    end
  end
  cart
end



def apply_clearance(cart)
 cart.each do |fruit_name,fruit_hash|
   if fruit_hash[:clearance] == true
     fruit_hash[:price] = (fruit_hash[:price]*0.8).round(2)
   end
 end
 return cart
end

def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart)
  coupons_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(coupons_cart)
  total_price = 0.00
  final_cart.each do |fruit_name,fruit_hash|
    total_price += fruit_hash[:price] * fruit_hash[:count]
  end
  if total_price > 100.00
    total_price = total_price * 0.9
  end
  return total_price
end
