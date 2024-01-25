-- ## E-COMMERCE SALES ANALYSIST ## --
-- Find Top Transaction in 2021, by month

SELECT  Year(order_date) as Year, Monthname(order_date) as Month, 
        sum(after_discount) as Total_transaction
FROM order_detail
where Year(order_date) = 2021
and is_valid = 1
Group by Monthname(order_date)
order by sum(after_discount) desc;


-- Find Top Transaction in 2022 By Product Category

SELECT Year(O.order_date) as Year, S.category, sum(O.after_discount) as Total_transaction  
FROM order_detail as O
Join sku_detail as S on (S.sku_Id = O.Id_sku)
where Year(order_date) = 2022
and O.is_valid = 1
Group by S.category
order by sum(O.after_discount) desc;


-- By Category, compare transaction between 2021 and 2022, find which groups experienced increases and decreases

WITH Category_transaction2021 as (
    SELECT Year(O.order_date) as Year, S.category, sum(O.after_discount) as Total_transaction2021  
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    where Year(order_date) = 2021
    and O.is_valid = 1
    Group by S.category
    ),
    Category_transaction2022 as (
    SELECT Year(O.order_date) as Year, S.category, sum(O.after_discount) as Total_transaction2022  
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    where Year(order_date) = 2022
    and O.is_valid = 1
    Group by S.category
    )
SELECT  Category_transaction2021.Category, Total_transaction2021, Total_transaction2022,
        ((Total_transaction2022-Total_transaction2021)/Total_transaction2021)*100 as GrowPercentage
FROM Category_transaction2021
Join Category_transaction2022 on (Category_transaction2022.category = Category_transaction2021.category)
Order by GrowPercentage desc;


-- Base on order, find top 5 payment methode mostly used

SELECT  O.payment_Id, P.payment_method, count(O.qty_ordered) as Total_Order 
FROM order_detail as O
Join payment_detail as P on (P.payment_Id = O.payment_Id)
WHERE O.is_valid = 1
GROUP by P.payment_method
ORDER by Total_Order desc
Limit 5;


-- sort by transaction value on this group of product (Samsung, Apple, Sony, Huawei, Lenovo)

WITH Gadget_transaction as (
    SELECT  S.sku_name as ProductName, O.price as Price, 
            O.qty_ordered as Total_order, O.after_discount as Total_transaction,
            'Samsung' as product_brand
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE S.sku_name like '%Samsung%'
    and O.is_valid = 1
    UNION
    SELECT  S.sku_name as ProductName, O.price as Price, 
            O.qty_ordered as Total_order, O.after_discount as Total_transaction,
            'Apple' as product_brand
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE S.sku_name like '%Apple%' or S.sku_name like '%Iphone%'
    and O.is_valid = 1
    UNION
    SELECT  S.sku_name as ProductName, O.price as Price, 
            O.qty_ordered as Total_order, O.after_discount as Total_transaction,
            'Sony' as product_brand
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE S.sku_name like '%Sony%'
    and O.is_valid = 1
    UNION
    SELECT  S.sku_name as ProductName, O.price as Price, 
            O.qty_ordered as Total_order, O.after_discount as Total_transaction,
            'Huawei' as product_brand
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE S.sku_name like '%Huawei%'
    and O.is_valid = 1
    UNION
    SELECT  S.sku_name as ProductName, O.price as Price, 
            O.qty_ordered as Total_order, O.after_discount as Total_transaction,
            'Lenovo' as product_brand
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE S.sku_name like '%Lenovo%'
    and O.is_valid = 1)
SELECT  product_brand, sum(Total_order) as Total_order, 
        sum(Total_transaction) as Total_transaction
FROM Gadget_transaction
GROUP by product_brand
ORDER by Total_transaction desc;

-- sort by transaction value on this group of product (Samsung, Apple, Sony, Huawei, Lenovo) with if condition

WITH Gadget_transaction as (
    SELECT  
        CASE 
            When S.sku_name like '%Samsung%' then 'Samsung'
            When S.sku_name like '%Apple%' or S.sku_name like '%iphone%' then 'Apple'
            When S.sku_name like '%Sony%' then 'Sony'
            When S.sku_name like '%Huawei%' then 'Huawei'
            When S.sku_name like '%Lenovo%' then 'Lenovo'
        End as product_brand, 
        O.qty_ordered as Total_order, 
        O.after_discount as Total_transaction
    FROM order_detail as O
    Join sku_detail as S on (S.sku_Id = O.Id_sku)
    WHERE O.is_valid = 1
)
SELECT  product_brand, sum(Total_order) as Total_order, 
        sum(Total_transaction) as Total_transaction
FROM Gadget_transaction
WHERE product_brand is Not null
GROUP by product_brand
ORDER by Total_transaction Desc;
