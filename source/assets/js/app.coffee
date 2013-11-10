class App
  constructor: ->
    @states = {}

  boot: ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', new MainState())
