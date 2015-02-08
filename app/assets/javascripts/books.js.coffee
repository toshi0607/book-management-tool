init = ->
  #Ajax通信に成功したタイミングで実行

  $('.isbn_search').on 'ajax:success', (e, data) ->
    i = $(this).attr('id');
    bookTitle     = data.Items[0].title
    publisherName = data.Items[0].publisherName
    author        = data.Items[0].author

    console.log(bookTitle)
    console.log(author)

    #<ul id="result">要素の配下を空に
    $('#form_book_collection_books_attributes_' + i + '_title'      ).empty()
    $('#form_book_collection_books_attributes_' + i + '_description').empty()
    #取得したデータをもとに<li>要素を生成
    $('#form_book_collection_books_attributes_' + i + '_title'      ).val("#{bookTitle}"    )
    $('#form_book_collection_books_attributes_' + i + '_description').val("#{publisherName}" + " " +"#{author}")

$(document).ready(init)
$(document).on('page:change', init)