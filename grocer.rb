require "pry"
def consolidate_cart(cart)
  # code here
  cart_hash = {}
  cart.each do |item_hash|
    item_hash.each do |item, attribs|
      if !cart_hash.keys.include?(item)
        cart_hash[item] = attribs
        cart_hash[item][:count] = 1
      else
        cart_hash[item][:count] += 1
      end
    end
  end
  #binding.pry
  cart_hash
end

def apply_coupons(cart, coupons)
  # code here
  couped_items = {}
  cart.each do |item, attribs|
    coupons.each do |coupon|
      if coupon[:item] == item && attribs[:count]>= coupon[:num]
        couped_name = "#{item} #{"W/COUPON"}"
        if !couped_items.keys.include?(couped_name)
          couped_items[couped_name] = {count: 1, price: coupon[:cost], clearance: attribs[:clearance]}
          attribs[:count] -= coupon[:num]
        else
          couped_items[couped_name][:count] += 1
          attribs[:count] -= coupon[:num]
        end
        #cart.delete(item) if attribs[:count] == 0;
      end
    end
  end
  couped_items.each do |item, atts|
    cart[item] = atts
  end
  cart
end

def apply_clearance(cart)
  # code here
  #binding.pry
  cart.each do |item, attribs|
    attribs[:price] = (attribs[:price] * 0.8).round(1) if attribs[:clearance]
    #binding.pry
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0
  #binding.pry
  cart = consolidate_cart(cart)
  #binding.pry
  apply_coupons(cart, coupons)
  #binding.pry
  apply_clearance(cart)
  #binding.pry
  cart.each do |item, attribs|
    #binding.pry
    total += attribs[:price]*attribs[:count]
    total = (total* 0.9).round(1) if total > 100
  end
  total
end
