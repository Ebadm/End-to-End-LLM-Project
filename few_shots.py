few_shots = [
    {'Question' : "How many white Apple smartphones do we have left in stock?",
     'SQLQuery' : "SELECT stock_quantity FROM electronics_items WHERE category = 'Smartphone' AND brand = 'Apple' AND color = 'White'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "63"},
    {'Question' : "How much is the price of the inventory for all smartphone?",
     'SQLQuery' : "SELECT SUM(price*stock_quantity) FROM `electronics_items` WHERE `category` = 'Smartphone'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "982628.00"},
    {'Question' : "If we have to sell all the HP Laptops today with discounts applied. How much revenue our store will generate (post discounts)?" ,
     'SQLQuery' : """SELECT SUM(e.price * e.stock_quantity * (1 - IFNULL(d.pct_discount / 100, 0))) AS total_revenue_post_discounts
                    FROM electronics_items e LEFT JOIN discounts d ON e.item_id = d.item_id WHERE e.brand = 'HP' AND e.category = 'Laptop'
                    """,
     'SQLResult': "Result of the SQL query",
     'Answer' : "196992.00"} ,
     {'Question' : "If we have to sell all the Samsung electronic items today. How much revenue our store will generate without discount?" ,
      'SQLQuery' :  "SELECT SUM(price * stock_quantity) FROM electronics_items WHERE brand = 'Samsung'",
      'SQLResult': "Result of the SQL query",
      'Answer' : "825805.00"},
    {'Question' : "How many black colored Dell electronic items do we have available?",
     'SQLQuery' : "SELECT sum(stock_quantity) FROM electronics_items WHERE brand = 'Dell' AND color = 'Black'",
     'SQLResult': "Result of the SQL query",
     'Answer' : "196"
     }
]