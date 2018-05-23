function itemAnimation() {
    if ($(window).width() < 1120) {
        $("#markdown-list").find("small").css("display", "none");
    }
    if ($(window).width() < 991) {
        $("#markdown-list").find("small").css("display", "");
    }
    if ($(window).width() < 510) {
        $("#markdown-list").find("small").css("display", "none");
    }
    if ($(window).width() > 1120) {
        $("#markdown-list").find("small").css("display", "");
    }
}

$("#markdown-panel").height(770);
$(window).resize(function () {
    itemAnimation()
});
$(document).ready(function () {
    itemAnimation();
});
var nowYear = new Date().getFullYear();
$('#newYear').html(nowYear);