class Player extends Mob
  constructor: (game) ->
    super(game, 'serge')
    @cursors = null
    @speed = 300
    @jumpStrength = 700
    @hp = 1

  create: ->
    super(32, @game.world.height - 150)

    @initAnimations()

    @cursors = @game.input.keyboard.createCursorKeys()
    @hurtKey = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)
    @hurtKey.onDown.add(@hurt, this)
    @game.input.keyboard.addKeyCapture(Phaser.Keyboard.SPACEBAR)

  initAnimations: ->
    # Load all animations
    @sprite.animations.add('jump',
      Phaser.Animation.generateFrameNames('jump', 0, 7, '', 2)
      5, false)

    @sprite.animations.add('idle',
      Phaser.Animation.generateFrameNames('puffed', 0, 8, '', 2),
      5, true)

    @sprite.animations.add('walk',
      Phaser.Animation.generateFrameNames('run', 0, 12, '', 2),
      15, true)

    @sprite.animations.add('into_exhausted',
      Phaser.Animation.generateFrameNames('into_exhausted', 0, 3, '', 2),
      5, false)

    @sprite.animations.add('exhausted',
    Phaser.Animation.generateFrameNames('exhausted', 0, 7, '', 2),
    5, true)

  update: ->
    @handleControl()

  handleControl: ->
    @sprite.body.velocity.x = 0

    if @cursors.left.isDown
      @goLeft()
    else if @cursors.right.isDown
      @goRight()
    else
      @idle()

    @jump() if @cursors.up.isDown and @sprite.body.touching.down

  idle: ->
    if @hp > .5
        @sprite.animations.play('idle')
      else 
        @sprite.animations.play('exhausted')

  hurt: ->
    @hp -= .6