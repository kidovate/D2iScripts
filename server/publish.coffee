Meteor.startup ->
  Meteor.publish "packages", ->
    Packages.find active:true
  Meteor.publish "sets", ->
    Sets.find (uid: this.userId)