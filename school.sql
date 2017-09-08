/* would add street address, email, phone etc but seems superfluous for this activity */

CREATE TABLE student (
  student_id int PRIMARY KEY,
  first_name varchar(35),
  last_name varchar(35)
  -- street_address varchar(80),
  -- city varchar(35),
  -- state char(2),
  -- zip varchar(5),
  -- telephone varchar(10),
  -- email varchar(70),
  -- active boolean
);

CREATE TABLE professor (
  professor_id int PRIMARY KEY,
  first_name varchar(35),
  last_name varchar(35)
  -- street_address varchar(80),
  -- city varchar(35),
  -- state char(2),
  -- zip varchar(5),
  -- telephone varchar(10),
  -- email varchar(70),
  -- active boolean
);

CREATE TABLE class (
  class_id int PRIMARY KEY,
  class_title varchar(70)
);

CREATE TABLE roster (
  roster_id int PRIMARY KEY,
  class_id int REFERENCES class(class_id),
  professor_id int REFERENCES professor(professor_id),
  term daterange
);

CREATE TABLE student_roster (
  student_roster_id int PRIMARY KEY,
  roster_id int REFERENCES roster(roster_id),
  student_id int REFERENCES student(student_id),
  grade char(2)
);

INSERT INTO student (student_id, first_name, last_name)
VALUES
(100001, 'Tory', 'Herman'),
(100002, 'Joe', 'Mauer'),
(100003, 'Carl', 'Pavano'),
(100004, 'Brad', 'Radke'),
(100005, 'Corey', 'Koskie'),
(100006, 'Denny', 'Hocking'),
(100007, 'Matt', 'Lawton'),
(100008, 'Buck', 'Buchanan'),
(100009, 'Eddie', 'Guardado'),
(100010, 'Mike', 'Redmond');

INSERT INTO professor (professor_id, first_name, last_name)
VALUES
(200001, 'Torii', 'Hunter'),
(200002, 'Jeff', 'Reardon'),
(200003, 'Rick', 'Aguilera'),
(200004, 'Bert', 'Blyleven'),
(200005, 'Bobby', 'Kielty'),
(200006, 'Jacque', 'Jones'),
(200007, 'Pat', 'Mears'),
(200008, 'Luis', 'Rivas'),
(200009, 'Cristian', 'Guzman'),
(200010, 'Tom', 'Prince');

INSERT INTO class (class_id, class_title)
VALUES
(300001, 'Pitching Mechanics'),
(300002, 'Bunting'),
(300003, 'Infield I'),
(300004, 'Infield II'),
(300005, 'Outfield I');

INSERT INTO roster (roster_id, class_id, professor_id, term)
VALUES
(400001, 300001, 200002, '[2017-09-05, 2017-12-20]'),
(400002, 300002, 200009, '[2017-09-05, 2017-12-20]'),
(400003, 300003, 200007, '[2017-02-04, 2017-05-25]'),
(400004, 300004, 200001, '[2017-02-04, 2017-05-25]'),
(400005, 300005, 200008, '[2016-02-06, 2016-05-27]');

INSERT INTO student_roster (student_roster_id, roster_id, student_id, grade)
VALUES
(500001, 400001, 100001, 'A'),
(500002, 400001, 100002, 'B-'),
(500003, 400001, 100003, 'B+'),
(500004, 400001, 100004, 'B'),
(500005, 400001, 100008, 'A'),
(500006, 400002, 100006, 'C+'),
(500007, 400002, 100009, 'A-'),
(500008, 400003, 100002, 'B+'),
(500009, 400003, 100010, 'C-'),
(500010, 400004, 100008, 'B'),
(500011, 400004, 100009, 'A'),
(500012, 400004, 100005, 'C+'),
(500013, 400005, 100001, 'A'),
(500014, 400005, 100010, 'B'),
(500015, 400005, 100009, 'C+'),
(500016, 400005, 100007, 'B+');

/* find all students who have taken a particular class */
SELECT CONCAT(s.first_name, ' ', s.last_name) AS name
FROM student s
JOIN student_roster z
ON s.student_id = z.student_id
WHERE z.roster_id = 400001;

/* find class names and total amount of students who have taken class */
SELECT c.class_title, COUNT(z.student_id) AS total_students
FROM class c
JOIN roster r
ON c.class_id = r.class_id
JOIN student_roster z
ON r.roster_id = z.roster_id
GROUP BY c.class_title
ORDER BY total_students DESC;

/* find class taken by largest amount of students */
SELECT c.class_title, COUNT(z.student_id) AS total_students
FROM class c
JOIN roster r
ON c.class_id = r.class_id
JOIN student_roster z
ON r.roster_id = z.roster_id
GROUP BY c.class_title
ORDER BY total_students DESC
LIMIT 1;
