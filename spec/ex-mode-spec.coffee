{WorkspaceView} = require 'atom'
ExMode = require '../lib/ex-mode'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "ExMode", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('ex-mode')

  describe "when the ex-mode:open and ex-mode:close events are triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.ex-mode')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'ex-mode:open'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.ex-mode')).toExist()
        atom.workspaceView.trigger 'ex-mode:close'
        expect(atom.workspaceView.find('.ex-mode')).not.toExist()
