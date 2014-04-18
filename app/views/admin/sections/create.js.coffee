$("table.section").prepend("<%= j render partial: 'section', locals: { section: @admin_section } %>")

$("input#section_name").val("")
