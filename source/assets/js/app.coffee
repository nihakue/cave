class @App
  constructor: ->
    @main = new Main()

  boot: ->
    @game = new Phaser.Game(480, 1136, Phaser.AUTO, '', @main)
