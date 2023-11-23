# README

This README would normally document whatever steps are necessary to get the
application up and running.

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
    - Install Mysql and Redis

* GitHub repo - https://github.com/Hemalathavdh-DEV/SMS

* Deployment instructions
    1)   Install the Heroku CLI
        
        Push Your updated branch to heroku
            $ heroku login
            $ git push heroku master

        Do Migrations
            $ heroku run rake db:migrate

    2) Or Select Deployment method as Github
        Manual Deploy - Connect your repo, select the branch and click deploy.


* Heroku clone instructions
    1)  Install the Heroku CLI
    2)  If you haven't already, log in to your Heroku account and follow the prompts to create a new SSH public key.
            $ heroku login
  
    3)  Clone the repository

        Use Git to clone boiling-waters-33170's source code to your local machine.

        $ heroku git:clone -a boiling-waters-33170 
        $ cd boiling-waters-33170

    4)  Deploy your changes

    5)  Make some changes to the code you just cloned and deploy them to Heroku using Git.

        $ git add .
        $ git commit -am "make it better"
        $ git push heroku master

* Heroku Server Details
    - URL: https://boiling-waters-33170-b06f2682c931.herokuapp.com/
    - Branch Deployed: master
    - DB used in Heroku: JawsDB MySQL
    - Redis: RedisCloud

* Testing: Application and API details.
    1)  Built API endpoints:
        Inbound SMS: "/api/v1/sms/inbound"
        Outbound SMS: "/api/v1/sms/outbound"
    2)  DB records:
        Account: <username> <password>
        Phone numbers: <account username> <phone numbers>
        (Account username, password, account's phone Number details shared in email.)

    Note: you can use the above db record values to test the api endpoints.

* Testing: Postman collection
    1)  The postman collection consisting of the api endpoints will shared in email.
        - Import the collection to postman.
        - Set the authorization  from the db record values mentioned above
        - Construct the body params, if required use the db record values mentioned above to test.
  


