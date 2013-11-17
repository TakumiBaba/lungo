linda = new Linda()
ts = new linda.TupleSpace "stock"
linda.io.on "connect", =>
  ts.read [], (tuple)=>
    reloadList tuple
    ts.watch [], reloadList

reloadList = (tuple)->
  ul = $("#list")
  ul.empty()
  for key, value of tuple[0]
    console.log key, value.stock
    if value.stock > 0
      continue
    li = generateLi key, value
    ul.append li
  ul.listview("refresh")
  ul.children().each ()->
    $(@).find("a").removeClass("ui-icon-carat-r")#.addClass("ui-icon-check ui-btn-icon-left")

generateLi = (key, value)->
  name = ""
  if value.name is ""
    name = key
  else
    name = value.name
  li = $("<li>").attr("data-theme", "c")
  # a  = $("<a>").attr("href", "").attr("data-transition", 'slide').html(name)
  a = $("<a>").attr(
    "href": ""
  )
  # ).html(name)
  # button = $("<a>").attr("data-icon", "check").attr("data-role", "button").html("hoge")
  # button = $("<a>").attr(
  #   "data-role": "button"
  #   "data-icon": "check"
  #   "data-iconpos": "left"
  #   "href"     : ""
  # ).html("")
  # span = $("<span>").addClass("ui-icon-check ui-btn-icon-left")#.html("買う")
  name = $("<span>").addClass("ui-btn-text").html(name)
  # a.append span
  a.append name
  li.append a
  # li.append button
  return li

# generatePage = (key, value)->
#   page = $("<div>").attr("id", key).attr("data-role", "page")
#   header = $("<div>").attr("data-role", "header").attr("data-theme", "a")
#   backButton = $("<a>").attr("data-icon", "delete").attr("data-rel", "back").attr("data-direction", "reverse").html("戻る")
#   h3 = $("<h3>").html("ざいこ")
#   content = generateContent key, value
#   header.append backButton
#   header.append h3
#   page.append header
#   page.append content
  
#   return page

# generateContent = (key, value)->
#   content = $("<div>").attr("data-role", "content")
#   form = $("<form>")
#   nameInput = $("<input>").attr("type", "text").val(value.name)
#   form.append nameInput
#   name = value.name
#   button = $("<a>").attr("data-role", "button").html("買った！").attr("data-rel", "back").attr("data-direction", "reverse")
#   content.append form
#   content.append button
#   button.bind "click", ()->
#     ts.take [], (tuple)->
#       console.log tuple[0]
#       v = tuple[0]
#       v[key].stock = 10
#       v[key].name = name
#       ts.write [v]
#   nameInput.bind "blur", (e)->
#     console.log e
#     ts.take [], (tuple)->
#       v = tuple[0]
#       v[key].name = nameInput.val()
#       ts.write [v]
#       location.href = "./index.html"
#   return content

  # 買うべきものが入ってるtupleを書き込むようにすればよい？re
  # hash-tuple

  # tuple is {id: {name: "hoge", stock: 0}}
  # id = page ごと、生成するのが良さそう？