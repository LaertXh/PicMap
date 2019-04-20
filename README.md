# PicMap
## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
1. [Schema](#Schema)

## Overview
### Description
Find out where is the user, link their real loctions to an post database.Could be use to share cool things to people around or just record today's feeling and review in the future

### App Evaluation
- **Category:** Social Networking / Personal Collection
- **Mobile:** Since the main idea of this app is linkinf real location with online data,This app would be primarily developed for mobile which is easy connect with location information.
- **Story:** Connect users' real location with a online database. User can write down his stories or thoughts they have in each place. Then user can decide make the post private or public. If user make it public, they will be connect with nearby people. Otherwise the post will only be check by themslves.
- **Market:** Any individual could choose to use this app, people can decide share to other people or not. It can be either a Social Networking app or a personal collection app.
- **Habit:** This app could be used as often or unoften as the user wanted depending on how deep their social life is, and what exactly they're looking for.
- **Scope:** First the app will only like a photo album or a diary but with the increase of pubilc sharing it will become a social networking where people can have fun and make friends.
## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in and logs out their personal account
* User can make a post base on their location
* User can view the post around their location
* User can like or dislike a post
* User can give comments to a post

**Optional Nice-to-have Stories**

* Labels for each post which will be used for classify the posts 
* Page of most liked posts
* Help people design a travel
* Chat for people to communicate

### 2. Screen Archetypes

* Login 
* Register - User signs up or logs into their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information to be properly matched with another person. 
   * ...
* Map Screen
   * Allows user to find out where are they and view the post around
* Post Screen
   * Allows user to make a post
* Settings Screen
   * Lets people change language, and app notification settings.

### 3. Navigation

## Wireframes
<img src="https://i.imgur.com/JeCu8rb.jpg">

## Schema 
### Models
#### Post

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
   | author        | Pointer to User| image author |
   | image/video   | File     | image/video that user posts |
   | caption       | String   | image caption by author |
   | createdAt     | DateTime | date when post is created (default field) |
   | location      | Pointer to map     | thename of the location with aproximate location on the map |
   
   
### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all posts based on the location of the user 
   - Create Post Screen
      - (Create/POST) Create a new post object
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image
      - (Delete) Delte specific post 


