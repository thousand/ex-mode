{$$$, EditorView, View} = require 'atom'

module.exports =
class ExModeView extends View
  @content: ->
    @div class: 'ex-mode tool-panel panel-bottom from-bottom', =>
      @subview 'commandInput', new EditorView(mini: true, placeholderText: 'ex command...')

  initialize: (serializeState) ->
    atom.workspaceView.command "ex-mode:open", => @showInput()
    atom.workspaceView.command "ex-mode:close", => @hideInput()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  hideInput: ->
    if @hasParent()
      @detach()

  showInput: ->
    if @hasParent()
      @commandInput.focus()
    else
      atom.workspaceView.prependToBottom(this)
      @commandInput.focus()
