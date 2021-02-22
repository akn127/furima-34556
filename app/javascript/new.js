window.addEventListener("load",()=>{

  const price = document.getElementById("item-price");
  price.addEventListener("input",()=>{
    const inputValue = price.value;
    console.log(inputValue);

  const addTaxDom = document.getElementById("add-tax-price")
  addTaxDom.innerHTML = (Math.floor(inputValue * 0.1));
    console.log(addTaxDom);

  const profitAmount = document.getElementById("profit")
    const value_result = inputValue * 0.1
    console.log(value_result)
    profitAmount.innerHTML = (Math.floor(inputValue - value_result));
      console.log(profitAmount);
  })
})