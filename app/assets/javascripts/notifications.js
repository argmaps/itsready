$(function() {
    $('#notification_customer_id').select2({
        placeholder: 'Enter customer name',
        allowClear: true,
        dropdownAutoWidth: false,
        selectOnBlur: true,
        createSearchChoice: function(term, data) {
            var $select2 = $('#notification_customer_id');

            // clear any previously attached callbacks
            $select2.off('select2-selecting', cb);

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

            return {id:term, text:'Click to create ' + '\"'+term+'\"'};
        }
    }).on('change', function() {
        var val = $(this).val(),
            existingCustomerSelected = /^\d+$/.test(val);

        if (existingCustomerSelected) {
            // needed so that typing and then arrowing down to a selection and
            // pressing enter doesn't result in the customer id appearing in
            // the select box
            $('#notification_customer_id').select2('val', val);

            var phone = $('#notification_customer_id option[value='+val+']').data('phone');
            $('#notification_customer_attributes_phone').val(phone)
                                                        .attr('disabled', true);
            $('#notification_ready').focus();
        } else {
            $('#notification_customer_attributes_phone').attr('disabled', false)
                                                        .focus();
        }
    });

    $('form.new_notification')
        .bind('ajax:beforeSend', function() {
            $('#create-notification').button('loading');
        })
        .bind('ajax:success', function() {
            $('#create-notification').attr('disabled', false)
                                     .button('reset');
        });

    $('.update_notification').click(function() {
        $(this).button('loading');
    });
});
