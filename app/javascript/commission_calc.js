function tax_calc() {
  const price = document.getElementById("item-price");

    if (price.getAttribute("data-load") != null) {
      return null;
    };

    price.setAttribute("data-load", "true");
    price.addEventListener("keyup", () => {
      commission_calc = Math.floor(price.value * 0.1);
      profit_calc = Math.ceil(price.value * 0.9);
      const commission = document.getElementById("add-tax-price");
      const profit = document.getElementById("profit");
      commission.innerHTML = commission_calc;
      profit.innerHTML = profit_calc;
    });
}

setInterval(tax_calc, 1000)