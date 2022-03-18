
// to load all the built-in supported function by backend
/*

for exampke utils.compareSmartWeightGain({gain_lbs=5,during_day=7}) 


*/

const utils = require("utils.js")


let((hypo = 70), (hyper = 250), (severe = 300), (ketone = 1));

let((redZone = false), (yellowZone = false), (greenZone = false));


/*
execution rule will be interepreted inside this function than change the global object value
*/
function dmpFunctionTable(inputData) {

//====================================================================================================
//--------------Row 1----------------------------------------------------

  if (inputData.BG.value <= hypo) {
    if (IsHappening("BG", null, 60 * 1000, 1, hypo, 0)) {
      redZone = true;
    } else {
      yellowZone = true;
    }
  }
  // return;// if user wanna stop rule, don't let script inteprete next row.

//--------------Row 2----------------------------------------------------

  if (inputData.BG.value < hyper && inputData.BG.value > hypo) {
    if (Questionaire("hyper", inputData)) {
      redZone = true;
    } else {
      yellowZone = true;
    }
  }
// return

//--------------Row 3----------------------------------------------------

  if (inputData.BG.value >= hyper && inputData.BG.attributes == "fasting") {
    redZone = true;
  }


//====================================================================================================


}
