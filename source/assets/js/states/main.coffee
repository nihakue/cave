class MainState extends Phaser.State
  constructor: -> super

  preload: ->
    @game.load.image('sky', 'assets/images/sky.png')
    @game.load.image('ground', 'assets/images/platform.png')
    @game.load.image('star', 'assets/images/star.png')
    @game.load.spritesheet('guy', 'assets/images/guy.png', 50, 60)

  create: ->
    @game.physics.startSystem(Phaser.Physics.ARCADE)
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

    @player = new PlayerSprite(@game, 32, (@game.world.height - 150), 'guy')
    @game.world.add(@player)
    @game.physics.arcade.enable(@player)
    @player.initPhysics()

    @stars = game.add.group()
    @stars.enableBody = true

    for i in [0..12]
      star = @stars.create(i * 70, 0, 'star')
      star.body.gravity.y = 6
      star.body.bounce.y = 0.7 + Math.random() * 0.2

    #Score
    @score = 0
    @scoreText = @game.add.text(
      16
      16
      'Score: 0'
      fontSize:
        '32px'
      fill:
        '#000'
    )

    #Controls
    @cursors = @game.input.keyboard.createCursorKeys();


    if @game.scaleToFit
      @game.stage.scaleMode = Phaser.StageScaleMode.SHOW_ALL
      @game.stage.scale.setShowAll()
      @game.stage.scale.refresh()

  update: ->
    @game.physics.arcade.collide(@player, @platforms);
    @game.physics.arcade.collide(@stars, @platforms);
    @game.physics.arcade.overlap(@player, @stars, @collectStar, null, this);

    @player.handleControl(@cursors)


  collectStar: (player, star) ->
    star.kill()
    @score += 10;
    @scoreText.text = 'Score: ' + @score;
