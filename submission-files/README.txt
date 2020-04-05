Shortcomings of the front-end:
There are some minor things that the front-end falls short on accomplishing. 
Following is a list of those shortcomings to help you interact with the application:
- Whenever a query is submitted (clicking the submit button), the page reloads 
  and scrolls back to the top, however the query results are rendered. 
- For the queries that have a dropdown list, once a query like this has been 
  submitted, the dropdown input changes back to the default value and thus the query 
  result can be confusing. To make it easier to understand the result, the option that 
  was selected from the list is also rendered when the query is submitted.
- If a query was submitted and its results have been rendered and following 
  this another query is submitted, the previous result will not render. That 
  means, at a time, only one query result will be rendered on the front-end.
- When an update/delete event query is run, the dropdown input lists for events 
  aren't updated right away. These require an extra page reload to be updated.
	- For example, if in the update event section, the dropdown list has 
	  an event XYZ, and this event's name is updated to say X, then the 
	  update will happen, however the dropdown will still show XYZ.

  
