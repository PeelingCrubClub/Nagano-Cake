# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# Admin.create!(
#  email: 'peeling.crub.club@dwc.com',
#  password: 'peelingcrub'
# )

#Admin show,index確認のためのテストデータ

    # 5.times do |n|
    #   Customer.create!(
    #    email: "test#{n + 1}@test.com",
    #    password: 'peelingcrub',
    #    first_name: "テスト#{n + 1}",
    #    last_name: "テスト#{n + 1}",
    #    first_name_kana: "テスト#{n + 1}",
    #    last_name_kana: "テスト#{n + 1}",
    #    postal_code:"000000#{n + 1}",
    #    address:"千代田区#{n + 1}",
    #    tel:"0900000000#{n + 1}",
    #    )
    # end

     # Genre.create!(
     #  name: "ケーキ"
     # )

     # 3.times do |n|
     # Item.create!(
     #  item_name:"いちご#{n + 1}",
     #  price: "300 + #{n * 10}",
     #  genre_id: 1,
     #  item_status: 2
     #  )
     # end

     # Customer.all.ids.sort.each do |customer_id|
     # Item.all.ids.sort.each do |item_id|
     # CartItem.create(
     #  customer_id: customer_id,
     #  item_id: item_id,
     #  pieces: 2
     #  )
     # end
     # end


    # Customer.all.each do |customer|
    # customer.orders.create!(
    # shipping_postal_code:"0000000",
    # receiver_name:"受取人さん",
    # delivery_address:"皇居",
    # shipping_fee: 800,
    # payment_method: 0,
    # order_status: "in_production",
    # )
    # end

    Order.all.each do |order|
    Item.all.each do |item|
    OrderItem.create!(
     order_id: order.id,
     item_id: item.id,
     tax_price: [item.price * 1.1],
     number_of_pieces: 2,
     production_status: 2,
    )
     end
     end

