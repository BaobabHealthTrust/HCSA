HCSA
====

Hospital Client Satisfaction Application(HCSA) is a Ruby on Rails application developed by Baobab Health Trust. Its is used to bridge the gap that exist between patients and hospital management by allowing patient to give feedback on the service provision received in a particular hospital and the data is statistically analysed and generated for the use of the management.



== Getting Started

To use the HCSA application, you first need to download the application from the github repository to your computer.
This can be achieved by running the following command in linux:

    git clone  https://github.com/BaobabHealthTrust/HCSA.git

Now that you have the application on you computer, the following steps will help you get the application running

1. Set up the gems utilised by the HCSA application. These  can be installed
   by running the following command: bundle install


2. set up database details in config/database.yml. You will require two databases. A custom HCSA database whose details
 you can type under Development or Production environment database settings

3. Create the HCSA database. This is done by running rake db:create db:migrate

4. Load initial data for items into the database by running rake db:seed

5. To use administration functionality,click the button on above-Right side on the homescreen, the username is: admin password is :test.

After carrying out these steps, your application is now ready to be used.
