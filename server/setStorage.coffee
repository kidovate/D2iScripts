Meteor.startup ->
  Sets.allow
    insert: (userId, doc)->
      return doc.name? or userId? or doc.scripts? or doc.uid?
    remove: (userId, doc)->
      return userId? and userId is doc.uid
  Sets.before "insert", (userId, doc)->
    newDoc = {
      uid: userId
      name: doc.name
      scripts: doc.scripts
      count: doc.scripts.length
    }
    Sets.remove({name: doc.name, uid: userId})
    for k in doc
      delete doc.k
    for k in newDoc
      doc[k]=newDoc[k]