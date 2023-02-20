# Burency Demo

A simple contact management web app developed using Flutter Web as frontend and Firebase as backend.

**General Features:**

- Login and Register using Firebase Email Authentication
- View, Add, Update and Delete contacts
- Search contact using keywords or Geo Location
- Server-less backend using Firebase Cloud Functions

## Backend: Firebase Cloud Functions

**Features:**

- Provide both HTTP Triggers (REST API) and Callable Triggers (for frontend app)
- Organized and grouped functions into multiple files
- Integrated with Algolia for real-time and geo location search

### REST API Calls

#### REGISTER:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htUser-register](https://us-central1-burencydemo.cloudfunctions.net/htUser-register)
- **Method:** POST
- **Bearer Token:** None
- **Request Body:**
  ```
    {
      "email": "{youremail@domain.com}",
      "password": "{your password}"
    }
  ```
- **Response:**
  - Success:
  ```
  {}
  ```
  - Failed: See **Error Response**

#### LOGIN:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htUser-login](https://us-central1-burencydemo.cloudfunctions.net/htUser-login)
- **Method:** POST
- **Bearer Token:** None
- **Request Body:**
  ```
  {
    "email": "{youremail@domain.com}",
    "password": "{your password}"
  }
  ```
- **Response:**
  - Succces:
  ```
  {
    "uid": -"{User Id}"-,
    "token": -"{Bearer Token}"-
  }
  ```
  - Failed: See **Error Response**

#### ADD CONTACT:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htContact-add](https://us-central1-burencydemo.cloudfunctions.net/htContact-add)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}", // Required
    "firstName": "{First Name}", // Required
    "middleName": "{Middle Name}",
    "lastName": "{Last Name}", // Required
    "phone": "{Phone Number}", // Required, Numeric
    "address": "{Full Address}",
    "note": "{Note}",
    "latitude": {GeoLoc Latitude}, // -90 to 90
    "longitude": {GeoLoc Longitude} // -180 to 180
  }
  ```
- **Response:**
  - Success:
  ```
  {
    "id": "{Contact Document Id}",
    "firstName": "{First Name}",
    "middleName": "{Middle Name}",
    "lastName": "{Last Name}",
    "phone": "{Phone Number}",
    "address": "{Full Address}",
    "note": "{Note}",
    "location": {
      "_latitude": {Latitude},
      "_longitude": {Longitude}
    },
    "geoHash": "{Geo Hash}",
    "timestamp": "{Timestamp}"
  }
  ```
  - Failed: See **Error Response**

#### UPDATE CONTACT:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htContact-update](https://us-central1-burencydemo.cloudfunctions.net/htContact-update)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}", // Required
    "id": "{Contact Document Id}", // Required
    "firstName": "{First Name}", // Required
    "middleName": "{Middle Name}",
    "lastName": "{Last Name}", // Required
    "phone": "{Phone Number}", // Required, Numeric
    "address": "{Full Address}",
    "note": "{Note}",
    "latitude": {GeoLoc Latitude}, // -90 to 90
    "longitude": {GeoLoc Longitude} // -180 to 180
  }
  ```
- **Response:**
  - Success:
  ```
  {}
  ```
  - Failed: See **Error Response**

#### DELETE CONTACT:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htContact-delete](https://us-central1-burencydemo.cloudfunctions.net/htContact-delete)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}",
    "id": "{Contact Document Id}" // Required
  }
  ```
- **Response:**
  - Success:
  ```
  {}
  ```
  - Failed: See **Error Response**

#### SEARCH CONTACTS:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htContact-search](https://us-central1-burencydemo.cloudfunctions.net/htContact-search)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}",
    "query": "{keyword or search term}",
    "limit": {Hits per page},
    "page": {Page Number}, // Zero-based, 0 is Page 1, 1 is Page 2 and so on...
    "latitude": {GeoLoc Latitude}, // -90 to 90
    "longitude": {GeoLoc Longitude} // -180 to 180
    "radiusInMeters": {Radius in meters from the Geo Location}
  }
  ```
  > **_NOTE: All three parameters: latitude, longitude and radiusInMeters must be provided to trigger geo-location search_**
