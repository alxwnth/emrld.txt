// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "./bootstrap.min"

$('#collapseHead1').click(function () {
    $("#open1").animate({
        rotate: "90deg"
    }, 500, function() {
        $(this).css("-moz-transform", "rotate(90deg)");
    });
})