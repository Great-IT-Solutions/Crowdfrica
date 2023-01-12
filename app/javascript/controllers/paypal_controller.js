// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    this.setPaypal()
  }

  setPaypal() {
    if (typeof paypal === undefined) {
      return;
    }

    paypal.Buttons({
      style: {
        layout: 'vertical',
        shape:  'rect',
        label:  'paypal'
      },

      funding: {
        disallowed: [paypal.FUNDING.PAYLATER],
      },

      createOrder: function (data, actions) {
        return actions.order.create({
          purchase_units: [{
            amount: {
              value: Number(document.getElementById('paypal_amount').value) + Number(document.getElementById('paypal_tip').value)
            }
          }]
        });
      },

      onApprove:  function(data, actions) {

        console.log('data checking')
        console.log(data)
        console.log('data checking')
        return actions.order.capture()
          .then(function (details) {

            console.log('details checking')
            console.log(details)
            console.log('details checking')
            return fetch('/paypal-transaction-complete', {
              method: 'post',
              headers: {
                'content-type': 'application/json'
              },
              body: JSON.stringify({
                orderID: data.orderID,
                email: details.payer.email_address,
                fullname: details.payer.name.given_name + " " + details.payer.name.surname,
                tip_amount: Number(document.getElementById('paypal_tip').value),
                campaign_id: document.getElementById('campaign_id').value
              })
            })
            .then(response => response.json())
            .then(data => {
              window.location.href = data["redirect_url"];
            })
            .catch((error) => {
              console.error('Error:', error);
            });
          });
      }
    }).render('#paypal-button-container');
  }
}
