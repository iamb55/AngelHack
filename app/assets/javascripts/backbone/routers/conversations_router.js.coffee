class AngelHack.Routers.ConversationsRouter extends Backbone.Router
  initialize: (options) ->
    @conversations = new AngelHack.Collections.ConversationsCollection()
    @conversations.reset options.conversations, { parse: true } 

  routes:
    "new"      : "newConversation"
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  newConversation: ->
    @view = new AngelHack.Views.Conversations.NewView(collection: @conversations)
    $("#main").html(@view.render().el)

  index: ->
    @sidebar = new AngelHack.Views.Conversations.IndexView(conversations: @conversations)
    @messages = new AngelHack.Views.Conversations.ShowView(model: @conversations.get(1))
    $(".leftbar").html(@sidebar.render().el)
    $(".rightbar").html(@messages.render().el)

  show: (id) ->
    conversation = @conversations.get(id)
    @sidebar = new AngelHack.Views.Conversations.IndexView(conversations: @conversations)
    @messages = new AngelHack.Views.Conversations.ShowView(model: conversation)
    $(".leftbar").html(@sidebar.render().el)
    $(".rightbar").html(@messages.render().el)

  edit: (id) ->
    conversation = @conversations.get(id)

    @view = new AngelHack.Views.Conversations.EditView(model: conversation)
    $("#main").html(@view.render().el)
