{$$$, EditorView, View} = require 'atom'
actions = require './action-map'

module.exports =
class ExModeView extends View
  @content: ->
    @div class: 'ex-mode tool-panel panel-bottom from-bottom', =>
      @div class: 'block'
      @subview 'commandInput', new EditorView(mini: true, placeholderText: 'ex command...')

  initialize: (serializeState) ->

    atom.workspaceView.command "ex-mode:open", => @showInput()
    atom.workspaceView.command "ex-mode:close", => @hideInput()

    @commandInput.preempt 'keydown', (event) =>
      inputModel = @commandInput.getModel()
      if event.which == 13
        @process inputModel.getText()
        inputModel.setText('')

  # Returns an object that can be retrieved when package is activated
  serialize: ->


  process: (string) ->
    eventQueue = []
    for pattern, action of actions
      if (new RegExp pattern).test string
        verb = if pattern.last then 'push' else 'unshift'

        #TODO expand to handle lists of events and some cleverness on what those patterns look like
        eventQueue[verb](action.event)

    for event in eventQueue
      atom.workspaceView.trigger event

    @hideInput()

  destroy: ->
    @detach()

  hideInput: ->
    if @hasParent()
      @detach()
      @activatedFrom.activate()

  showInput: ->
    @activatedFrom = atom.workspace.getActivePane()
    if @hasParent()
      @commandInput.focus()
    else
      atom.workspaceView.prependToBottom(this)
      @commandInput.focus()
