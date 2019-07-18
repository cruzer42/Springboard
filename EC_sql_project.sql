/* Welcome to the SQL mini project. For this project, you will use
Springboard' online SQL platform, which you can log into through the
following link:

https://sql.springboard.com/
Username: student
Password: learn_sql@springboard

The data you need is in the "country_club" database. This database
contains 3 tables:
    i) the "Bookings" table,
    ii) the "Facilities" table, and
    iii) the "Members" table.

Note that, if you need to, you can also download these tables locally.

In the mini project, you'll be asked a series of questions. You can
solve them using the platform, but for the final deliverable,
paste the code for each solution into this script, and upload it
to your GitHub.

Before starting with the questions, feel free to take your time,
exploring the data, and getting acquainted with the 3 tables. */



/* Q1: Some of the facilities charge a fee to members, but some do not.
Please list the names of the facilities that do. */

SELECT name
FROM  Facilities 
WHERE membercost > 0

Result:
Tennis Court 1
Tennis Court 2
Massage Room 1
Massage Room 2
Squash Court

/* Q2: How many facilities do not charge a fee to members? */

SELECT COUNT( * ) 
FROM Facilities
WHERE membercost = 0

Result:
4

/* Q3: How can you produce a list of facilities that charge a fee to members,
where the fee is less than 20% of the facility's monthly maintenance cost?
Return the facid, facility name, member cost, and monthly maintenance of the
facilities in question. */

SELECT facid, name, membercost, monthlymaintenance
FROM Facilities 
WHERE membercost < monthlymaintenance * 0.2

Result:
All 9 rows intable returned

/* Q4: How can you retrieve the details of facilities with ID 1 and 5?
Write the query without using the OR operator. */

SELECT * FROM Facilities WHERE facid in (1,5) 

Result:
2 rows returned


/* Q5: How can you produce a list of facilities, with each labelled as
'cheap' or 'expensive', depending on if their monthly maintenance cost is
more than $100? Return the name and monthly maintenance of the facilities
in question. */

SELECT name, monthlymaintenance,
	CASE 
		WHEN monthlymaintenance > 100
			THEN 'expensive'
			ELSE 'cheap'
	END AS label
FROM Facilities

Result:
Tennis Court 1 200 expensive
Tennis Court 2 200 expensive
Badminton Court 50 cheap
Table Tennis 10 cheap
Massage Room 1 3000 expensive
Massage Room 2 3000 expensive
Squash Court 80 cheap
Snooker Table 15 cheap
Pool Table 15 cheap


/* Q6: You'd like to get the first and last name of the last member(s)
who signed up. Do not use the LIMIT clause for your solution. */

SELECT firstname, surname
FROM Members
WHERE joindate = (SELECT MAX(joindate) from Members)

Result:
Darren Smith

/* Q7: How can you produce a list of all members who have used a tennis court?
Include in your output the name of the court, and the name of the member
formatted as a single column. Ensure no duplicate data, and order by
the member name. */

SELECT DISTINCT 
	CONCAT(m.surname, ", ", m.firstname) AS member, 
	f.name AS facility
FROM  `Members` m
	JOIN  `Bookings` b ON m.memid = b.memid
	JOIN  `Facilities` f ON b.facid = f.facid
		WHERE b.facid
			IN ( 0, 1 )
				AND b.memid <> 0
ORDER BY member

