class Mob
  constructor: (@game, @name) ->
    @sprite = null

  preload: ->
    @game.load.atlasJSONHash(
      @name
      "assets/atlas/#{@name}.png"
      "assets/atlas/#{@name}.json"
      )

  create: (x, y)->
    @sprite = @game.add.sprite(x, y, @name)

    @sprite.anchor =
        x: 0.5
        y: 0.5

    @initPhysics()

  initPhysics: ->
    @game.physics.arcade.enable(@sprite)
    @sprite.body.bounce.y = 0.2
    @sprite.body.gravity.y = 1500
    @sprite.body.collideWorldBounds = true