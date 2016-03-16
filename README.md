
//Technology: NodeJS, AngularJS, MySql

//Required app installed: NodeJS, MySql

Flows belows steps to Deploy app to your machine

1. Extract zip file to folder
2. Open terminal
3. Change current working directory to test application directory you extract at step 1
4. Install modules required for application by this command:
> npm install
5. import database for application:
Run file script : [Application Folder]\Demo_DB.sql to create DB MySql

6. Config your database, host server on file [Application Folder]\api\config.js to your own  machine

7. Start API Server:
>node app.js
Check terminal to view output
8. Browser application from web browser
Enter address: [your host server]:[your port]/

If result shown, Application working./

