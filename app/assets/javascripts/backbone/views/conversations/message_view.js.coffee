AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.MessageView extends Backbone.View
  template: JST["backbone/templates/conversations/message"]

  events:
    "click .destroy" : "destroy"

  tagName: "li"

  destroy: () ->
    @model.destroy()
    this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
