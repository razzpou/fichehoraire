# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("#select_client").change ->
    $("#select_site, #select_mission").empty()
    $.ajax(url: "/landings/get_site?client_id="+$("#select_client").val()).done (data) ->
      data.forEach (site) ->
        o = new Option(site.name, site.id)
        $(o).html site.name
        $("#select_site").append o
        return
      return
    return

  $("#select_site").change ->
    $("#select_mission").empty()
    $.ajax(url: "/landings/get_mission?site_id="+$("#select_site").val()).done (data) ->
      data.forEach (mission) ->
        console.log "test"
        console.log mission
        console.log mission.name
        console.log mission.id
        o = new Option(mission.name, mission.id)
        $(o).html mission.name
        $("#select_mission").append o
        return
      return
    return
  return
