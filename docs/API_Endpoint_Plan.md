1.Authentication Endpoints

HTTP method:POST
ROUTE:/api/auth/register
Description: This endpoint allows users to register for an account by providing their email, password, and other required information. Upon successful registration, the user will receive a confirmation email.
Role Required: None
Request body:{fullName,email,password,role}
Expected Response: 201 Created new user id and JWT.400 Bad Request Validation failed (Weak password,invalid email). Conflict 409 email already registered.

HTTP method:POST
ROUTE:/api/auth/login
Description: This endpoint allows users to log in to their account by providing their email and password. Upon successful login, the user will receive a JWT token for authentication.
Role Required: None
Request body:{email,password}
Expected Response: 200 OK JWT token and user summary(id,name,role).401 Unauthorized Invalid credentials.

2.User Profile Endpoints

HTTP method:GET
ROUTE:/api/user/me
Description: This endpoint allows authenticated users to retrieve their own profile information.
Role Required: Any
Request body: None
Expected Response: 200 OK User profile information.401 Unauthorized Invalid or missing JWT token.

HttP method:PUT
route:/api/user/me
Description: This endpoint allows authenticated users to update their own profile information, such as name, email, and password.
Role Required: Any
Request body:{fullName,phoneNumber}
Expected Response: 200 OK Updated user profile information.400 Bad Request Validation failed (Weak password,invalid email).401 Unauthorized Invalid or missing JWT token.

3.Events

HTTP Method:GET
ROUTE:/api/events
Description: This endpoint allows users to retrieve a list of all events. Users can filter events based on date, location, or category.
Role Required: None
Request body: None
Expected Response: 200 OK List of events.400 Bad Request Invalid query parameters.

HTTP Method:get
Route:/api/events/:id
Description: This endpoint allows users to retrieve detailed information about a specific event by providing the event ID.
Role Required: None
request body: None
Expected Response: 200 OK Event details.404 Not Found Event with the specified ID does not exist.

HTTP Method:POST
ROUTE:/api/events
Description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to create a new event by providing event details such as name, date, location, and description.
Role Required: Admin or Event Organizer
Request body:{eventname,eventdate,location,description}
Expected Response: 201 Created New event ID.400 Bad Request Validation failed (Missing required fields, invalid date format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to create an event.

HTTP Method:PUT
ROUTE:/api/events/:id
Description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to update an existing event by providing the event ID and updated event details.
Role Required: Admin or Event Organizer
Request body:{eventname,eventdate,location,description}
Expected Response: 200 OK Updated event details.400 Bad Request Validation failed (Missing required fields, invalid date format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to update the event.404 Not Found Event with the specified ID does not exist.

HTTP Method:DELETE
route:/api/events/:id
Description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to delete an existing event by providing the event ID.
Role Required: Admin or Event Organizer
Request body: None
Expected Response: 200 OK Event deleted successfully.401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to delete the event.404 Not Found Event with the specified ID does not exist.

4.Categories

http method:GET
route:/api/events/{eventId}/categories
description: This endpoint allows users to retrieve a list of categories associated with a specific event by providing the event ID.
Role Required: None
Request body: None
Expected Response: 200 OK List of categories for the specified event.404 Not Found Event with the specified ID does not exist.

Http method:POST
route:/api/events/{eventId}/categories
description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to create a new category for a specific event by providing the event ID and category details.
role Required: Admin or Event Organizer
Request body:{categoryName,distanceKm,entryFee,maxParticipants}
Expected Response: 201 Created New category ID.400 Bad Request Validation failed (Missing required fields, invalid data format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to create a category.404 Not Found Event with the specified ID does not exist.

HTTP method:PUT
ROUTE:/api/categories/{id}
DESCRIPTION: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to update an existing category for a specific event by providing the event ID, category ID, and updated category details.
ROLE Required: Admin or Event Organizer
Request body:{categoryName,distanceKm,entryFee,maxParticipants}
EXPECTED Response: 200 OK Updated category details.400 Bad Request Validation failed (Missing required fields, invalid data format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to update the category.404 Not Found Event or category with the specified IDs does not exist.

HTTP method:DELETE
ROUTE:/api/categories/{id}
DESCRIPTION: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to delete an existing category by providing the category ID.
ROLE Required: Admin or Event Organizer
Request body: None
EXPECTED Response: 200 OK Category deleted successfully.401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to delete the category.404 Not Found Category with the specified ID does not exist.

5.Event Enrollments

HTTP method:POST
ROUTE:/api/categories/{categoryId}/enroll
Description: This endpoint allows authenticated users to enroll in a specific category of an event by providing the category ID. Users may need to provide additional information such as payment details if the category has an entry fee.
Role Required: Parcitipant
Request body:None
Expected Response: 201 Created Enrollment confirmation.400 Bad Request Validation failed (Missing required fields, invalid data format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to enroll in the category.404 Not Found Category with the specified ID does not exist.409 Conflict User is already enrolled in the category.

Http method:GET
route:/api/enrolements/me
Description: This endpoint allows authenticated users to retrieve a list of their own enrollments in various event categories.
Role Required: Participant
Request body: None
Expected Response: 200 OK List of user enrollments.401 Unauthorized Invalid or missing JWT token.

HTTP method:DELETE
ROUTE:/api/enrollments/{enrollmentId}
Description: This endpoint allows authenticated users to cancel their enrollment in a specific category by providing the enrollment ID.
Role Required: Participant
Request body: None
Expected Response: 200 OK Enrollment canceled successfully.401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to cancel the enrollment.404 Not Found Enrollment with the specified ID does not exist.

6. Results

HTTP METHOD: POST
ROUTE: /api/results
Description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to submit results for a specific category of an event by providing the category ID and result details.
Role Required: Admin or Event Organizer
Request body: {categoryId, participantId, resultTime, position,finishTimeSeconds}
Expected Response: 201 Created Result submitted successfully.400 Bad Request Validation failed (Missing required fields, invalid data format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to submit results.404 Not Found Category or participant with the specified IDs does not exist.

HTTP METHOD: PUT
ROUTE: /api/results/{resultId}
Description: This endpoint allows authenticated users with the appropriate role (e.g., admin or event organizer) to update results for a specific category of an event by providing the result ID and updated result details.
ROLE Required: Admin or Event Organizer
Request body: {resultTime, position, finishTimeSeconds}
Expected Response: 200 OK Result updated successfully.400 Bad Request Validation failed (Missing required fields, invalid data format).401 Unauthorized Invalid or missing JWT token.403 Forbidden User does not have the required role to update results.404 Not Found Result with the specified ID does not exist.

HTTP METHOD: GET
ROUTE: /api/results/me
Description: This endpoint allows authenticated users to retrieve their own results in various event categories.
Role Required: Participant
Request body: None
Expected Response: 200 OK List of user results.401 Unauthorized Invalid or missing JWT token.

HTTP METHOD: GET
ROUTE: /api/events/{eventId}/results
Description: This endpoint allows users to retrieve results for a specific event by providing the event ID. Users can filter results based on category or participant.
Role Required: None
Request body: None
Expected Response: 200 OK List of results for the specified event.400 Bad Request Invalid query parameters.404 Not Found Event with the specified ID does not exist.
