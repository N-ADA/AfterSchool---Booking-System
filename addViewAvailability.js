const starttime = document.querySelector(".start-time-control");
const endtime = document.querySelector(".end-time-control");
const date = document.querySelector(".date-control");
const addBtn = document.getElementById("addBtn");

starttime.addEventListener("change", () =>{
	updateAddBtn();
});
endtime.addEventListener("change", () =>{
	updateAddBtn();
});
date.addEventListener("change", () =>{
	updateAddBtn();
});

function updateAddBtn(){
	if(starttime.value && endtime.value && date.value){
		addBtn.disabled = false;
	}
}
