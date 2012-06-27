AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.IndexView extends Backbone.View
  template: JST["backbone/templates/conversations/index"]

  initialize: () ->
    @options.conversations.bind('reset', @addAll)

  addAll: () =>
    @options.conversations.each(@addOne)

  addOne: (conversation) =>
    conversation = new AngelHack.Views.Conversations.ConversationView({model : conversation})
    @$(".list").append(conversation.render().el)

  render: =>
    $(@el).html(@template(conversations: @options.conversations.toJSON() ))
    @addAll()

    return this
