class @Logo extends App.Sprite
  constructor: ->
    super
    @anchor =
      x: 0.5
      y: 0.5

  update: ->
    @angle++
