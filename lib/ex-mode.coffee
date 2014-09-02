ExModeView = require './ex-mode-view'

module.exports =
  exModeView: null

  activate: (state) ->
    @exModeView = new ExModeView(state.exModeViewState)

  deactivate: ->
    @exModeView.destroy()

  serialize: ->
    exModeViewState: @exModeView.serialize()
