SFTPView = require './s-f-t-p-view'
{CompositeDisposable} = require 'atom'

module.exports = SFTP =
  sFTPView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sFTPView = new SFTPView(state.sFTPViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sFTPView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 's-f-t-p:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sFTPView.destroy()

  serialize: ->
    sFTPViewState: @sFTPView.serialize()

  toggle: ->
    console.log 'SFTP was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
