# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

*Application setup:

	Technology stack
		Ruby 3.2.2
		Rails 7.0.5

	Bundle installation
		bundle install

	Database configuration

		To create database run rake db:create
		To run database migrations run rake db:migrate

	Things you want to cover:
		Redis server


* System dependencies
    Install Mysql and Redis


* Deployment instructions
1)   Install the Heroku CLI
        $ heroku login

    Push Your updated branch to heroku
        $ git push heroku master

    Do Migrations
        $ heroku run rake db:migrate

2) Or Select Deployment method as Github
    Manual Deploy - Connect your repo, select the branch and click deploy.


* Heroku clone instructions
  Install the Heroku CLI
  If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.
   $ heroku login
  
  Clone the repository

  Use Git to clone boiling-waters-33170's source code to your local machine.

  $ heroku git:clone -a boiling-waters-33170 
  $ cd boiling-waters-33170

 Deploy your changes

 Make some changes to the code you just cloned and deploy them to Heroku using Git.

 $ git add .
 $ git commit -am "make it better"
 $ git push heroku master

* Heroku Server Details
  URL: https://boiling-waters-33170-b06f2682c931.herokuapp.com/
  Branch Deployed: master
  DB used in Heroku: JawsDB MySQL
  Redis: RedisCloud

* Testing - Application and API details.
  Built API endpoints:
    1) Inbound SMS: https://boiling-waters-33170-b06f2682c931.herokuapp.com/api/v1/sms/inbound
    2) Outbound SMS: https://boiling-waters-33170-b06f2682c931.herokuapp.com/api/v1/sms/outbound
  DB records:
    Account: <username> <password>
         - hemalatha <password>
         - hema <password>
       Password shared in email.
   Phone numbers: <account username> <phone numbers.
          - ["hemalatha", ["919823243432", "919343542749", "919343542750"]
          - ["hema", ["919443620793", "917871632031"]]

 Note: you can use the above db record values to test the api endpoints.

* Testing - Postman collection
  The postman collection consisting of the api endpoints will shared in email.
   - Import the collection to postman.
   - Set the authorization  from the db record values mentioned above
   - Construct the body params, if required use the db record values mentioned above to test.
  


