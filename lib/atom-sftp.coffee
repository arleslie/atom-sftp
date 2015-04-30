AtomSftpView = require './atom-sftp-view'
{CompositeDisposable} = require 'atom'

module.exports = AtomSftp =
  atomSftpView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @atomSftpView = new AtomSftpView(state.atomSftpViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @atomSftpView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'atom-sftp:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @atomSftpView.destroy()

  serialize: ->
    atomSftpViewState: @atomSftpView.serialize()

  toggle: ->
    console.log 'AtomSftp was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
