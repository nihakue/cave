class Snell
  constructor: (@game) ->
    @platforms = null
    @stars = null

  preload: ->
    @game.load.image('sky', 'assets/images/sky.png')
    @game.load.image('ground', 'assets/images/platform.png')
    @game.load.image('star', 'assets/images/star.png')

  create: ->
    @game.add.sprite(0, 0, 'sky')

    @platforms = @game.add.group()
    @platforms.enableBody = true

    ground = @platforms.create(0, @game.world.height - 64, 'ground')
    ground.scale.setTo(2, 2)
    ground.body.immovable = true

    ledge = @platforms.create(400, 400, 'ground')
    ledge.body.immovable = true

    ledge = @platforms.create(-150, 250, 'ground')
    ledge.body.immovable = true

    @stars = game.add.group()
    @stars.enableBody = true

    for i in [0..12]
      star = @stars.create(i * 70, 0, 'star')
      star.body.gravity.y = 6
      star.body.bounce.y = 0.7 + Math.random() * 0.2

  update: ->
    @game.physics.arcade.collide(@stars, @platforms);