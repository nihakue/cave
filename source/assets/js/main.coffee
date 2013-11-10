class @Main extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.image('logo', 'assets/images/logo.png')

  create: ->
    @logo = new Logo(@game, @game.world.centerX, @game.world.centerY, 'logo')
