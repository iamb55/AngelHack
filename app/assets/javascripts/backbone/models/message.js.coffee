class AngelHack.Models.Message extends Backbone.Model
  paramRoot: 'messages'

  defaults:
    value: null 
    data_type: null

  toJSON: ->
    return @attributes

class AngelHack.Collections.MessagesCollection extends Backbone.Collection
  model: AngelHack.Models.Message
  url: '/messages'
