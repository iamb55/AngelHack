AngelHack.Views.Conversations ||= {}

class AngelHack.Views.Conversations.EditView extends Backbone.View
  template : JST["backbone/templates/conversations/edit"]

  events :
    "submit #edit-conversation" : "update"

  update : (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.save(null,
      success : (conversation) =>
        @model = conversation
        window.location.hash = "/#{@model.id}"
    )

  render : ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
