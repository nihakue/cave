class MainState extends App.State
  constructor: -> super

  preload: ->
    @game.load.image('logo', 'assets/images/logo.png')

  create: ->
    @logo = new LogoSprite(@game, @game.world.centerX, @game.world.centerY, 'logo')
