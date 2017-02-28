# Introduction

Welcome to the HouseCare Programming Test!

This website is a simple website to rank girls. People can create an account, login and change the ranks of the girls according to whom they like the most.

# Getting Started

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

You should see the website on http://localhost:3000.

# The Problem

When you see the front page, you will see a `##Display best girl ranking here:##`. Please implement this view.

This view needs to display the overall (global) ranking for all the girls according to the rankings set by every user, so you will need to implement the calculation and display the result on the front page.

Make a pull request with your modifications.

# Extra Credit

There are issues with the code that allows people to set their best girl. Find out what they are and fix them.

There are many other problems with the site.

# TL;DR

Ruby is best girl anyway.