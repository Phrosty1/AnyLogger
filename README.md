# AnyLogger

Looking at some logs and taking the one with the heaviest ratio, this is the how many entries and what kind of size to expect

[1] = "1632076638563;Nevira Pendragon;EVENT_COMBAT_EVENT;3000;true;;0;0;;0;;0;0;-1;1;false;0;69271;26305;0",
[3462] = "1632076810344;Nevira Pendragon;EVENT_LOGOUT_DEFERRED;10000;true",
1632076810344-1632076638563=171781
1000*3462/171781=20.15356762389321 per second

~20 per second * 4 users * (60*60*8) seconds in a long session
20.15356762389321*4*60*60*6=1741268 entries per short session
20.15356762389321*4*60*60*8=2321691 entries per long session

(325000 bytes / 171.781 sec) * 4 users * (60*60*8) seconds in a session
325000/171.781 = 1891.943812179461 bytes per second
1891.943812179461*4*60*60*6=163463945.3723054 bytes per short session
1891.943812179461*4*60*60*8=217951927.1630739 bytes per long session

In summary we should accumulate roughly 1.7 million entries (163mb) in a regular session of the four of us.
