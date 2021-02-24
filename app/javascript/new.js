window.addEventListener("load",()=>{

  const price = document.getElementById("item-price");
  price.addEventListener("input",()=>{
    const inputValue = price.value;

  const addTaxDom = document.getElementById("add-tax-price")
  addTaxDom.innerHTML = (Math.floor(inputValue * 0.1));

  const profitAmount = document.getElementById("profit")
    const value_result = inputValue * 0.1
    profitAmount.innerHTML = (Math.floor(inputValue - value_result));
  })
})