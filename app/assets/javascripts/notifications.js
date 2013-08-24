$(function() {
    $('.notification_ready input[type=checkbox]').click(function() {
        $(this).closest('form').submit();
    });

    $('#new_notification .dk_options_inner li').click(function() {
        var selectedValue = $(this).find('a').attr('data-dk-dropdown-value');
        $('#notification_customer_id').val(selectedValue);
        $(this).closest('form').submit();
    });

    $('#notification_customer_id').select2({
        placeholder: 'Enter customer name',
        allowClear: true,
        dropdownAutoWidth: false,
        selectOnBlur: true,
        formatNoMatches: function() {
            var html = "<li class='select2-no-results'>Create new customer</li>";
            return html;
        },
        createSearchChoice: function(term) {
            var $select2 = $('#notification_customer_id');
            var cb = function(event) {
                // remove 'Create' from the selection text so we just see the new
                // customer name in the input field
                var fullName = event.val;
                event.object.text = fullName;

                var firstName = fullName.split(' ')[0],
                    lastName = fullName.split(' ')[1];
                $('#notification_customer_attributes_first_name').val(firstName);
                $('#notification_customer_attributes_last_name').val(lastName);

                // don't run this callback again
                $select2.off('select2-selecting', cb);
            };
            $select2.on('select2-selecting', cb);

            return {id:term, text:'Create ' + '\"'+term+'\"'};
        }
    }).on('change', function() {
        var val = $(this).val(),
            existingCustomerSelected = /^\d+$/.test(val),
            phone = $('#notification_customer_id option[value='+val+']').data('phone');
        $('#notification_customer_attributes_phone').val(phone);

        if (existingCustomerSelected) {
            $('#notification_customer_attributes_phone').attr('disabled', true);
            $('#notification_message').focus();
        } else {
            $('#notification_customer_attributes_phone').attr('disabled', false)
                                                        .focus();
        }
    });

    $('#notification_message').select2({
        dropdownAutoWidth: false,
        selectOnBlur: true,
        createSearchChoice: function(term) {
            var $select2 = $('#notification_message');
            var cb = function(event) {
                $('#notification_message[type=hidden]').val(event.val);

                // don't run this callback again
                $select2.off('select2-selecting', cb);
            };
            $select2.on('select2-selecting', cb);
            return {id:term, text:term};
        }
    });

    $('form.new_notification')
        .bind('ajax:beforeSend', function() {
            $('#create-notification').button('loading');
        })
        .bind('ajax:success', function() {
            $('#create-notification').button('reset');
        });
});
