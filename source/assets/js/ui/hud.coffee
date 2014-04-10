class Hud
  constructor: (@game, @player) ->
    @score = 0
    @scoreText = null

  create: ->
    scoreStyle =
      font: "12px Arial"
      fill: "#000"

    @scoreText = @game.add.text(
      16, 16, 'Score: 0'
      scoreStyle)

  update: ->
    @scoreText.text = "lc: #{@player.loopcount} HP: #{@player.hp}\nScore:  #{@score}";