- **Response:**
  - Success:
  ```
  {
    "hits": [
      {
        "address": "8348 Homenick Coves, West Seneca, Ohio, Saint Kitts and Nevis",
        "firstName": "Marcus",
        "geoHash": "cz36nmn04h",
        "lastName": "Mohr",
        "location": {
          "_latitude": 86.1603,
          "_longitude": -99.2092
        },
        "middleName": "Sawyer",
        "note": "District Marketing Administrator",
        "phone": "+337510720757",
        "timestamp": {
          "_seconds": 1676711501,
          "_nanoseconds": 480000000
        },
        "_geoloc": {
          "lat": 86.1603,
          "lng": -99.2092
        },
        "objectID": "zKdGFTNVFZrrUqAFzNlp",
        "_highlightResult": {
          "address": {
            "value": "8348 Homenick Coves, West Seneca, Ohio, Saint Kitts and Nevis",
            "matchLevel": "none",
            "matchedWords": []
          },
          "firstName": {
            "value": "Marcus",
            "matchLevel": "none",
            "matchedWords": []
          },
          "lastName": {
            "value": "Mohr",
            "matchLevel": "none",
            "matchedWords": []
          },
          "middleName": {
            "value": "Sawyer",
            "matchLevel": "none",
            "matchedWords": []
          },
          "note": {
            "value": "District Marketing Administrator",
            "matchLevel": "none",
            "matchedWords": []
          },
          "phone": {
            "value": "+337510720757",
            "matchLevel": "none",
            "matchedWords": []
          }
        }
      }
    ]
  }
  ```
  > **_NOTE: objectID is the Unique Document Id_**
  - Failed: See **Error Response**

#### SEARCH NEARBY CONTACTS:

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htContact-searchNearby](https://us-central1-burencydemo.cloudfunctions.net/htContact-searchNearby)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}",
    "limit": {Hits per page},
    "page": {Page Number}, // Zero-based, 0 is Page 1, 1 is Page 2 and so on...
    "radiusInMeters": {Radius in meters from current location}
  }
  ```
  > **_NOTE: radiusInMeters will be centered on the caller's current geo location using IP Address_**
- **Response:**
  - Success: Same as **SEARCH CONTACT**
  - Failed: See **Error Response**

#### SEARCH HISTORY (Contact Update Logs):

- **End Point:** [https://us-central1-burencydemo.cloudfunctions.net/htHistory-search](https://us-central1-burencydemo.cloudfunctions.net/htHistory-search)
- **Method:** POST
- **Bearer Token:** Required (acquired from Login)
- **Request Body:**
  ```
  {
    "uid": "{User Id acquired from Login}",
    "id": "", // Contact Document Id, leave empty to select all
    "sortDesc": true, // Sort by desc or asc timestamp
    "limit": {Hits per page},
    "page": {Page Number}, // Zero-based, 0 is Page 1, 1 is Page 2 and so on...
  }
  ```
- **Response:**
  - Success:
  ```
  [
    {
      "docId": "YZSHt9JaSOLWtWLvU7Uf",
      "phone": "639170000009",
      "changes": "firstName,lastName,note,location",
      "id": "4MT4CXd1W1kakt7KYn2F",
      "type": "UPDATE_CONTACT",
      "timestamp": {
        "_seconds": 1676876178,
        "_nanoseconds": 846000000
      }
    },
    {
      "docId": "YLwax83kwaAmsICP44nD",
      "phone": "639170000009",
      "changes": "",
      "id": "4MT4CXd1W1kakt7KYn2F",
      "type": "ADD_CONTACT",
      "timestamp": {
        "_seconds": 1676876136,
        "_nanoseconds": 386000000
      }
    }
  ]
  ```
  > **_NOTE: id is the Contact Document Id, docId is the History Document Id_**
  - Failed: See **Error Response**

#### ERROR RESPONSE:

```
{
  "code": "{Error Code}",
  "message": "{Error Message}"
}
```

## Frontend: Flutter Web

Live Demo: [https://burencydemo.web.app/](https://burencydemo.web.app/)

**Features:**

- Used Flutter v3.7.0 and Material v3.0
- State management using GetX
- Used infinite scroll with lazy loading instead of pagination
- Used RegEx validators and formatters on text field inputs to sanitize data
- Touch gesture to scroll up and down the list on browser (like mobile device)
