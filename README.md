# Introduction

Welcome to the HouseCare Programming Test!

This website is a simple website to rank girls from the hit anime 'Love Live! School Idol Project.' People can create an account, login and change the ranks of the girls according to whom they like the most.

# Getting Started

There are two ways to run this app:
- Docker
  
  Run these command
  ```
  docker build -t housecare:test .
  docker run -dp 3000:3000 housecare:test
   ``` 
  If one uses docker toolbox, make sure the port 3000 is forwarded from the guest to host correctly. 

- Build from Source
  
  Use Ruby 2.2 (we recommend using RVM to install 2.2 for development)

  Use Postgres (if you are on a Mac, just use Postgres.app and you should be set)

  Fork this repository

  Run the following commands to set up

  ```
  git clone git@github.com:[your_username]/railstest
  cd railstest
  bundle install
  rake db:create
  rake db:migrate
  rake db:seed # this will seed the base with random best girl values
  ```

  Run the following command to start the server

  ```
  bundle exec rails s
  ```

Either way. You should see the website on http://localhost:3000.

# The Problem

When you see the front page, you will see a `##Display best girl ranking here:##`. Please implement this view.

This view needs to display the overall (global) ranking for all the girls according to the rankings set by every user, so you will need to implement the calculation and display the result on the front page. (Make sure to write tests too!)

Make a pull request with your modifications.

# Job Application

As part of your job application please provide a resume (preferably text or a URL to your resume) with your contact details (i.e. phone number and e-mail address) and use `encrypt.sh` to encrypt it before checking it in. This program will encrypt a file and add a `.enc` extension to the end of it to indicate that it is encrypted. Please also check in the corresponding file with the `.enc.pub` extension.

Example: 

```
sh encrypt.sh message
git add message.enc
git add message.enc.pub
git commit -m "Message for job application"
```

** PLEASE DON'T CHECK IN YOUR PERSONAL INFO UNENCRYPTED **

If you are uncomfortable with this then please e-mail your job application to david アット airtidy.com and let us know your github username.

# Extra Credit

There are issues with the code that allows people to set their best girl. Find out what they are and fix them.

There are many other problems with the site, you do not need to fix them but spotting them would be really nice.

# TL;DR

Ruby is best girl anyway.
