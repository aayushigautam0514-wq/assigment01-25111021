// OP1: insertMany()
db.products.insertMany([
  {
    product_id: "E001",
    name: "Smartphone",
    category: "Electronics",
    price: 30000,
    specs: { brand: "Samsung", warranty_years: 2 }
  },
  {
    product_id: "C001",
    name: "T-Shirt",
    category: "Clothing",
    price: 1200,
    sizes: ["S","M","L"]
  },
  {
    product_id: "G001",
    name: "Milk",
    category: "Groceries",
    price: 60,
    expiry_date: new Date("2025-01-10")
  }
]);

// OP2: find Electronics price > 20000
db.products.find({
  category: "Electronics",
  price: { $gt: 20000 }
});

// OP3: groceries expiring before 2025
db.products.find({
  category: "Groceries",
  expiry_date: { $lt: new Date("2025-01-01") }
});

// OP4: updateOne()
db.products.updateOne(
  { product_id: "E001" },
  { $set: { discount_percent: 10 } }
);

// OP5: createIndex()
db.products.createIndex({ category: 1 });