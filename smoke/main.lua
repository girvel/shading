love.graphics.setDefaultFilter("nearest", "nearest")

local shader_source = love.filesystem.read("shader.glsl")
local smoke_shader = love.graphics.newShader(shader_source)

local canvases = {
  next = love.graphics.newCanvas(love.graphics.getDimensions()),
  current = love.graphics.newCanvas(love.graphics.getDimensions()),
}

love.graphics.setCanvas(canvases.current)
-- love.graphics.circle("fill", 100, 400, 50)
love.graphics.draw(
  love.graphics.newImage("decorations.png"),
  0, 0,
  0,
  4
)
love.graphics.setCanvas()

function love.draw()
  -- shaders step --
  if love.keyboard.isDown("a") then
    love.graphics.setCanvas(canvases.next)
    love.graphics.setShader(smoke_shader)
    love.graphics.draw(canvases.current)
    love.graphics.setCanvas()
    love.graphics.setShader()
    canvases.current, canvases.next = canvases.next, canvases.current
  end

  -- actually display --
  love.graphics.draw(canvases.current)
end
