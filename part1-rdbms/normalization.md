## Anomaly Analysis

### Insert Anomaly
If a new product is introduced but no order is placed yet, we cannot insert that product into the table because order_id is required.

Example:
Product details cannot exist without an order record.

### Update Anomaly
If a customer's city changes, it must be updated in multiple rows.

Example:
Customer CUST012 appears in multiple orders. If their city changes, all rows must be updated, otherwise inconsistency occurs.

### Delete Anomaly
If the only order of a customer is deleted, all customer information is also lost.

Example:
If order ORD2001 is deleted, customer CUST028 data is also removed.