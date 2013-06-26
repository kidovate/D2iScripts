Template.choosePackages.rendered = ->
  $("#filters").remove()
  $.fcbkListSelection("#fcbklist")
Template.choosePackages.packages = ->
  Packages.find()