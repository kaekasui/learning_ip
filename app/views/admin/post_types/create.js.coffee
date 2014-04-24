$("table.post_type").prepend("<%= j render partial: 'post_type', locals: { post_type: @admin_post_type } %>")

$("input#post_type_name").val("")
