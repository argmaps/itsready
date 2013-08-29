// Some general UI pack related JS

$(function () {
    // Custom selects
    if($("select.dropkick").length > 0) {
        $("select.dropkick").dropkick();
    }
});

$(document).ready(function() {
    // JS input/textarea placeholder
    $("input, textarea").placeholder();

    $(".btn-group a").click(function() {
        $(this).siblings().removeClass("active");
        $(this).addClass("active");
    });

    // Disable link click not scroll top
    $("a[href='#']").click(function() {
        return false
    });
});
