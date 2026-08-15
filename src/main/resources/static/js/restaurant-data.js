/* ==========================================================================
   CRAVIO EXTENDED CULINARY DATABASE
   Cities, Specific Localities (3+ Restaurants Per Locality), Menus & Prices in ₹
   ========================================================================== */

(function () {
  'use strict';

  const LOCATIONS = {
    Hyderabad: ["Jubilee Hills", "Banjara Hills", "Gachibowli", "Madhapur", "HITECH City"],
    Mumbai: ["Bandra West", "Juhu", "Powai", "Andheri East", "Lower Parel"],
    Delhi: ["Connaught Place", "Hauz Khas Village", "Saket", "Cyber City", "Chandni Chowk"],
    Bangalore: ["Indiranagar", "Koramangala", "HSR Layout", "MG Road", "Whitefield"],
    Pune: ["Koregaon Park", "Viman Nagar", "Baner", "Kothrud", "Hinjewadi"]
  };

  const RESTAURANTS = [
    // HYDERABAD - JUBILEE HILLS (3 RESTAURANTS)
    {
      id: "rest-1",
      name: "Hyderabad Biryani House",
      city: "Hyderabad",
      locality: "Jubilee Hills",
      address: "Road No. 36, Jubilee Hills, Hyderabad",
      cuisine: ["Hyderabadi", "Biryani", "Mughlai"],
      rating: 4.9,
      reviewCount: 3420,
      deliveryTime: "20-30 min",
      priceForTwo: 500,
      openingHours: "11:00 AM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "20% OFF | CRAVIO20",
      offerCode: "CRAVIO20",
      vegOnly: false,
      description: "Authentic royal Nizami biryanis cooked in clay handis with pure saffron, Kashmiri spices & tender meats.",
      menu: [
        { id: "d-101", category: "Biryani", name: "Hyderabadi Chicken Dum Biryani", price: 380, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=400&q=80", desc: "Aromatic basmati rice cooked with succulent chicken in sealed clay handi." },
        { id: "d-102", category: "Biryani", name: "Mutton Special Dum Biryani", price: 480, isVeg: false, prepTime: "25 min", isAvailable: true, rating: 5.0, image: "https://images.unsplash.com/photo-1633945274405-b6c8069047b0?auto=format&fit=crop&w=400&q=80", desc: "Tender goat meat layered with saffron basmati rice and fried onions." },
        { id: "d-103", category: "Starters", name: "Mutton Seekh Kebab (4 Pcs)", price: 420, isVeg: false, prepTime: "15 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80", desc: "Minced lamb kebabs grilled over charcoal with royal Indian spices." },
        { id: "d-104", category: "Desserts", name: "Double Ka Meetha", price: 160, isVeg: true, prepTime: "10 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1551024709-8f23befc6f87?auto=format&fit=crop&w=400&q=80", desc: "Golden fried bread soaked in saffron syrup, rabri & pistachios." }
      ]
    },
    {
      id: "rest-1b",
      name: "Jubilee Grill & Bistro",
      city: "Hyderabad",
      locality: "Jubilee Hills",
      address: "Road No. 45, Jubilee Hills, Hyderabad",
      cuisine: ["North Indian", "Tandoori", "Kebabs"],
      rating: 4.8,
      reviewCount: 1890,
      deliveryTime: "25-35 min",
      priceForTwo: 700,
      openingHours: "12:00 PM - 11:00 PM",
      image: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "15% OFF",
      offerCode: "JUBILEE15",
      vegOnly: false,
      description: "Charcoal grills, gourmet kebabs, butter naans, and rich North Indian curries.",
      menu: [
        { id: "d-1b1", category: "Starters", name: "Tandoori Chicken Full", price: 520, isVeg: false, prepTime: "25 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1599487488170-d11ec9c172f0?auto=format&fit=crop&w=400&q=80", desc: "Whole chicken marinated in red chili yogurt marinade, clay oven roasted." }
      ]
    },
    {
      id: "rest-1c",
      name: "Royal Mughlai Kitchen",
      city: "Hyderabad",
      locality: "Jubilee Hills",
      address: "Near Metro Station, Jubilee Hills, Hyderabad",
      cuisine: ["Mughlai", "Biryani", "North Indian"],
      rating: 4.7,
      reviewCount: 1450,
      deliveryTime: "20-30 min",
      priceForTwo: 600,
      openingHours: "11:30 AM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "FREE DELIVERY",
      offerCode: "FREEDEL",
      vegOnly: false,
      description: "Rich Mughlai gravy curries, shahi paneer, roomali roti and royal desserts.",
      menu: [
        { id: "d-1c1", category: "Main Course", name: "Chicken Reshmi Handi", price: 390, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=400&q=80", desc: "Boneless chicken simmered in white cashew cream gravy." }
      ]
    },

    // HYDERABAD - BANJARA HILLS (3 RESTAURANTS)
    {
      id: "rest-1d",
      name: "Banjara Tandoori Express",
      city: "Hyderabad",
      locality: "Banjara Hills",
      address: "Road No. 1, Banjara Hills, Hyderabad",
      cuisine: ["North Indian", "Kebabs", "Biryani"],
      rating: 4.8,
      reviewCount: 2100,
      deliveryTime: "20-30 min",
      priceForTwo: 550,
      openingHours: "11:00 AM - 11:00 PM",
      image: "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "20% OFF",
      offerCode: "CRAVIO20",
      vegOnly: false,
      description: "Authentic Punjabi butter chicken, dal makhani, garlic naan and tandoori grills.",
      menu: [
        { id: "d-1d1", category: "Main Course", name: "Special Butter Chicken", price: 420, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=400&q=80", desc: "Tandoori chicken tikka simmered in creamy tomato gravy." }
      ]
    },
    {
      id: "rest-1e",
      name: "Spice Terrace Dining",
      city: "Hyderabad",
      locality: "Banjara Hills",
      address: "Road No. 12, Banjara Hills, Hyderabad",
      cuisine: ["South Indian", "Hyderabadi", "Chettinad"],
      rating: 4.7,
      reviewCount: 1620,
      deliveryTime: "15-25 min",
      priceForTwo: 480,
      openingHours: "10:30 AM - 10:30 PM",
      image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "PURE VEG",
      offerCode: "VEG20",
      vegOnly: true,
      description: "Traditional South Indian tiffin, spicy Chettinad gravies and filter coffee.",
      menu: [
        { id: "d-1e1", category: "South Indian", name: "Ghee Masala Dosa", price: 170, isVeg: true, prepTime: "10 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=400&q=80", desc: "Crispy ghee roast crepe served with 3 chutneys and sambar." }
      ]
    },
    {
      id: "rest-1f",
      name: "Nawab Biryani Palace",
      city: "Hyderabad",
      locality: "Banjara Hills",
      address: "Road No. 10, Banjara Hills, Hyderabad",
      cuisine: ["Biryani", "Hyderabadi", "Mughlai"],
      rating: 4.9,
      reviewCount: 2980,
      deliveryTime: "20-30 min",
      priceForTwo: 520,
      openingHours: "11:00 AM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "FREE DELIVERY",
      offerCode: "FREEDEL",
      vegOnly: false,
      description: "Famous Nizami mutton dum biryani and mirchi ka salan.",
      menu: [
        { id: "d-1f1", category: "Biryani", name: "Nizami Mutton Dum Biryani", price: 460, isVeg: false, prepTime: "25 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1563379091339-03b21ab4a4f8?auto=format&fit=crop&w=400&q=80", desc: "Slow cooked dum biryani with tender mutton chops." }
      ]
    },

    // MUMBAI - BANDRA WEST (3 RESTAURANTS)
    {
      id: "rest-2",
      name: "Bombay Spice Bistro",
      city: "Mumbai",
      locality: "Bandra West",
      address: "Hill Road, Bandra West, Mumbai",
      cuisine: ["Street Food", "Maharashtrian", "North Indian"],
      rating: 4.8,
      reviewCount: 1950,
      deliveryTime: "15-25 min",
      priceForTwo: 400,
      openingHours: "10:00 AM - 11:00 PM",
      image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "15% OFF",
      offerCode: "BOMBAY15",
      vegOnly: true,
      description: "Iconic Mumbai street eats, buttery pav bhaji, sizzling chaat and authentic Maharashtrian flavors.",
      menu: [
        { id: "d-201", category: "Main Course", name: "Mumbai Special Pav Bhaji", price: 220, isVeg: true, prepTime: "15 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=400&q=80", desc: "Mashed spiced vegetable curry topped with Amul butter, served with hot pavs." },
        { id: "d-202", category: "Starters", name: "Cheese Vada Pav (2 Pcs)", price: 140, isVeg: true, prepTime: "10 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1601050690597-df0568f70950?auto=format&fit=crop&w=400&q=80", desc: "Spiced potato dumpling inside fresh bun with garlic chutney & melted cheese." }
      ]
    },
    {
      id: "rest-2b",
      name: "Bandra Italian Oven",
      city: "Mumbai",
      locality: "Bandra West",
      address: "Pali Hill, Bandra West, Mumbai",
      cuisine: ["Italian", "Pizza", "Pasta"],
      rating: 4.8,
      reviewCount: 1670,
      deliveryTime: "25-35 min",
      priceForTwo: 800,
      openingHours: "12:00 PM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "20% OFF",
      offerCode: "CRAVIO20",
      vegOnly: false,
      description: "Artisanal woodfired Neapolitan pizzas, handmade pasta & gelato.",
      menu: [
        { id: "d-2b1", category: "Pizza", name: "Truffle Mushroom Pizza", price: 540, isVeg: true, prepTime: "20 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1604382355076-af4b0eb60143?auto=format&fit=crop&w=400&q=80", desc: "Wild truffle oil, mushrooms, mozzarella & rosemary." }
      ]
    },
    {
      id: "rest-2c",
      name: "Seafront Seafood Cafe",
      city: "Mumbai",
      locality: "Bandra West",
      address: "Bandstand, Bandra West, Mumbai",
      cuisine: ["Coastal", "Seafood", "Maharashtrian"],
      rating: 4.7,
      reviewCount: 1320,
      deliveryTime: "25-35 min",
      priceForTwo: 900,
      openingHours: "12:00 PM - 11:00 PM",
      image: "https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "FREE DELIVERY",
      offerCode: "FREEDEL",
      vegOnly: false,
      description: "Malvani fish curry, rava fried prawns and fresh coconut sol kadhi.",
      menu: [
        { id: "d-2c1", category: "Coastal", name: "Surmai Rava Fry", price: 480, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=400&q=80", desc: "Kingfish steak coated in spiced semolina, shallow fried golden." }
      ]
    },

    // DELHI - CONNAUGHT PLACE (3 RESTAURANTS)
    {
      id: "rest-3",
      name: "Bukhara Royal Tandoor",
      city: "Delhi",
      locality: "Connaught Place",
      address: "Block A, Connaught Place, New Delhi",
      cuisine: ["North Indian", "Mughlai", "Tandoori"],
      rating: 4.9,
      reviewCount: 2890,
      deliveryTime: "25-35 min",
      priceForTwo: 900,
      openingHours: "12:00 PM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1585937421612-70a008356fbe?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "FREE DELIVERY",
      offerCode: "FREEDEL",
      vegOnly: false,
      description: "Legendary North Indian Mughlai dining renowned for 24-hour slow-cooked Dal Bukhara & Butter Chicken.",
      menu: [
        { id: "d-301", category: "Main Course", name: "Classic Dal Bukhara", price: 340, isVeg: true, prepTime: "20 min", isAvailable: true, rating: 5.0, image: "https://images.unsplash.com/photo-1546833999-b9f581a1996d?auto=format&fit=crop&w=400&q=80", desc: "Black lentils slow-cooked overnight with fresh butter, cream & fenugreek." },
        { id: "d-302", category: "Main Course", name: "Butter Chicken Supreme", price: 460, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1603894584373-5ac82b2ae398?auto=format&fit=crop&w=400&q=80", desc: "Charcoal grilled chicken tikka in rich cashew tomato butter gravy." }
      ]
    },
    {
      id: "rest-3b",
      name: "CP Paratha House",
      city: "Delhi",
      locality: "Connaught Place",
      address: "Inner Circle, Connaught Place, New Delhi",
      cuisine: ["North Indian", "Street Food"],
      rating: 4.8,
      reviewCount: 1980,
      deliveryTime: "15-25 min",
      priceForTwo: 350,
      openingHours: "08:00 AM - 11:00 PM",
      image: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "PURE VEG",
      offerCode: "VEG15",
      vegOnly: true,
      description: "Famous stuffed stuffed tandoori parathas with white butter, curd & pickle.",
      menu: [
        { id: "d-3b1", category: "Main Course", name: "Aloo Cheese Paratha Thali", price: 190, isVeg: true, prepTime: "15 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1626777552726-4a6b54c97e46?auto=format&fit=crop&w=400&q=80", desc: "Stuffed whole wheat flatbread served with chole, curd & butter." }
      ]
    },
    {
      id: "rest-3c",
      name: "Delhi Grill Room",
      city: "Delhi",
      locality: "Connaught Place",
      address: "Outer Circle, Connaught Place, New Delhi",
      cuisine: ["Mughlai", "Barbecue", "North Indian"],
      rating: 4.7,
      reviewCount: 1540,
      deliveryTime: "25-35 min",
      priceForTwo: 800,
      openingHours: "12:00 PM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "20% OFF",
      offerCode: "CRAVIO20",
      vegOnly: false,
      description: "Charcoal grilled kebabs, galouti kebabs & roomali rolls.",
      menu: [
        { id: "d-3c1", category: "Starters", name: "Mutton Galouti Kebab (4 Pcs)", price: 440, isVeg: false, prepTime: "20 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1544025162-d76694265947?auto=format&fit=crop&w=400&q=80", desc: "Melt-in-mouth Awadhi spiced minced mutton patties." }
      ]
    },

    // BANGALORE - INDIRANAGAR (3 RESTAURANTS)
    {
      id: "rest-6",
      name: "South Spice",
      city: "Bangalore",
      locality: "Indiranagar",
      address: "100 Feet Road, Indiranagar, Bengaluru",
      cuisine: ["South Indian", "Dosa", "Chettinad"],
      rating: 4.9,
      reviewCount: 3100,
      deliveryTime: "15-20 min",
      priceForTwo: 350,
      openingHours: "07:00 AM - 10:30 PM",
      image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80",
        "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "PURE VEG",
      offerCode: "SOUTH20",
      vegOnly: true,
      description: "Authentic South Indian tiffin, ghee roast dosas, fluffy idlis & traditional filter coffee.",
      menu: [
        { id: "d-601", category: "South Indian", name: "Special Ghee Masala Dosa", price: 180, isVeg: true, prepTime: "10 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=400&q=80", desc: "Crispy dosa roasted in pure cow ghee, filled with spicy potato mash." },
        { id: "d-602", category: "South Indian", name: "Degree Filter Coffee", price: 70, isVeg: true, prepTime: "5 min", isAvailable: true, rating: 5.0, image: "https://images.unsplash.com/photo-1514432324607-a09d9b4aefdd?auto=format&fit=crop&w=400&q=80", desc: "Traditional South Indian frothy chicory filter coffee." }
      ]
    },
    {
      id: "rest-6b",
      name: "Indiranagar Burger Co",
      city: "Bangalore",
      locality: "Indiranagar",
      address: "12th Main Road, Indiranagar, Bengaluru",
      cuisine: ["American", "Burgers", "Fast Food"],
      rating: 4.8,
      reviewCount: 1820,
      deliveryTime: "20-30 min",
      priceForTwo: 600,
      openingHours: "11:30 AM - 11:30 PM",
      image: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "20% OFF",
      offerCode: "CRAVIO20",
      vegOnly: false,
      description: "Gourmet smashed beef & chicken burgers with truffle fries.",
      menu: [
        { id: "d-6b1", category: "Burgers", name: "Smokey Wagyu Cheeseburger", price: 390, isVeg: false, prepTime: "15 min", isAvailable: true, rating: 4.9, image: "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?auto=format&fit=crop&w=400&q=80", desc: "Grilled wagyu patty topped with aged cheddar & bacon jam." }
      ]
    },
    {
      id: "rest-6c",
      name: "Bangalore Dosa Hub",
      city: "Bangalore",
      locality: "Indiranagar",
      address: "HAL 2nd Stage, Indiranagar, Bengaluru",
      cuisine: ["South Indian", "Dosa"],
      rating: 4.7,
      reviewCount: 1420,
      deliveryTime: "15-25 min",
      priceForTwo: 300,
      openingHours: "07:30 AM - 10:00 PM",
      image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=600&q=80",
      banner: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80",
      gallery: [
        "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=1200&q=80"
      ],
      offer: "PURE VEG",
      offerCode: "VEG15",
      vegOnly: true,
      description: "Open butter masala dosa, benne dosa and coconut pudhi idlis.",
      menu: [
        { id: "d-6c1", category: "South Indian", name: "Davanagere Benne Dosa", price: 160, isVeg: true, prepTime: "10 min", isAvailable: true, rating: 4.8, image: "https://images.unsplash.com/photo-1589301760014-d929f3979dbc?auto=format&fit=crop&w=400&q=80", desc: "Thick soft crisp dosa roasted with generous white butter." }
      ]
    }
  ];

  window.CravioData = {
    LOCATIONS,
    RESTAURANTS,
    getCurrentLocation: function() {
      return JSON.parse(localStorage.getItem('cravio_user_location')) || { city: "Hyderabad", locality: "Jubilee Hills" };
    },
    setCurrentLocation: function(city, locality) {
      const loc = { city, locality };
      localStorage.setItem('cravio_user_location', JSON.stringify(loc));
      return loc;
    },
    getRestaurantById: function(id) {
      return RESTAURANTS.find(r => r.id === id) || RESTAURANTS[0];
    }
  };
})();
