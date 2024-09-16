USE book_my_show;
CREATE TABLE City(
	PINCODE INT PRIMARY KEY ,
    City CHAR(20) NOT NULL);
CREATE TABLE Theater(
	Theater_id INT  PRIMARY KEY NOT NULL,
    Theater_name VARCHAR(40) NOT NULL ,
    PINCODE INT NOT NULL ,
    Total_Screens INT NOT NULL,
    Contact_email VARCHAR(50) NOT NULL,
    ADDRESS	 VARCHAR(50) NOT NULL,
	FOREIGN KEY (PINCODE) REFERENCES CITY(PINCODE) );

CREATE TABLE Movies(
	movie_id INT PRIMARY KEY ,
    Movie_name varchar(50) NOT NULL,
    Release_date DATE NOT NULL,
    Movie_duration TIME NOT NULL,
    Genre CHAR(30) NOT NULL,
    Language VARCHAR(20) NOT NULL,
    Description TEXT NOT NULL,
    Critics_Rating INT NOT NULL,
    Users_Rating INT NOT NULL,
    VOTES INT NOT NULL);
    
CREATE TABLE Screens(
	Screen_id INT PRIMARY KEY ,
    Sceen_name VARCHAR(20) NOT NULL,
    Total_seats INT NOT NULL,
	Screen_Size FLOAT NOT NULL,
    Theater_id INT NOT NULL,
    Description TEXT,
    Foreign key (Theater_id) references Theater(Theater_id)
    );
    
CREATE TABLE Seat(
	Seat_id VARCHAR(20)  PRIMARY KEY ,
    Screen_id INT  NOT NULL,
    Foreign key (Screen_id) references Screens(Screen_id),
    Seat_type Varchar(20) NOT NULL,
    Seat_price float NOT NULL,
    Seat_row CHAR(50) NOT NULL,
    Seat_column INT NOT NULL,
    foreign key (Screen_id) references Screens(screen_id)
    );

CREATE TABLE TIME_SLOT(
	Theater_id INT NOT NULL,
    Screen_id INT NOT NULL,
    Movie_id INT NOT NULL,
    Time_Date Date Not Null,
    Time_slot TIME PRIMARY KEY ,
    FOREIGN KEY (Theater_id) REFERENCES Theater(Theater_id),
    FOREIGN KEY (Movie_id) REFERENCES Movies(movie_id)
    );
    
CREATE TABLE Events(
	Event_id Varchar(25) PRIMARY KEY,
    Event_name Varchar(25) NOT NULL,
    Category Varchar(40) NOT NULL,
    Location Varchar(50) NOT NULL,
    PINCODE INT NOT NULL,
    FOREIGN KEY (PINCODE) REFERENCES CITY(PINCODE),
    OrganizED_BY VARCHAR(50) NOT NULL,
    Event_date date NOT NULL,
    Time_duration time ,
    Time_slot Time NOT NULL
);

CREATE TABLE Seat_Map(
	Seat_id VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (Seat_id) REFERENCES Seat(Seat_id),
    Screen_id INT NOT NULL,
    FOREIGN KEY (Screen_id) REFERENCES Screens(Screen_id),
    Theater_id INT NOT NULL,
    FOREIGN KEY (Theater_id) REFERENCES Theater(Theater_id),
    Time_slot TIME NOT NULL,
    FOREIGN KEY (Time_slot) REFERENCES Time_slot(Time_slot),
    
    Seat_Availability Varchar(10) NOT NULL,
    Date_ date Not Null
);


CREATE TABLE USER(
	user_id VARCHAR(20) PRIMARY KEY ,
    User_name CHAR(50) NOT NULL,
    Email VARCHAR(50) ,
    Phone_Number INT NOT NULL,
    AGE INT NOT NULL,
    GENDER CHAR(10) NOT NULL,
    Password VARCHAR(40) NOT NULL ,
    PINCODE INT NOT NULL,
    FOREIGN KEY (PINCODE) REFERENCES CITY(PINCODE)
    ); 
    
CREATE TABLE BOOKINGS(
	Booking_id VARCHAR(20) PRIMARY KEY,
    Booking_time time NOT NULL,
    Booking_date date NOT NULL,
	Time_slot TIME NOT NULL,
    FOREIGN KEY (Time_slot) REFERENCES Time_slot(Time_slot),
    Seat_id VARCHAR(20) ,
    FOREIGN KEY (Seat_id) REFERENCES Seat(Seat_id),
    User_id VARCHAR(20) NOT NULL,
    FOREIGN KEY (User_id) REFERENCES User(user_id),
	Screen_id INT NOT NULL,
    FOREIGN KEY (Screen_id) REFERENCES Screens(Screen_id),
    Theater_id INT NOT NULL,
    FOREIGN KEY (Theater_id) REFERENCES Theater(Theater_id),
    Movie_id INT,
    FOREIGN KEY (Movie_id) REFERENCES Movies(movie_id)
	);

CREATE TABLE PAYMENTS_INFO(
	Payment_id VARCHAR(20) Primary Key,
    Payment_method varchar(20) NOT NULL,
    Payment_Amount float NOT NULL,
    Payment_Time time NOT NULL,
    Payment_date date NOT NULL,
    User_id Varchar(20) NOT NULL,
    FOREIGN KEY (User_id) REFERENCES User(user_id)
	);

CREATE TABLE USER_ORDERS(
	Order_id VARCHAR(20) PRIMARY KEY,
    USER_ID VARCHAR(20) NOT NULL,
    FOREIGN KEY (User_id) REFERENCES User(user_id),
    DATE_ DATE NOT NULL
	);
    

-- List of theaters of a specific city
SELECT t.Theater_name, t.Total_Screens, t.ADDRESS
FROM Theater as t
JOIN City as c ON t.PINCODE = c.PINCODE
WHERE c.City = 'City Name';

-- MOVIES IN A Specific Theater
SELECT m.Movie_name, m.Release_date, m.Genre, m.Language
FROM Movies as m
JOIN TIME_SLOT as ts ON m.movie_id = ts.Movie_id
JOIN Theater as t ON t.Theater_id = ts.Theater_id
WHERE t.Theater_name = 'Theater Name';

-- List of the events happening on a specific date 
SELECT e.Event_name, e.Category, e.Location, e.OrganizED_BY, e.Event_date
FROM Events as e
JOIN City as c ON e.PINCODE = c.PINCODE
WHERE c.City = 'Your City Name'
AND e.Event_date = '2024-10-20';

--  list of seats in a specific screen with prices
SELECT s.Seat_id, s.Seat_type, s.Seat_price, s.Seat_row, s.Seat_column
FROM Seat as s
JOIN Screens as sc ON s.Screen_id = sc.Screen_id
WHERE sc.Sceen_name = 'Screen Name';

-- Users who booked a specific movie
SELECT u.User_name, u.Email, u.Phone_Number
FROM BOOKINGS as b
JOIN USER as u ON b.User_id = u.user_id
JOIN Movies as m ON b.Movie_id = m.movie_id
WHERE m.Movie_name = ' Movie Name';



    