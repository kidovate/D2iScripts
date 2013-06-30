StatusNot = null

downloadPackages = (minify)->

  selectedArr = []
  $("#fcbklist li").each (index, el)->
    if $(this).attr('addedid')
      selectedArr.push $(this).attr("id")
  #Meteor.call "downloadPackages",
  console.log "Selected packages: "+selectedArr
  if selectedArr.length is 0
    $.pnotify
      title: "No Packages"
      type: "error"
      text: "Downloading would be pointless as you've selected 0 packages."
  else
    StatusNot = $.pnotify
      title: "Packing Files"
      text: "Your order of "+selectedArr.length+" package"+(if selectedArr.length > 1 then  "s" else "")+" is processing..."
      type: "info"
      closer: false
      nonblock: true
      hide: false
    $(".downloadButton").fadeOut 'fast', ->
      Session.set "downloading", true
      StatusNot.pnotify_remove() if StatusNot.pnotify_remove
      Meteor.call "startDownload", selectedArr, minify, (error, result) ->
        if error?
          $.pnotify
            title: "Error Downloading"
            type: "error"
            text: error
        else if result?
          $.pnotify
            title: "Download Started"
            type: "success"
            text: "Your download has begun."
          window.open result
        $(".downloadingView").fadeOut ()->
          Session.set "downloading", false

Template.downloadPackages.preserve [".row-fluid"]
Template.downloadPackages.downloading = ->
  Session.get "downloading"
Template.downloadingView.rendered = ->
  $(".downloadingView").hide().fadeIn('fast')
Template.downloadPackages.events
  "click #downloadMinified": ->
    downloadPackages true
  "click #downloadSource": ->
    downloadPackages false
Meteor.startup ->
  Session.set "downloading", false