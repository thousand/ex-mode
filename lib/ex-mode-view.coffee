{$$$, EditorView, View} = require 'atom'

module.exports =
class ExModeView extends View
  @content: ->
    @div class: 'ex-mode tool-panel panel-bottom from-bottom', =>
      @subview 'command', new EditorView(mini: true, placeholderText: 'ex command...')

  initialize: (serializeState) ->
    atom.workspaceView.command "ex-mode:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "ExModeView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.prependToBottom(this)
