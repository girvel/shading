love.graphics.setDefaultFilter("nearest", "nearest")

local load_shader = function(path)
  local source = love.filesystem.read(path)
  return love.graphics.newShader(source)
end

local smoke_shader = load_shader("shader.glsl")
local palette_shader = load_shader("palette.glsl")

do
  local palette = {{0, 0, 0, 0}}
  local palette_image_data = love.image.newImageData("palette.png")
  local w, h = palette_image_data:getDimensions()
  for x = 0, w - 1 do
    for y = 0, h - 1 do
      local r, g, b, a = palette_image_data:getPixel(x, y)
      if a > 0 then
        table.insert(palette, {r, g, b, a})
      end
    end
  end
  palette_shader:send("palette", unpack(palette))
end

local raw_color_canvases = {
  next = love.graphics.newCanvas(love.graphics.getDimensions()),
  current = love.graphics.newCanvas(love.graphics.getDimensions()),
}

love.graphics.setCanvas(raw_color_canvases.current)
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
    love.graphics.setCanvas(raw_color_canvases.next)
    love.graphics.setShader(smoke_shader)
    love.graphics.draw(raw_color_canvases.current)
    raw_color_canvases.current, raw_color_canvases.next = raw_color_canvases.next, raw_color_canvases.current
  end

  -- actually display --
  love.graphics.setCanvas()
  love.graphics.setShader(palette_shader)
  love.graphics.draw(raw_color_canvases.current)
end
