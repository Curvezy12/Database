-- 103641460 Seb Conway 

/* TOUR (TourName, Description)
PK (TourName)

EVENT (TourName, EventYear, EventMonth, EventDay, Fee)
PK (EventYear, EventMonth, EventDay)
FK (TourName) References TOUR

BOOKING (EventYear, EventMonth, EventDay, ClientID, DateBooked, Payment)
FK (EventYear, EventMonth, EventYear) References EVENT
FK (ClientID) References CLIENT

CLIENT (ClientID, Surname, GivenName, Gender)
PK (ClientID) */ 

