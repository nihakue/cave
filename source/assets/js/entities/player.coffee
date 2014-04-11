class Player
  constructor: (game) ->
    # super(game, 'serge')
    @game = game
    @sprite = null
    @cursors = null
    @speed = 300
    @jumpStrength = 700
    @hp = 1

  preload: ->
    @game.load.atlasJSONHash(
      'serge'
      "assets/atlas/serge.png"
      "assets/atlas/serge.json"
      )

  create: ->
    # super(32, @game.world.height - 150)
    @sprite = @game.add.sprite(32, game.world.height - 150, 'serge')
    @sprite.anchor =
        x: 0.5
        y: 0.5

    @initPhysics

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

    @cursors = @game.input.keyboard.createCursorKeys()
    @hurtKey = @game.input.keyboard.addKey(Phaser.Keyboard.SPACEBAR)
    @hurtKey.onDown.add(@hurt, this)
    @game.input.keyboard.addKeyCapture(Phaser.Keyboard.SPACEBAR)

  initPhysics: ->
    @game.physics.arcade.enable(@sprite)
    @sprite.body.bounce.y = 0.2
    @sprite.body.gravity.y = 1500
    @sprite.body.collideWorldBounds = true

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

  goLeft: ->
    @sprite.body.velocity.x = -@speed
    @sprite.scale.setTo(-1, 1)
    @sprite.animations.play('walk') if @sprite.body.touching.down

  goRight: ->
    @sprite.body.velocity.x = @speed
    @sprite.scale.setTo(1, 1)
    @sprite.animations.play('walk') if @sprite.body.touching.down

  idle: ->
    if @sprite.body.touching.down
      if @hp > .5
        @sprite.animations.play('idle')
      else 
        @sprite.animations.play('exhausted')

  jump: ->
    @sprite.body.velocity.y = -@jumpStrength
    @sprite.animations.play('jump')

  hurt: ->
    @hp -= .6