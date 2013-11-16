class App
  constructor: (attributes) ->
    for key, value of attributes
      @[key] = value

    @scaleToFit ?= !!@width && !!@height
    @width ?= window.innerWidth
    @height ?= window.innerHeight

  boot: ->
    @game = new Phaser.Game(@width, @height, Phaser.AUTO)
    @game.state.add 'loading', new App.State.Loading, true
