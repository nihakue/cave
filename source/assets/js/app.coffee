class App
  constructor: ->
    @states = {}

  boot: ->
    @game = new Phaser.Game(480, 1136, Phaser.AUTO, '', new MainState())
