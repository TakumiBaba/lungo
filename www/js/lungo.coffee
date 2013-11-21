linda = new Linda()
ts = new linda.TupleSpace "stock"
linda.io.on "connect", =>
  ts.list [], (tuples)=>
    reloadList tuples
  ts.watch [], (tuple)->
    ts.list [], reloadList

reloadList = (tuples)->
  console.log tuples
  ul = $("#list")
  ul.empty()
  for tuple in tuples
    console.log tuple
    li = generateLi tuple[0]
    ul.append li
  ul.listView("refresh")
  # ul.children().each
  # for key, value of tuples[0]
  #   console.log key, value.stock
  #   if value.stock > 0
  #     continue
  #   li = generateLi key, value
  #   ul.append li
  # ul.listview("refresh")
  # ul.children().each ()->
  #   $(@).find("a")

generateLi = (n)->
  li = $("<li>")
  a = $("<a>")
  name = $("<span>").html("#{n}　がない！")
  li.append $("<a>").append(name)
  li.bind "click", ()->
    ts.take [n], (t)=>
      $("#list").empty(i)
      ts.list [], reloadList
  return li

# generateLi = (key, value)->
#   name = ""
#   if value.name is ""
#     name = key
#   else
#     name = value.name
#   li = $("<li>")
#   a = $("<a>")
#   name = $("<span>").html("#{name}　がない！")
#   li.append $("<a>").append(name)
#   li.bind "click", ()=>
#     ts.take [], (tuple)=>
#       console.log tuple
#       v = tuple[0]
#       v[key].stock = 10
#       ts.write [v]
#   return li

  # 買うべきものが入ってるtupleを書き込むようにすればよい？re
  # hash-tuple

  # tuple is {id: {name: "hoge", stock: 0}}
  # id = page ごと、生成するのが良さそう？