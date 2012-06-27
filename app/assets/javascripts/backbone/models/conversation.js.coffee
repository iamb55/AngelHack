class AngelHack.Models.Conversation extends Backbone.Model
  paramRoot: 'conversation'

  defaults:
    messages: null
    mentor: null
    mentee: null
      
  parse: (resp) ->
      if @attributes?.messages?
        @attributes.messages.reset(resp.messages)
      else
        resp.messages = new AngelHack.Collections.MessagesCollection(resp.messages)
      resp

  # Recollects Conversation.messages
  toJSON: ->
    attributes = _.clone(@attributes)
    attributes.messages = attributes.messages.toJSON()
    attributes
    
class AngelHack.Collections.ConversationsCollection extends Backbone.Collection
  model: AngelHack.Models.Conversation
  url: '/conversations'

  init: ->
    console.log conversations
