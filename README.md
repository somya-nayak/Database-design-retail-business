# Introduction
Cornerstone retail is a small business that sells novelty items at music events, tradeshows, and other commercial events. It started by selling products such as hula hoops, whoopee cushion etc. As the sales grew and it started selling at more and more events, several salespeople were hired to help handle the growing sales at the events.

# Problem statement
At the start, all the sales were tracked manually on paper and then sales totals were transposed into Excel spreadsheets. Over time, more and more disparate worksheets were created that contained details such as event information, sales, employee commissions, and product data. Keeping track of all the information was becoming a major administrative hassle and led to errors. The solution is to create a custom database that can help track all the business information in a more effective and integral manner.

# Database design
The first step is identifying all the possible entities and information that needs to be captured. Below is the database design listing out all the entities, columns, and the entity relationship.
![image](https://user-images.githubusercontent.com/68967551/147394480-42f37f11-74d8-4b24-a43a-4742d7af115f.png)

Explanation: 
- Venue and event have a one-to-many relationship as multiple events can be held in a single venue
- Event and booth have a one-to-many relationship as multiple booths can be set up in a single event
- Booth and shift have a one-to-many relationship as multiple shifts can be assigned to one booth
- Salesperson and shift have a one-to-many relationship as multiple shifts can be held in a single salesperson
- Event, shift, and sales have a one-to-many relationship as multiple sales can occur in a single event and in a single shift. This was done because it is important to track the sales for each salesperson, for every shift worked. It is also important to track sales by event.
- Product and sales have many-to-many relationship as a product can be sold multiple times and multiple products can be sold in one sale. So, to counter this I created a linking table between product and sales table which will have one-to-many relationship with both the tables.

