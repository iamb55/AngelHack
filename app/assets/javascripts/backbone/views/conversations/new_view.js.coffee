AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.NewView extends Backbone.View
  template: JST["backbone/templates/conversations/new"]

  events:
    "submit #new-conversation": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (conversation) =>
        @model = conversation
        window.location.hash = "/#{@model.id}"

      error: (conversation, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
