-- Multi-Table Sorgu Pratiği                                       

-- Tüm ürünler(product) için veritabanındaki ProductName ve CategoryName'i listeleyin. (77 kayıt göstermeli)

SELECT P.ProductName , C.CategoryName 
FROM Products as P LEFT JOIN Categories as C
on P.categoryId=C.categoryId;

-- 9 Ağustos 2012 öncesi verilmiş tüm siparişleri(order) için sipariş id'si (Id) ve gönderici şirket adını(CompanyName)'i listeleyin. (429 kayıt göstermeli)
SELECT o.OrderID, s.SupplierName
FROM ((Orders AS o
LEFT JOIN OrderDetails AS od ON o.OrderID = od.OrderID)
LEFT JOIN Products AS p ON od.ProductID = p.ProductID)
LEFT JOIN Suppliers AS s ON p.SupplierID = s.SupplierID
WHERE o.OrderDate < #2012-08-09#;
--Company name bilgisi w3school üzerinde bulamadım onun yerine SupplierName var!!!
                            
-- Id'si 10251 olan siparişte verilen tüm ürünlerin(product) sayısını ve adını listeleyin. ProdcutName'e göre sıralayın. (3 kayıt göstermeli)
SELECT COUNT(p.ProductName), p.ProductName
FROM ((Orders AS o
LEFT JOIN OrderDetails AS od ON o.OrderID = od.OrderID)
LEFT JOIN Products AS p ON p.ProductID = od.ProductID)
WHERE o.OrderID = 10251
GROUP BY p.ProductName
order BY p.ProductName;

-- Her sipariş için OrderId, Müşteri'nin adını(Company Name) ve çalışanın soyadını(employee's LastName). Her sütun başlığı doğru bir şekilde isimlendirilmeli. (16.789 kayıt göstermeli)
SELECT c.CustomerName, e.LastName
FROM (Orders AS o
LEFT JOIN Customers AS c ON c.CustomerID = o.CustomerID)
LEFT JOIN Employees AS e ON o.EmployeeID = e.EmployeeID;