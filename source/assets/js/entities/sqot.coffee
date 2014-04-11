class Sqot extends Mob
  constructor: (game, @player) ->
    super(game, 'sqot')
    @speed = 100

  create: ->
    super(@game.world.randomX, game.world.randomY)

    @initAnimations()

  initAnimations: ->
    @sprite.animations.add('walk',
    Phaser.Animation.generateFrameNames('walk', 0, 3, '', 2),
    5, true)

  update: ->
    @sprite.body.velocity.x = 0

    if @player.sprite.x > @sprite.x
      @goRight()
    else
      @goLeft()