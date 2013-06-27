###
  Model:
    Name: name of the package
    Description: description
    Author: author's name
    Filename: file name of the .lua script for packaging
    active: true/false, client receives only true
###
@Sets = new Meteor.Collection "sets"
@Packages = new Meteor.Collection "packages"
Meteor.startup ->
  if Meteor.is_client
    Meteor.subscribe "packages"
    Meteor.subscribe "sets"