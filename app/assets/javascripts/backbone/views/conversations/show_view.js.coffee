AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.ShowView extends Backbone.View
  template: JST["backbone/templates/conversations/show"]

  initialize: () ->
    @model.attributes.messages.bind('reset', @addAll)

  addAll: () =>
    @model.attributes.messages.each(@addOne)

  addOne: (message) =>
    message = new AngelHack.Views.Messages.MessageView({model : message})
    @$(".messages ul").append(message.render().el)

  render: =>
    $(@el).html(@template(messages: @model.attributes.messages.toJSON() ))
    @addAll()
    return this