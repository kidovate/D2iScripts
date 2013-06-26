Meteor.startup ->
  Meteor.publish "packages", ->
    Packages.find active:true