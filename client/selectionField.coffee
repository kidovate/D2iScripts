Template.choosePackages.rendered = ->
  $("#filters").remove()
  $("#fcbklist").unbind('click').find("*").unbind("click")
  selectNone()
  $.fcbkListSelection("#fcbklist")
Template.choosePackages.packages = ->
  Packages.find()