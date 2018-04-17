# Problem

You are in charge of assigning meeting rooms at your company. Especially many meetings have
been planned for next Thursday, so you decided to write a program to help you fit the meetings
within your time constraints.

- There are 2 meeting rooms
- The meetings have to be scheduled during core work hours (09:00 - 17:00)
- No meetings can be scheduled during lunchtime (12:00 - 13:00)
- Meetings at your company never overrun and can be scheduled back-to-back, with no
gaps in between them
- Apart from these constraints, meetings can be placed anywhere, and the duration of
gaps between them doesn't matter.

The input contains one meeting per line; the meeting title can contain any characters and is
followed by a space and the meeting duration, which is always given in minutes. Since multiple
meeting configurations are possible, the test output given here is only one of the possible
solutions, and your output doesn't have to match it as long as it meets all constraints.

Test input:
```
All Hands meeting 60min
Marketing presentation 30min
Product team sync 30min
Ruby vs Go presentation 45min
New app design presentation 45min
Customer support sync 30min
Front-end coding interview 60min
Skype Interview A 30min
Skype Interview B 30min
Project Bananaphone Kickoff 45min
Developer talk 60min
API Architecture planning 45min
Android app presentation 45min
Back-end coding interview A 60min
Back-end coding interview B 60min
Back-end coding interview C 60min
Sprint planning 45min
New marketing campaign presentation 30min
```
Test output:
```
Room 1:
09:00AM All Hands meeting 60min
10:00AM API Architecture planning 45min
10:45AM Product team sync 30min
11:15AM Ruby vs Go presentation 45min
12:00PM Lunch
01:00PM Back-end coding interview A 60min
02:00PM Android app presentation 45min
02:45PM New app design presentation 45min
03:30PM New marketing campaign presentation 30min
04:00PM Customer support sync 30min
04:30PM Skype Interview A 30min

Room 2:
09:00AM Back-end coding interview B 60min
10:00AM Front-end coding interview 60min
11:00AM Skype Interview B 30min
12:00PM Lunch
01:00PM Project Bananaphone Kickoff 45min
01:45PM Sprint planning 45min
02:30PM Marketing presentation 30min
03:00PM Developer talk 60min
04:00PM Back-end coding interview C 60min
```

# How to run

```
ruby server.rb
```
Will start simple http server on 4567 port. Http server was made just for comfort.

# Note
Problem is solved by using principles of dynamic programming.

Because of algorithm complexity naive solution could cause performance troubles.

There is also approximate solution, that would be less complex. But sometimes it could fail to find solution even if it exists.

Though they both are not perfect, they are very simple to implemet. So, sometimes it could be fine to use one of them.
