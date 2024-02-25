USE ECOMMERCE;
# NOTE: In PRODUCT table ID column is named PROD_ID and not PRO_ID. 

#### 4) Display the total number of customers based on gender who 
####    have placed individual orders of worth at least Rs.3000.

# Using JOIN
SELECT CUS_GENDER, COUNT(CUSTOMER.CUS_ID) FROM CUSTOMER 
INNER JOIN `ORDER` 
ON CUSTOMER.CUS_ID=`ORDER`.CUS_ID 
WHERE `ORDER`.ORD_AMOUNT >3000
GROUP BY CUSTOMER.CUS_GENDER;

# Using subquery 
SELECT CUS_GENDER, COUNT(CUS_ID)  FROM CUSTOMER WHERE CUS_ID IN(
SELECT CUS_ID FROM `ORDER` WHERE ORD_AMOUNT>3000
)GROUP BY CUS_GENDER;

#### 5) Display all the orders along with product name ordered by a customer having Customer_Id=2 
select o.cus_id, o.ord_id, o.ORD_AMOUNT, o.ORD_DATE, sp.SUPP_PRICE,
p.PRO_NAME from `order` o
	inner join supplier_pricing sp
    inner join product p
on (o.PRICING_ID = sp.PRICING_ID AND sp.PROD_ID = p.PRO_ID)
where o.CUS_Id = 2;



#### 6) Display the Supplier details who can supply more than one product.
SELECT * FROM SUPPLIER;
SELECT * FROM PRODUCT;
SELECT * FROM SUPPLIER_PRICING;

# Mine
SELECT S.SUPP_NAME, COUNT(S.SUPP_ID) FROM SUPPLIER S
INNER JOIN PRODUCT P
INNER JOIN SUPPLIER_PRICING SP 
ON (SP.PROD_ID=P.PRO_ID AND S.SUPP_ID=SP.SUPP_ID)
GROUP BY S.SUPP_ID
HAVING COUNT(S.SUPP_ID) > 1;

# Teachers 
select s.*, NoOfProducts_Supplied from supplier s 
inner join (
select supp_id, count(prod_id) as NoOfProducts_Supplied from supplier_pricing
group by supp_id
HAVING NoOfProducts_Supplied > 1
) as sp
on s.supp_id = sp.supp_id;

#### 7) Find the least expensive product from each category and print the table with 
####    category id, name, product name and price of the product
select c.cat_name, min(o.ORD_AMOUNT) from `order` o
	inner join supplier_pricing sp
    inner join product p
    inner join category c
on (o.PRICING_ID = sp.PRICING_ID AND sp.PROD_ID = p.PRO_ID AND c.CAT_ID=p.CAT_ID)
group by c.cat_id;

#### 8) Display the Id and Name of the Product ordered after “2021-10-05”.
select p.pro_id, p.pro_name from `order` o
	inner join supplier_pricing sp
    inner join product p
on (o.PRICING_ID = sp.PRICING_ID AND sp.PROD_ID = p.PRO_ID)
where o.ORD_DATE >= "2021-10-05" 
group by p.pro_id;

#### 9)  Display customer name and gender whose names start or end with character 'A'.
SELECT * FROM CUSTOMER;
SELECT CUS_NAME, CUS_GENDER FROM CUSTOMER 
WHERE (CUS_NAME LIKE 'A%' OR CUS_NAME LIKE '%A');

#### 10)
call ECOMMERCE.supplier_rating();
