show search_path;
set search_path to sponsorship,public;

CREATE TABLE sponsors (
    sponsorID SERIAL PRIMARY KEY,
    sponsorName varchar NOT NULL,
    industryType varchar,
    contactEmail varchar UNIQUE NOT NULL,
    phone varchar NOT NULL
);

select * from sponsors;

CREATE TABLE matches (
    matchID SERIAL PRIMARY KEY,
    matchName varchar NOT NULL,
    matchDate date NOT NULL,
    location varchar NOT NULL
);


CREATE TABLE contracts (
    contractID SERIAL PRIMARY KEY,
    sponsorID integer NOT NULL,
    matchID integer NOT NULL,
    contractDate date NOT NULL,
    contractValue decimal NOT NULL,
    FOREIGN KEY (sponsorID) REFERENCES sponsors(sponsorID),
    FOREIGN KEY (matchID) REFERENCES matches(matchID)
);


CREATE TABLE payments (
    paymentID SERIAL PRIMARY KEY,
    contractID integer NOT NULL,
    paymentDate date NOT NULL,
    amountPaid decimal NOT NULL,
    paymentStatus varchar CHECK (PaymentStatus IN ('Pending', 'Completed', 'Failed')) NOT NULL,
    FOREIGN KEY (contractID) REFERENCES contracts(contractID)
);

select * from payments;

INSERT INTO sponsors (sponsorName, industryType, contactEmail, phone)
VALUES
('Nike', 'Sportswear', 'nike@sports.com', '1234567890'),
('Adidas', 'Sportswear', 'contact@adidas.com', '2345678901'),
('Red Bull', 'Energy', 'info@redbull.com', '3456789012'),
('Puma', 'Sportswear', 'support@puma.com', '4567890123'),
('Under Armour', 'Sportswear', 'hello@underarmour.com', '5678901234'),
('Coca Cola', 'Beverages', 'contact@coca-cola.com', '6789012345'),
('Pepsi', 'Beverages', 'pepsi@contact.com', '7890123456'),
('Samsung', 'Electronics', 'samsung@sponsor.com', '8901234567'),
('Sony', 'Electronics', 'support@sony.com', '9012345678'),
('Visa', 'Financial Services', 'info@visa.com', '1234567890');


INSERT INTO matches (matchName, matchDate, location)
VALUES
('ICC World Cup Final', '2024-11-15', 'Mumbai'),
('UEFA Champions League Final', '2024-06-01', 'London'),
('ISL Semi-Final', '2024-12-10', 'Kolkata'),
('NBA Finals Game 7', '2024-06-25', 'Los Angeles'),
('Super Bowl LVII', '2024-02-10', 'Miami'),
('Wimbledon Mens Final', '2024-07-14', 'London'),
('Tokyo Olympic 100m Final', '2024-07-31', 'Tokyo'),
('FIFA World Cup Semi-Final', '2024-12-18', 'Doha'),
('Indian Premier League Final', '2024-05-20', 'Chennai'),
('Boston Marathon', '2024-04-19', 'Boston');


INSERT INTO contracts (sponsorID, matchID, contractDate, contractValue)
VALUES
(1, 1, '2024-08-01', 150000.00),
(2, 2, '2024-05-15', 200000.00),
(3, 3, '2024-09-20', 100000.00),
(4, 4, '2024-07-01', 180000.00),
(5, 5, '2024-06-10', 250000.00),
(6, 6, '2024-02-01', 220000.00),
(7, 7, '2024-07-25', 175000.00),
(8, 8, '2024-12-01', 300000.00),
(9, 9, '2024-05-10', 270000.00),
(10, 10, '2024-04-01', 160000.00);

INSERT INTO contracts (sponsorID, matchID, contractDate, contractValue)
VALUES
(1, 2, '2024-08-01', 150000.00),  
(1, 3, '2024-09-01', 130000.00); 


INSERT INTO contracts (sponsorID, matchID, contractDate, contractValue)
VALUES
(2, 4, '2024-07-01', 180000.00),  
(2, 5, '2024-06-01', 200000.00); 


INSERT INTO contracts (sponsorID, matchID, contractDate, contractValue)
VALUES
(3, 6, '2024-07-10', 120000.00),  
(3, 7, '2024-08-01', 140000.00); 



INSERT INTO payments (contractID, paymentDate, amountPaid, paymentStatus)
VALUES
(1, '2024-08-10', 75000.00, 'Completed'),
(1, '2024-09-10', 75000.00, 'Completed'),
(2, '2024-06-20', 100000.00, 'Completed'),
(2, '2024-07-20', 100000.00, 'Completed'),
(3, '2024-09-30', 50000.00, 'Completed'),
(3, '2024-10-30', 50000.00, 'Pending'),
(4, '2024-07-10', 90000.00, 'Completed'),
(4, '2024-08-10', 90000.00, 'Pending'),
(5, '2024-06-15', 125000.00, 'Completed'),
(6, '2024-02-20', 110000.00, 'Completed'),
(7, '2024-08-01', 87500.00, 'Completed'),
(8, '2024-12-10', 150000.00, 'Completed'),
(9, '2024-05-25', 135000.00, 'Completed'),
(10, '2024-04-10', 80000.00, 'Completed'),
(10, '2024-05-10', 80000.00, 'Pending');



select s.sponsorID, s.sponsorName, s.industryType, s.contactEmail, s.phone,
                    coalesce(sum(p.amountPaid), 0) as totalPaymentsMade,
                    count(p.paymentID) as numberOfPayments,
                    coalesce(max(p.paymentDate), '1900-01-01') as latestPaymentDate
                    from sponsors s left join contracts c on s.sponsorID = c.sponsorID
                    left join payments p on c.contractID = p.contractID
                    group by s.sponsorID, s.sponsorName, s.industryType, s.contactEmail, s.phone
                    order by s.sponsorID;




select m.matchID, m.matchName, m.matchDate, m.location,
                    coalesce(sum(p.amountPaid), 0) as totalPayments
                    from matches m left join contracts c on m.matchID = c.matchID
                    left join payments p on c.contractID = p.contractID
                    group by m.matchID, m.matchName, m.matchDate, m.location
                    order by m.matchDate;



select s.sponsorName, count(c.matchID) as numberOfMatches
                  from sponsors s join contracts c on s.sponsorID = c.sponsorID
                  join matches m on c.matchID = m.matchID
                  where extract(year from m.matchDate) = year
                  group by s.sponsorName order by numberOfMatches desc;



INSERT INTO payments (contractid, paymentdate, amountpaid, paymentstatus) 
                           VALUES (contractid, paymentdate, amountpaid, paymentstatus);

select * from matches;
select * from payments;



select contractID, contractValue from contracts order by contractValue desc limit 5;


update payments set paymentStatus = 'Completed' where paymentStatus = 'Pending' 
and paymentDate >= current_date - interval '7 days';

select * from matches where matchDate > '2024-07-01' order by matchDate;


