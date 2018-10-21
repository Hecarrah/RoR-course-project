const BREWERIES = {}

BREWERIES.show = () => {
  $("#brewerytable tr:gt(0)").remove()
  const table = $("#brewerytable")

  BREWERIES.list.forEach((brewery) => {
    status = "";
    if((brewery['status']['value'])==true){status = "Active"}
    else{ status = "Inactive"}

    table.append('<tr>'
      + '<td>' + brewery['name'] + '</td>'
      + '<td>' + brewery['year']+ '</td>'
      + '<td>' + brewery['beercount']['count']+ '</td>'
      + '<td>' +  status + '</td>'
      + '</tr>')
  })
}

BREWERIES.sort_by_name = () => {
  BREWERIES.list.sort((a, b) => {
    return a.name.toUpperCase().localeCompare(b.name.toUpperCase());
  })
}

BREWERIES.sort_by_year = () => {
  BREWERIES.list.sort((a, b) => {
    return a.year > b.year
  })
}

BREWERIES.sort_by_beercount = () => {
  BREWERIES.list.sort((a, b) => {
    return a.beercount.count > b.beercount.count
  })
}

document.addEventListener("turbolinks:load", () => {
    if ($("#brewerytable").length == 0) {
      return
    } 
    
    $("#name").click((e) => {
      e.preventDefault()
      BREWERIES.sort_by_name()
      BREWERIES.show();
      
    })
  
    $("#year").click((e) => {
      e.preventDefault()
      BREWERIES.sort_by_year()
      BREWERIES.show()
    })
  
    $("#beercount").click((e) => {
      e.preventDefault()
      BREWERIES.sort_by_beercount()
      BREWERIES.show()
    })
  
    $.getJSON('breweries.json', (breweries) => {
      BREWERIES.list = breweries
      BREWERIES.show()
    })
  })