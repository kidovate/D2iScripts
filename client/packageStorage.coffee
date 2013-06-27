delConf = null
Template.packageStorage.events
  "click #openSetBtn": ->
    selSet = getSelectedSet()
    return if !selSet?
    selectedId = selSet._id
    selectNone()
    for script in selSet.scripts
      console.log "Selecting previously unselected script: "+script
      selectScript(script)
    $.pnotify
      title: "Set Loaded"
      text: "Selected "+selSet.scripts.length+" scripts."
      type: "success"
  "submit #createNewSetForm": ->
    if !Meteor.userId()?
      $.pnotify
        title: "Log In"
        type: "error"
        text: "You should log in before using this feature."
      return
    #get packages selected
    selectedArr = []
    $("#fcbklist li").each (index, el)->
      if $(this).attr('addedid')
        selectedArr.push $(this).attr("id")
    if selectedArr.length is 0
      $.pnotify
        title: "None Selected"
        type: "error"
        text: "You have no sets selected to add to a new set."
      return
    Sets.insert
      uid: Meteor.userId()
      name: $("#newSetNameField").val()
      scripts: selectedArr
      count: selectedArr.length
    $.pnotify
      title: "Set Created"
      type: "success"
      text: "We've stored your set for later use."
  "click #removeSetBtn": ->
      selSet = getSelectedSet()
      return if !selSet?
      selectedId = selSet._id
      if delConf is selectedId
        $.pnotify
          title: "Deleted"
          type: "success"
          text: "We've deleted the set '"+selSet.name+"'."
        Sets.remove({_id: selSet._id})
      else
        delConf = selectedId
        $.pnotify
          title: "Are You Sure"
          type: "info"
          text: "Click delete again to remove."
Template.packageStorage.sets = ->
  Sets.find()

getSelectedSet = ()->
  if !Meteor.userId()?
    $.pnotify
      title: "Log In"
      type: "error"
      text: "You should log in before using this feature."
    return
  selectedId = $("#listSets").val()
  if !selectedId?
    $.pnotify
      title: "None Selected"
      type: "error"
      text: "You need to select a set from the box before you can delete it."
  else
    selSet = Sets.findOne({_id: selectedId})
    if !selSet?
      $.pnotify
        title: "Not Found"
        type: "error"
        text: "We couldn't find that set for some reason..."
      return
    return selSet
selectNone = ()->
  $("#fcbklist li").each (index, el)->
    if $(this).attr('addedid')
      #$(this).removeAttr('addedid')
      $(this).find(".fcbkitem_text").click()
  #$(".liselected").each (index, el)->
  #$(this).removeClass "liselected"
selectScript = (id)->
  $("#fcbklist li").each (index, el)->
    #console.log $(this).attr('id')+" ?? "+id
    if $(this).attr('id') is id
      #console.log " --> yes"
      $(this).find(".fcbkitem_text").click()