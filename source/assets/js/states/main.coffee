class MainState extends Phaser.State
  constructor: -> super

  preload: ->
    @player = new Player(@game)
    @player.preload()

    @snell = new Snell(@game, @player)
    @snell.preload()

    @hud = new Hud(@game, @player)


  create: ->
    @game.physics.startSystem(Phaser.Physics.ARCADE)

    @snell.create()
    @player.create()
    @hud.create()

    if @game.scaleToFit
      @game.stage.scaleMode = Phaser.StageScaleMode.SHOW_ALL
      @game.stage.scale.setShowAll()
      @game.stage.scale.refresh()

  update: ->
    @game.physics.arcade.collide(@player.sprite, @snell.platforms);
    @game.physics.arcade.collide(@snell.sqot.sprite, @snell.platforms);
    @game.physics.arcade.overlap(
      @player.sprite,
      @snell.stars,
      @collectStar,
      null, this);

    @snell.update()
    @player.update()
    @hud.update()
    # @debugText.text = @player.body.deltaY()

  collectStar: (player, star) ->
    star.kill()
    @hud.score += 10;
    @hud.scoreText.text = 'Score: ' + @hud.score;
