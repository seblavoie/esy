class EsyProject

# ----------------------------------------
# hasItems
# ----------------------------------------
  hasItems: () ->
    return app.project.numItems > 0


# ----------------------------------------
# find
# ----------------------------------------
  find: (itemName) ->
    if @hasItems
      for i in [1..app.project.numItems]
        if app.project.item(i).name is itemName
          return app.project.item(i)

# ----------------------------------------
# filter
# ----------------------------------------
  filter: (expression, type) ->
    if @hasItems
      items = []
      for i in [1..app.project.numItems]
        item = app.project.item(i)
        passes = true

        if expression
          if not expression.test item.name
            passes = false

        if type
          if item.typeName isnt type
            passes = false

        items.push item if passes


      return items
