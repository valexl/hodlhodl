import "../css/app.css";

import "bootstrap";
import "bootstrap/dist/css/bootstrap.min.css";

document.addEventListener("DOMContentLoaded", () => {
  const input = document.querySelector("#amount_usdt");
  const estimatedField = document.querySelector("#estimated_btc");
  const exchangeFeeField = document.querySelector("#exchange_fee_btc");
  const networkFeeField = document.querySelector("#network_fee_btc");

  const NETWORK_FEE = 0.0005;
  const BTC_RATE = parseFloat(input.dataset.btcRate);;
  
  function updateSummary() {
    const usdt = parseFloat(input.value);
    if (isNaN(usdt) || usdt <= 0) return;
  
    const exchangeFee = usdt * 0.03 * BTC_RATE;
    const networkFee = 0.000006;
    const estimated = usdt * BTC_RATE - exchangeFee - networkFee;
  
    estimatedField.textContent = `~ ${estimated.toFixed(8)} BTC`;
    exchangeFeeField.textContent = `${exchangeFee.toFixed(8)} BTC`;
    networkFeeField.textContent = `${networkFee.toFixed(8)} BTC`;
  }
  
  input.addEventListener("input", updateSummary);
  updateSummary()
});

