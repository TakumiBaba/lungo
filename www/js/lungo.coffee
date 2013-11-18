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
    $(@).find("a").removeClass("ui-icon-carat-r")

generateLi = (key, value)->
  name = ""
  if value.name is ""
    name = key
  else
    name = value.name
  li = $("<li>").attr("data-theme", "c")
  a = $("<a>")
  name = $("<span>").addClass("ui-btn-text").html("#{name}　がない！")
  li.append $("<a>").append(name)
  li.bind "click", ()=>
    ts.take [], (tuple)=>
      console.log tuple
      v = tuple[0]
      v[key].stock = 10
      ts.write [v]
  return li

  # 買うべきものが入ってるtupleを書き込むようにすればよい？re
  # hash-tuple

  # tuple is {id: {name: "hoge", stock: 0}}
  # id = page ごと、生成するのが良さそう？