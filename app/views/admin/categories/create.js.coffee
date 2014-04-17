$("table.category").prepend("<%= j render partial: 'category', locals: { category: @admin_category } %>")

$("input#category_name").val("")
