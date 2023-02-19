import * as admin from 'firebase-admin';

// Start writing functions
// https://firebase.google.com/docs/functions/typescript

admin.initializeApp();

// DB Triggers (invoked by DB events)
exports.dbContact = require('./api/contact/_db');
// exports.dbContact = require('./api/contact/_dbTemp');

// HTTP Triggers (invoked by REST requests)
// Export functions from api/contact/_http.ts in the "contact" group : htContact-{function}
exports.htContact = require('./api/contact/_http');
// Export functions from api/user/_http.ts in the "user" group : htUser-{function}
exports.htUser = require('./api/user/_http');
// Export functions from api/history/_http.ts in the "history" group : htHistory-{function}
exports.htHistory = require('./api/history/_http');

// Callable Triggers (invoked by frontend app)
// Export functions from api/contact/_call.ts in the "contact" group : caContact-{function}
exports.caContact = require('./api/contact/_call');
// Export functions from api/history/_call.ts in the "history" group : caHistory-{function}
exports.caHistory = require('./api/history/_call');

// User Story:
//      - As a User I can Register
//      - As a User I can Login To App
//      - As a User I can insert contact
//          (Name,Middle name,Surname,Phone number,note,Address,Location(latitude and longitude)
//      - As a User I can update contact
//      - As a User I can find a contact by name,middle name,surname
//      - As a User I can delete a contact
//      - As a User I can not enter wrong format data(can not enter character as
//          phone number)
//      - As a User I can I can search in contacts by some part of name(by writing
//          “jame” should be able to find “james”
//      - As a User I can search nearby contacts, by choosing distance and my current location
//      - As a User I can see My contacts history(when user change a contact old
//          information should save as history)

// Specs:
//      - Each Contact has Name, Middle name,Surname,Phone number,Note,Address,Location (latitude and longitude)
//      - Name ,Surname and phone number is mandatory ,rest of fields are optional
//      - API should use one cloud authentication method(we suggest firebase authentication or AWS(cognito)
//      - You are free to choose any database you want, with your explanation about your reasons
// - You should insert 100k contacts by generating some random name and number
//      - We will test API by maximum 5 RPS
//      - All fields should validate before inserting
// - For finding a contact API should response with all related result but sorted
// in best way, for example finding “james” in contacts should find james in
// “name”,”middle name” and “last name” field and also return not exact
// match results too
//      - You should Provide a api to give nearby a location result for example as
//          request we send latitude and longitude and distance , you should pass all
//          the contact around that location by that distance
//      - You should log all of the contact changes by time, means whenever a
//          contact changes you should keep the log, and in one api you should pass
//          the logs(pagination need)
