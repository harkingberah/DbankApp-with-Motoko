// import './index.scss';
import { dbankk_backend } from "../../declarations/dbankk_backend";

window.addEventListener("load", async function () {
  //console.log("Hello from frontend");
  // checkBalance();
   updateBalance();
});

document.querySelector("form").addEventListener("submit",async function (event){
  event.preventDefault();
  //console.log("submitted");

  const button= event.target.querySelector("#submit-btn");


  const inputAmount=parseFloat(document.getElementById("input-amount").value);
  const outputAmount=parseFloat(document.getElementById("withdrawal-amount").value);


  button.setAttribute("disabled", true);

if (document.getElementById("input-amount").value.length!=0){
  await dbankk_backend.topUp(inputAmount);
}

if (document.getElementById("withdrawal-amount").value.length !=0){
    await dbankk_backend.withdraw(outputAmount);
}

await dbankk_backend.compound();

updateBalance();
//   await dbankk_backend.topUp(withdrawalAmount);



document.getElementById("input-amount").value="";
document.getElementById("withdrawal-amount").value="";
button.removeAttribute("disabled");

});


async function updateBalance(){
  const currentAmount = await dbankk_backend.checkBalance();
  document.getElementById("value").innerText=Math.round(currentAmount*100)/100;
}