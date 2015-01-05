$(document).on "page:change", ->
  $("#publication a.add_fields").data("association-insertion-position", "before").data "association-insertion-node", "this"
  $("#publication").bind "cocoon:after-insert", ->
    $("#publication_from_list").hide()
    $("#publication a.add_fields").hide()
    return

  $("#publication").bind "cocoon:after-remove", ->
    $("#publication_from_list").show()
    $("#publication a.add_fields").show()
    return

  return
