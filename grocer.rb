

def consolidate_cart(cart)
  new_hash = {}
  cart.each do |data, attribute|
    data.each do |ingredient, hashname|
      new_hash[ingredient] = hashname
      new_hash[ingredient][:count] = 0
      #data = {"AVOCADO" => {:price => 3.0, :clearance => true }
      #ingredient = "AVOCADO"
      #hashname = {:price => 3.0, :clearance => true }
end
end
   cart.each do |data,attribute|
     data.each do |ingredient, hashname|
       if new_hash.include?(ingredient)
         new_hash[ingredient][:count] += 1
       end
     end
   end
new_hash
end


def apply_coupons(cart, coupons)
  array = []
  new_hash = {}
    cart.each do |ingredient, hashname|
      coupons.each do |hash|
        hash.each do |key,value|
          if value == ingredient && cart[ingredient][:count] >= hash[:num]
            array << ingredient
            array = array.select {|x| x == ingredient}
             cart[ingredient][:count] -= hash[:num]
       new_hash["#{ingredient} W/COUPON"]= {:price => hash[:cost], :clearance => cart[ingredient][:clearance], :count => array.length}
     end
   end
 end
 end
cart.merge(new_hash)
end

def apply_clearance(cart)
  cart.each do |ingredient, hashname|
    if cart[ingredient][:clearance] == true
      cart[ingredient][:price] = (cart[ingredient][:price] * 0.8).round(1)
    end
  end
  cart
end

def checkout(cart, coupons)
    cart = consolidate_cart(cart)
    cart = apply_coupons(cart, coupons)
    cart = apply_clearance(cart)
    sum = 0
    cart.each do |ingredient, hashname|
      sum += (hashname[:price] * hashname[:count])
    end

    if sum > 100
      sum = sum * 0.9
    end
    sum
end
