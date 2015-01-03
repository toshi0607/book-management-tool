init = ->
  #Ajax通信に成功したタイミングで実行
  $('#isbn_search').on 'ajax:success', (e, data) ->
    bookTitle     = data.Items[0].title
    publisherName = data.Items[0].publisherName
    author        = data.Items[0].author
    #console.log(data.Items[0].title)
    console.log(bookTitle)
    console.log(author)
    #<ul id="result">要素の配下を空に
    $('#title'      ).empty()
    $('#description').empty()
    #取得したデータをもとに<li>要素を生成
    $('#title'      ).val("#{bookTitle}"    )
    $('#description').val("#{publisherName}" + " " +"#{author}")

$(document).ready(init)
$(document).on('page:change', init)