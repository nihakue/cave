class PlayerSprite extends Phaser.Sprite
  constructor: ->
    super

    @anchor =
      x: 0.5
      y: 0.5

    @speed = 150
    @jumpStrength = 500

    @animations.add('jump',
      Phaser.Animation.generateFrameNames('jump', 0, 7, '', 2)
      5, false)

    @animations.add('idle',
      Phaser.Animation.generateFrameNames('puffed', 0, 8, '', 2),
      5, true)

    @animations.add('walk',
      Phaser.Animation.generateFrameNames('run', 0, 5, '', 2),
      10, true)

  initPhysics: ->
    @body.bounce.y = 0.2
    @body.gravity.y = 700
    @body.collideWorldBounds = true

  handleControl: (cursors) ->
    @body.velocity.x = 0

    if cursors.left.isDown
      @goLeft()
    else if cursors.right.isDown
      @goRight()
    else
      @idle()

    @jump() if cursors.up.isDown and @body.touching.down

  goLeft: ->
    @body.velocity.x = -@speed
    @scale.setTo(-1, 1)
    @animations.play('walk') if @body.touching.down

  goRight: ->
    @body.velocity.x = @speed
    @scale.setTo(1, 1)
    @animations.play('walk') if @body.touching.down

  idle: ->
    @animations.play('idle') if @body.touching.down

  jump: ->
    @body.velocity.y = -@jumpStrength
    @animations.play('jump')