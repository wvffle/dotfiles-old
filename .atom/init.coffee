# Your init script
#
# Atom will evaluate this file each time a new window is opened. It is run
# after packages are loaded/activated and after the previous editor state
# has been restored.
#
# An example hack to log to the console when each text editor is saved.
#
# atom.workspace.observeTextEditors (editor) ->
#   editor.onDidSave ->
#     console.log "Saved! #{editor.getPath()}"


# exit to normal mode and save
atom.commands.add 'atom-text-editor.vim-mode-plus', 'custom:reset-normal-mode-save', ->
  editor = atom.workspace.getActiveTextEditor()
  atom.commands.dispatch(editor.editorElement, 'vim-mode-plus:reset-normal-mode')
  editor.save()
