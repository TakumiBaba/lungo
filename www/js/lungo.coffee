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
    page = generatePage key, value
    $("##{key}").remove()
    $("body").prepend page
  ul.listview("refresh")

generateLi = (key, value)->
  name = ""
  if value.name is ""
    name = key
  else
    name = value.name
  li = $("<li></li>").attr("data-theme", "c")
  a  = $("<a>").attr("href", "##{key}").attr("data-transition", 'slide').html(name)
  li.append a
  return li

generatePage = (key, value)->
  page = $("<div>").attr("id", key).attr("data-role", "page")
  header = $("<div>").attr("data-role", "header").attr("data-theme", "a")
  backButton = $("<a>").attr("data-icon", "delete").attr("data-rel", "back").attr("data-direction", "reverse").html("戻る")
  h3 = $("<h3>").html("ざいこ")
  content = generateContent key, value
  header.append backButton
  header.append h3
  page.append header
  page.append content
  
  return page

generateContent = (key, value)->
  content = $("<div>").attr("data-role", "content")
  form = $("<form>")
  nameInput = $("<input>").attr("type", "text").val(value.name)
  form.append nameInput
  name = value.name
  button = $("<a>").attr("data-role", "button").html("買った！").attr("data-rel", "back").attr("data-direction", "reverse")
  content.append form
  content.append button
  button.bind "click", ()->
    ts.take [], (tuple)->
      console.log tuple[0]
      v = tuple[0]
      v[key].stock = 10
      v[key].name = name
      ts.write [v]
  nameInput.bind "blur", (e)->
    console.log e
    ts.take [], (tuple)->
      v = tuple[0]
      v[key].name = nameInput.val()
      ts.write [v]
      location.href = "./index.html"
  # form.bind "submit", (event)=>
  #   console.log nameInput.val()
  #   name = nameInput.val()
  #   ts.take [], (tuple)->
  #     v = tuple[0]
  #     v[key].name = name
  #     ts.write [v]
  #     return true
  return content

  # 買うべきものが入ってるtupleを書き込むようにすればよい？re
  # hash-tuple

  # tuple is {id: {name: "hoge", stock: 0}}
  # id = page ごと、生成するのが良さそう？