CREATE TABLE room (
  room_id int PRIMARY KEY,
  rate numeric(5,2),
  bed_type varchar(15),
  bed_qty int
);

CREATE TABLE guest (
  guest_id int PRIMARY KEY,
  first_name varchar(35),
  last_name varchar(35),
  phone_number varchar(10),
  email varchar(62)
);

CREATE TABLE booking (
  room_id int REFERENCES room(room_id),
  guest_id int REFERENCES guest(guest_id),
  check_in_date date,
  check_out_date date
);

INSERT INTO room (room_id, rate, bed_type, bed_qty)
VALUES
(101, 99.99, 'full', 1),
(102, 99.99, 'full', 1),
(103, 119.99, 'full', 2),
(104, 119.99, 'full', 2),
(105, 109.99, 'queen', 1),
(106, 109.99, 'queen', 1),
(107, 149.99, 'queen', 2),
(108, 149.99, 'queen', 2),
(109, 139.99, 'king', 1),
(110, 139.99, 'king', 1);

INSERT INTO guest (guest_id, first_name, last_name, phone_number, email)
VALUES
(100001, 'Tory', 'Herman', '6515551234', 'tory.herman12@gmail.com'),
(100002, 'Eric', 'Northman', '5045550001', 'eric@fangtasia.com'),
(100003, 'Sam', 'Merlotte', '3185551111', 'sam@merlottes.com'),
(100004, 'Sookie', 'Stackhouse', '3185555309', 'sookie@merlottes.com'),
(100005, 'Andy', 'Bellefleur', '3375555050', 'sheriff.bellefleur@renardpd.gov');

INSERT INTO booking (room_id, guest_id, check_in_date, check_out_date)
VALUES
(101, 100001, '2017-09-22', '2017-09-24'),
(103, 100001, '2017-09-22', '2017-09-24'),
(101, 100005, '2017-09-24', '2017-09-30'),
(104, 100003, '2017-10-31', '2017-11-03'),
(110, 100001, '2018-01-05', '2018-01-08'),
(106, 100002, '2017-09-18', '2017-09-19'),
(107, 100005, '2017-10-14', '2017-10-21'),
(104, 100003, '2017-12-24', '2017-12-27');

/* find a guest who exists in the db who has not booked a room */
SELECT CONCAT(g.first_name, ' ', g.last_name) AS name
FROM guest g
LEFT OUTER JOIN booking b
ON g.guest_id = b.guest_id
WHERE b.room_id IS NULL;

/* find bookings for a guest who has booked two rooms for the same dates */
SELECT CONCAT(g.first_name, ' ', g.last_name) AS name, b.check_in_date, b.check_out_date, COUNT(*) AS rooms_booked
FROM guest g
JOIN booking b
ON g.guest_id = b.guest_id
GROUP BY b.check_in_date, b.check_out_date, g.guest_id
HAVING COUNT(*) > 1;

/* find books for a guest who has booked one room several times */
SELECT CONCAT(g.first_name, ' ', g.last_name) AS name, r.room_id, COUNT(*) AS bookings
FROM booking b
JOIN guest g
ON b.guest_id = g.guest_id
JOIN room r
ON b.room_id = r.room_id
GROUP BY g.guest_id, r.room_id
HAVING COUNT(*) > 1;

/* find number of unique guests who have booked the same room */
SELECT r.room_id, COUNT(DISTINCT(r.room_id, g.guest_id)) AS unique_guests
FROM booking b
JOIN room r
ON b.room_id = r.room_id
JOIN guest g
ON b.guest_id = g.guest_id
GROUP BY r.room_id;
