init = ->
  #Ajax通信に成功したタイミングで実行
  $('#isbn_search').on 'ajax:success', (e, data) ->
    bookTitle = data.Items[0].title
    #console.log(data.Items[0].title)
    console.log(bookTitle)
    #<ul id="result">要素の配下を空に
    $('#rtitle').empty()
    #取得したデータをもとに<li>要素を生成
    $('#title').val("#{bookTitle}")

$(document).ready(init)
$(document).on('page:change', init)