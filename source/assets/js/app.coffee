class @App
  constructor: ->
    @main = new Main()

  boot: ->
    @game = new Phaser.Game(800, 600, Phaser.AUTO, '', @main)
