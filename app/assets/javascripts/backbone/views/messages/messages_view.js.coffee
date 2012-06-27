AngelHack.Views.Messages ||= {}

class AngelHack.Views.Messages.MessageView extends Backbone.View
  template: JST["backbone/templates/messages/message"]

  tagName: "li"

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this