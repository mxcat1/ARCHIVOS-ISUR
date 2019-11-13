create table DatosUnpivot
(
    Productname varchar(max),
    Enero       int,
    Febrero     int,
    Marzo       int,
    Abril       int,
    Mayo        int,
    Junio       int,
    Julio       int,
    Agosto      int,
    Setiembre   int,
    Octubre     int,
    Noviembre   int,
    Diciembre   int
)
go

INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Alice Mutton', 35, 66, 16, 24, 4, 97, 92, 51, 74, 15, 48, 11);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Aniseed Syrup', 13, 17, 30, 73, 52, 22, 41, 67, 99, 50, 88, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Boston Crab Meat', 100, 98, 27, 9, 10, 12, 67, 38, 13, 58, 89, 71);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Camembert Pierrot', 67, 55, 74, 11, 62, 30, 60, 77, 2, 18, 97, 88);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Carnarvon Tigers', 22, 84, 9, 67, null, 5, 86, 39, 82, 85, 43, 100);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chai', 57, null, 90, 80, 55, 49, 4, 26, 79, 89, 55, 15);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chang', 29, 4, 14, 4, 35, 11, 66, 35, null, 17, 86, 37);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chartreuse verte', 74, 81, null, 28, 73, null, 11, 7, 22, 27, 19, 18);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chef Anton''s Cajun Seasoning', 78, 81, 72, 47, 72, 69, 79, 21, 15, 61, 24, 93);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chef Anton''s Gumbo Mix', 25, 55, 59, 40, 94, 34, 71, 25, 36, 28, 12, null);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Chocolade', 15, 81, 5, 86, 57, 44, 100, 85, 7, 59, 86, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('C?te de Blaye', 93, 9, 80, 58, null, 20, 90, 4, 6, 37, 12, 31);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Escargots de Bourgogne', 53, 47, 69, 16, 44, 67, 32, 16, 93, 6, 39, 17);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Filo Mix', 96, 53, null, 7, 94, 28, 61, 77, 78, 4, 50, 91);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Flotemysost', 88, 71, 66, 28, 15, 38, 56, 76, 37, 83, 72, 49);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Geitost', 93, 53, 59, 66, 57, 18, 71, 49, 50, 31, 76, 43);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Genen Shouyu', 73, 90, 19, 46, 11, 67, 50, 58, 72, 91, 71, 83);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gnocchi di nonna Alice', 16, 99, 40, 73, 54, 95, null, 21, 9, 33, null, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gorgonzola Telino', 74, 52, 99, null, 19, 5, 66, 73, null, 26, 31, 37);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Grandma''s Boysenberry Spread', 94, 5, 23, 87, 35, 81, 73, 52, 61, 82, 91, 79);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gravad lax', 83, 22, 95, 45, 24, 74, 83, null, 52, 70, 73, 69);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Guaran? Fant?stica', 21, 14, 22, 15, 83, 23, 70, 13, 72, 34, 82, 16);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gudbrandsdalsost', 91, null, 21, null, 17, 27, 82, 30, 53, 66, 8, 37);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gula Malacca', 43, 64, 73, 62, 70, 81, 29, 39, 16, 93, 39, null);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gumb?r Gummib?rchen', 68, 10, 69, 53, 3, 93, 27, 14, 90, 25, 8, 26);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Gustaf''s Kn?ckebr?d', null, 37, 83, 79, 10, 96, 95, 2, null, null, 71, 83);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Ikura', 96, 77, 28, 16, 4, 78, 76, 68, 81, 76, 31, 98);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Inlagd Sill', 88, 8, 51, 10, 13, null, 65, null, 28, 73, 40, 20);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Ipoh Coffee', 18, 19, 62, 56, 62, 40, 2, 82, 47, 15, 8, 70);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Jack''s New England Clam Chowder', 66, 100, 82, 7, 26, 67, null, 39, 95, 92, 8, 15);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Konbu', null, 45, 81, 75, 92, null, 62, 15, 74, 73, 72, 93);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Lakkalik??ri', 35, 2, 82, 90, 83, 52, 5, 98, 93, 16, 32, 17);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Laughing Lumberjack Lager', 22, 33, 49, 66, 59, 64, 36, 20, 47, 24, 30, 58);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Longlife Tofu', 61, 57, 53, 95, 36, 63, 33, 85, 24, 47, 46, 52);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Louisiana Fiery Hot Pepper Sauce', 3, 71, 13, null, 16, 78, 56, 73, 70, 12, 55, 55);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Louisiana Hot Spiced Okra', null, 32, 71, 84, 79, 67, 92, 14, 5, null, 34, 61);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Manjimup Dried Apples', 98, null, 87, 39, 42, 12, 70, 23, 49, 99, 11, 26);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Mascarpone Fabioli', 93, 42, 82, 42, 66, 52, 90, 42, 83, 86, 10, 92);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Maxilaku', 43, 21, 41, null, 34, 16, 3, 67, 27, 59, 48, 93);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Mishi Kobe Niku', 34, 42, 61, 68, 58, 14, 15, 80, 99, 76, 94, 58);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Mozzarella di Giovanni', 29, 44, 100, 81, 42, 23, 85, 82, 82, 53, 41, 28);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Nord-Ost Matjeshering', 2, 21, 22, 64, 49, null, 76, 33, 88, 66, 61, 44);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Northwoods Cranberry Sauce', 30, 9, 21, null, 26, 91, 64, 18, 79, 11, 80, 14);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('NuNuCa Nu?-Nougat-Creme', 64, null, 32, 64, 13, 18, 69, 33, 99, 100, 76, 74);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Original Frankfurter gr?ne So?e', 24, 97, 15, 46, 8, 36, 3, 20, 30, 42, 22, 71);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Outback Lager', 63, 85, 4, 70, 34, 64, 44, 92, 54, 35, 57, 38);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('P?t? chinois', 15, 44, 50, 2, 99, 27, 52, 96, 16, 17, null, 41);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Pavlova', 55, 80, 77, 32, 6, 79, 66, 58, 10, 70, 46, 61);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Perth Pasties', 38, 38, 16, 48, 38, 34, 8, 79, 70, 41, 77, 6);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Queso Cabrales', 85, 61, 34, 95, null, 45, 88, 37, 73, 70, 97, 67);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Queso Manchego La Pastora', 25, 5, 53, 4, 45, 87, 3, 56, null, 49, 46, 42);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Raclette Courdavault', 95, 3, 48, 30, 47, 82, 64, 48, 87, 30, 47, 28);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Ravioli Angelo', 47, 73, 63, 67, 24, 76, 5, 70, 56, 56, 96, 57);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Rh?nbr?u Klosterbier', 72, 8, 5, 71, 46, null, 70, 93, 93, 68, null, 40);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('R?d Kaviar', 52, 65, null, 10, 19, 45, 31, 53, 25, 85, null, 71);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Rogede sild', 25, 16, 55, 52, 3, 71, 54, 56, 24, 60, 89, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('R?ssle Sauerkraut', 27, 81, 98, null, null, 90, 86, null, 58, null, 99, 50);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Sasquatch Ale', 83, 32, 18, 61, 99, 75, 12, 67, 35, 57, 31, 3);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Schoggi Schokolade', 14, 39, 33, 99, 6, 4, 57, 18, 89, 49, 96, 6);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Scottish Longbreads', 6, 43, null, 12, 83, 73, 2, 60, 67, 72, 27, 95);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Singaporean Hokkien Fried Mee', 77, 37, 43, 50, 24, 42, 43, 86, 53, 48, 79, 36);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Sir Rodney''s Marmalade', 26, 78, 19, 88, 38, 38, 89, 65, 6, 94, 54, 91);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Sir Rodney''s Scones', 18, 51, 3, 32, 2, 8, 40, 42, 33, 15, 51, 66);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Sirop d''?rable', 23, 11, null, 95, 16, 64, 75, 52, 52, 44, 33, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Spegesild', 71, null, 31, 83, 75, 26, 24, 81, 70, 51, 40, 34);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Steeleye Stout', null, 42, 3, 51, 83, 12, 71, 66, 10, 34, 14, 15);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Tarte au sucre', 14, 25, 63, 93, 9, 36, 50, 82, 92, 24, 64, null);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Teatime Chocolate Biscuits', 34, 57, 3, 89, 16, 27, 79, 63, 80, 69, 45, 13);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Th?ringer Rostbratwurst', 48, 85, null, 17, 32, 61, 67, 100, 9, 77, 53, 55);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Tofu', 50, 31, null, 63, 13, 76, 89, 8, 37, 36, 43, 17);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Tourti?re', 92, 8, 77, 56, 62, 66, 83, 98, 24, 32, 56, 32);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Tunnbr?d', 19, 69, 49, 93, 34, 35, 15, 79, 86, 98, 53, 80);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Uncle Bob''s Organic Dried Pears', 55, 48, 71, 99, 33, 79, 98, 74, 97, 14, 9, 93);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Valkoinen suklaa', 93, 34, 80, 10, 10, 27, 34, 28, 49, 10, 81, 87);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Vegie-spread', 73, 82, 91, null, 8, 10, 83, 13, 47, null, 88, 42);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Wimmers gute Semmelkn?del', 51, 16, 76, 52, 90, 5, 3, 6, null, 25, 6, 34);
INSERT INTO Northwind.dbo.DatosUnpivot (Productname, Enero, Febrero, Marzo, Abril, Mayo, Junio, Julio, Agosto, Setiembre, Octubre, Noviembre, Diciembre) VALUES ('Zaanse koeken', 87, 77, 88, 47, 6, 14, 66, 86, 35, 43, 61, 66);