Result (44 rows):
Bader, Florence Tennis Court 2
Bader, Florence Tennis Court 1
Baker, Anne Tennis Court 1
Baker, Anne Tennis Court 2
Baker, Timothy Tennis Court 2
Baker, Timothy Tennis Court 1
Boothe, Tim Tennis Court 1
Boothe, Tim Tennis Court 2
Butters, Gerald Tennis Court 1
Butters, Gerald Tennis Court 2
Coplin, Joan Tennis Court 1
Crumpet, Erica Tennis Court 1
Dare, Nancy Tennis Court 1
Dare, Nancy Tennis Court 2
Farrell, David Tennis Court 1
Farrell, David Tennis Court 2
Farrell, Jemima Tennis Court 1
Farrell, Jemima Tennis Court 2
Genting, Matthew Tennis Court 1
Hunt, John Tennis Court 1
Hunt, John Tennis Court 2
Jones, David Tennis Court 1
Jones, David Tennis Court 2
Jones, Douglas Tennis Court 1
Joplette, Janice Tennis Court 1
Joplette, Janice Tennis Court 2
Owen, Charles Tennis Court 1
Owen, Charles Tennis Court 2
Pinker, David Tennis Court 1
Purview, Millicent Tennis Court 2
Rownam, Tim Tennis Court 2
Rownam, Tim Tennis Court 1
Rumney, Henrietta Tennis Court 2
Sarwin, Ramnaresh Tennis Court 2
Sarwin, Ramnaresh Tennis Court 1
Smith, Darren Tennis Court 2
Smith, Jack Tennis Court 2
Smith, Jack Tennis Court 1
Smith, Tracy Tennis Court 2 
Smith, Tracy Tennis Court 1
Stibbons, Ponder Tennis Court 1
Stibbons, Ponder Tennis Court 2
Tracy, Burton Tennis Court 2
Tracy, Burton Tennis Court 1

Alternate solution for either Tennis Court as one facility: 	

SELECT DISTINCT 
	CONCAT(m.surname, ", ", m.firstname) AS member, 
	CASE	
		WHEN f.facid IN (0,1)
			THEN 'Tennis Court 1 or 2'
	END AS facility
FROM  `Members` m
	JOIN  `Bookings` b ON m.memid = b.memid
	JOIN  `Facilities` f ON b.facid = f.facid
		WHERE b.facid
			IN ( 0, 1 )
				AND b.memid <> 0
ORDER BY member

Result (26 rows):
Bader, Florence Tennis Court 1 or 2
Baker, Anne Tennis Court 1 or 2
Baker, Timothy Tennis Court 1 or 2
Boothe, Tim Tennis Court 1 or 2
Butters, Gerald Tennis Court 1 or 2
Coplin, Joan Tennis Court 1 or 2
Crumpet, Erica Tennis Court 1 or 2
Dare, Nancy Tennis Court 1 or 2
Farrell, David Tennis Court 1 or 2
Farrell, Jemima Tennis Court 1 or 2
Genting, Matthew Tennis Court 1 or 2
Hunt, John Tennis Court 1 or 2
Jones, David Tennis Court 1 or 2
Jones, Douglas Tennis Court 1 or 2
Joplette, Janice Tennis Court 1 or 2
Owen, Charles Tennis Court 1 or 2
Pinker, David Tennis Court 1 or 2
Purview, Millicent Tennis Court 1 or 2
Rownam, Tim Tennis Court 1 or 2
Rumney, Henrietta Tennis Court 1 or 2
Sarwin, Ramnaresh Tennis Court 1 or 2
Smith, Darren Tennis Court 1 or 2
Smith, Jack Tennis Court 1 or 2
Smith, Tracy Tennis Court 1 or 2
Stibbons, Ponder Tennis Court 1 or 2
Tracy, Burton Tennis Court 1 or 2

/* Q8: How can you produce a list of bookings on the day of 2012-09-14 which
will cost the member (or guest) more than $30? Remember that guests have
different costs to members (the listed costs are per half-hour 'slot'), and
the guest user's ID is always 0. Include in your output the name of the
facility, the name of the member formatted as a single column, and the cost.
Order by descending cost, and do not use any subqueries. */


/* Q9: This time, produce the same result as in Q8, but using a subquery. */


/* Q10: Produce a list of facilities with a total revenue less than 1000.
The output of facility name and total revenue, sorted by revenue. Remember
that there's a different cost for guests and members! */

