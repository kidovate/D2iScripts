Template.choosePackages.rendered = ->
  $("#filters").remove()
  $("#fcbklist").unbind('click').find("*").unbind("click")
  $.fcbkListSelection("#fcbklist")
Template.choosePackages.packages = ->
  Packages.find()