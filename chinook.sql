-- 1 - non_usa_customers.sql: Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT c.FirstName, c.lastName, c.Country
FROM Customer c
WHERE c.Country NOT LIKE "USA"

-- 2 -brazil_customers.sql: Provide a query only showing the Customers from Brazil.

SELECT c.FirstName, c.lastName, c.Country
FROM Customer c
WHERE c.Country = "Brazil"

-- 3 -brazil_customers_invoices.sql: Provide a query showing the Invoices of customers who are from Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName, c.lastName, i.invoiceDate, i.BillingCountry
FROM Customer c
JOIN Invoice i on c.customerId = i.customerId
WHERE c.Country = "Brazil"

--4 - sales_agents.sql: Provide a query showing only the Employees who are Sales Agents.

SELECT e.FirstName, e.LastName, e.title
FROM Employee e
WHERE e.title LIKE "Sales Support Agent"

-- 5-unique_invoice_countries.sql: Provide a query showing a unique/distinct list of billing countries from the Invoice table.

SELECT i.billingCountry
FROM Invoice i
GROUP BY i.billingCountry

-- 6 -sales_agent_invoices.sql: Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT e.FirstName, e.LastName, i.invoiceId
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.CustomerId


-- 7- invoice_totals.sql: Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

SELECT i.Total as "Invoice Total", c.FirstName as "Customer's First Name", c.LastName as "Customer's Last Name", c.country as "Customer's Country", e.FirstName as "Agent's First Name", e.LastName as "Agent's Last Name"
FROM Employee e
JOIN Customer c ON c.SupportRepId = e.EmployeeId
JOIN Invoice i ON c.customerId = i.InvoiceId

-- 8- total_invoices_{year}.sql: How many Invoices were there in 2009 and 2011?

SELECT count(i.invoiceID) as "Number of Invoices in 2009 and 2011"
FROM Invoice i
WHERE i.Invoicedate LIKE "2009%"
OR i.invoiceDate LIKE "2011%"

-- another way 

SELECT count(i.invoiceID) as "Number of Invoices in 2009 and 2011"
FROM Invoice i
WHERE strftime("%Y", i.Invoicedate) = "2009"
OR strftime("%Y", i.invoiceDate) = "2011"


-- 9-total_sales_{year}.sql: What are the respective total sales for each of those years?
SELECT  SUM(i.Total) as "Total in 2009"
FROM Invoice i
WHERE i.Invoicedate LIKE "2009%"

SELECT  SUM(i.Total) as "Total in 2011"
FROM Invoice i
WHERE i.Invoicedate LIKE "2011%"

-- 10-nvoice_37_line_item_count.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

SELECT count() as "Number of Line Items"
FROM InvoiceLine i 
where i.Invoiceid = 37

-- 11-line_items_per_invoice.sql: Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

SELECT count() as "Number of Line Items", iL.invoiceID
FROM InvoiceLine iL 
GROUP BY iL.Invoiceid

-- 12-line_item_track.sql: Provide a query that includes the purchased track name with each invoice line item.

SELECT t.Name as "Track Name", iL.InvoiceLineID as "Invoice Line"
FROM InvoiceLine iL
JOIN Track t ON iL.TrackID = t.TrackID

-- 13-line_item_track_artist.sql: Provide a query that includes the purchased track name AND artist name with each invoice line item.

SELECT t.Name as "Track Name", ar.Name as "Artist Name", iL.InvoiceLineID as "Invoice Line"
FROM InvoiceLine iL
LEFT JOIN Track t ON iL.TrackID = t.TrackID
LEFT JOIN ALBUM a ON a.albumID = t.albumID
LEFT JOIN Artist ar ON ar.ArtistID = a.Artistid

-- 14-country_invoices.sql: Provide a query that shows the # of invoices per country. HINT: GROUP BY

SELECT i.BillingCountry, count(i.invoiceid) as "Number of invoices"
FROM Invoice i
GROUP BY i.BillingCountry

-- 15-playlists_track_count.sql: Provide a query that shows the total number of tracks in each playlist. The Playlist name should be include on the resulant table.

-- SELECT count(t.trackID) as "Number of Tracks", p.Name as "Playlist Name"
-- FROM Track t
-- JOIN PlaylistTrack pt ON t.trackId = pt.trackID
-- JOIN Playlist p ON pt.PlaylistID = p.PlaylistID
-- GROUP BY p.Name 

SELECT count(pt.TrackID) as "Number of Tracks", p.Name as "Playlist Name"
FROM Playlist p 
left JOIN PlaylistTrack pt ON pt.PlaylistID = p.PlaylistID
GROUP BY p.Playlistid

-- 16-tracks_no_id.sql: Provide a query that shows all the Tracks, but displays no IDs. The result should include the Album name, Media type and Genre.

SELECT t.Name as "Track Name", al.Title as "Album Title" , mt.name as "Music Type", g.Name as "Genre Name"
FROM Track t
JOIN Album al ON t.albumID = al.albumid
JOIN MediaType mt ON t.MediaTypeid = mt.MediaTypeid
JOIN Genre g ON t.GenreId = g.Genreid

-- 17-invoices_line_item_count.sql: Provide a query that shows all Invoices but includes the # of invoice line items.

SELECT i.Invoiceid, count(il.InvoiceLineID) as "Number of Invoice Line Items"
FROM Invoice i 
JOIN InvoiceLine il on i.Invoiceid = il.Invoiceid
GROUP BY i.invoiceID

-- 18-sales_agent_total_sales.sql: Provide a query that shows total sales made by each sales agent.

SELECT e.FirstName, e.LastName, sum(i.total) as "Total sales"
FROM Employee e
JOIN Customer c ON e.EmployeeID = c.SupportRepID
JOIN Invoice i ON c.CustomerID = i.CustomerId
GROUP BY e.FirstName

-- 19-top_2009_agent.sql: Which sales agent made the most in sales in 2009?Hint: Use the MAX function on a subquery.
SELECT sales.FirstName || " " || sales.LastName as "Employee Name", max(sales.TotalSales) as "Total Sales"
FROM (
    SELECT e.FirstName, e.LastName, sum(i.total) as "TotalSales"
    FROM Employee e
    JOIN Customer c ON e.EmployeeID = c.SupportRepID
    JOIN Invoice i ON c.CustomerID = i.CustomerId
    WHERE strftime("%Y", i.Invoicedate) = "2009"
    GROUP BY e.FirstName
)
 As "sales"

-- 20-top_agent.sql: Which sales agent made the most in sales over all?

-- 21-sales_agent_customer_count.sql: Provide a query that shows the count of customers assigned to each sales agent.

-- 22-sales_per_country.sql: Provide a query that shows the total sales per country.

-- 23-top_country.sql: Which country's customers spent the most?

-- 24-top_2013_track.sql: Provide a query that shows the most purchased track of 2013.

-- 25-top_5_tracks.sql: Provide a query that shows the top 5 most purchased tracks over all.

-- 26-top_3_artists.sql: Provide a query that shows the top 3 best selling artists.

-- 27-top_media_type.sql: Provide a query that shows the most purchased Media Type.