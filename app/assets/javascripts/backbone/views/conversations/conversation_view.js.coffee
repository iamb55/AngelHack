AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.ConversationView extends Backbone.View
  template: JST["backbone/templates/conversations/conversation"]

  events:
    "click .user" : "show"

  tagName: "li"

  show: () ->
    window.router.show(@model.attributes.id)

  render: ->
    $(@el).html( @template( @model.toJSON() ) )
    return this
