$(function() {
    $('.notification_ready input[type=checkbox]').click(function() {
        $(this).closest('form').submit();
    });

    $('#new_notification .dk_options_inner li').click(function() {
        var selectedValue = $(this).find('a').attr('data-dk-dropdown-value');
        $('#notification_customer_id').val(selectedValue);
        $(this).closest('form').submit();
    });
});
