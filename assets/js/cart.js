;(function($){

    $(document).on('ready', function () {
        function formatPrice(price) {
          return (price / 100).toFixed(2) + '€';
        }

        function updateCart(data) {
          var coupon = data.coupon;

          $('.cart .items').val(data.items);
          $('.cart #payment').data('amount', data.amount);
          $('.cart #payment').attr('data-amount', data.amount);
          $('.cart #subtotal').text(formatPrice(data.subtotal));
          $('.cart #total').text(formatPrice(data.amount));
          $('.cart #taxes').text(formatPrice(data.taxes));
          $('.cart #discount').text(formatPrice(data.discount));
          $('.cart #price').text(formatPrice(data.price));
          $('.cart #coupon-reason').text(data.coupon_reason);

          if (coupon) {
            $('.cart #coupon-label').text(data.coupon).show();
          }
        }

        $.get('/cart', { locale: $('html').attr('lang') }).done(function (data) {
          updateCart(data);
        });

        $('.cart .add').click(function(event) {
          $.post('/cart/add').done(function (data) {
            updateCart(data);
          });

          event.preventDefault();
        });

        $('.cart .subtract').click(function(event) {
          $.post('/cart/subtract').done(function (data) {
            updateCart(data);
          });

          event.preventDefault();
        });

        $('.cart #checkout').submit(function( event ) {
          $('.cart .loading').show();
        });

        $('.cart #coupon').submit(function(event) {
          $.post('/cart/coupon').done(function (data) {
            updateCart(data);
          });

          event.preventDefault();

          return false;
        });
    });

})( jQuery );
