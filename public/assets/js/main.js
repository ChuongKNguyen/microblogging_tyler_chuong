$(document).ready(function() {
    var text_max = 150;
    $('#textarea_feedback').html(text_max + ' characters remaining');

    $('#body').keyup(function() {
        var text_length = $('#body').val().length;
        var text_remaining = text_max - text_length;

        $('#textarea_feedback').html(text_remaining + ' characters remaining');
    });
});