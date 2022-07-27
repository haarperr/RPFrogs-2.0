let incorrectsubmission = 0;
let successpass = 0;
let allowedpass = false;
let selectedplayer = "";

document.onkeydown = function (evt) {
  evt = evt || window.event;
  if (evt.keyCode == 27) {
    $(".container-modmenu").hide();
    $.post("http://np-admin1/closenui", JSON.stringify({}));
  }
};

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy();
    const onlineplayers = data.players;

    var x = document.getElementById("playeroption1");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("playeroption1").appendChild(select);
    }

    select = document.getElementById("playeroption1");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy() {
  let element = document.getElementById("playeroption1");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy2();
    const onlineplayers = data.players;

    var x = document.getElementById("playeroption2");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("playeroption2").appendChild(select);
    }

    select = document.getElementById("playeroption2");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy2() {
  let element = document.getElementById("playeroption2");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy3();
    const onlineplayers = data.players;

    var x = document.getElementById("kickply");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("kickply").appendChild(select);
    }

    select = document.getElementById("kickply");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy3() {
  let element = document.getElementById("kickply");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy4();
    const onlineplayers = data.players;

    var x = document.getElementById("playeroption3");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("playeroption3").appendChild(select);
    }

    select = document.getElementById("playeroption3");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy4() {
  let element = document.getElementById("playeroption3");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy5();
    const onlineplayers = data.players;

    var x = document.getElementById("playeroption4");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("playeroption4").appendChild(select);
    }

    select = document.getElementById("playeroption4");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy5() {
  let element = document.getElementById("playeroption4");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy6();
    const onlineplayers = data.players;

    var x = document.getElementById("playeroption5");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("playeroption5").appendChild(select);
    }

    select = document.getElementById("playeroption5");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy6() {
  let element = document.getElementById("playeroption5");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

window.addEventListener("message", (event) => {
  let data = event.data;
  if (data.action == "openadmin") {
    $(".container-modmenu").show();
  }

  if (data.action == "playerretrieve") {
    destroy7();
    const onlineplayers = data.players;

    var x = document.getElementById("KickPlayerSystem");
    var option = document.createElement("option");
    option.text = "Select Player";
    x.add(option, x[0]);

    let i, len, text;
    for (i = 0, len = onlineplayers.length, text = ""; i < len; i++) {
      let select = document.createElement("option");
      select.id = "individualplayer";
      select.class = "widgieboyclub";
      select.innerHTML =
        "<p>" + "[" + onlineplayers[i][1] + "] " + onlineplayers[i][0] + "</p>";
      select.value = onlineplayers[i][1];
      document.getElementById("KickPlayerSystem").appendChild(select);
    }

    select = document.getElementById("KickPlayerSystem");

    select.onchange = function () {
      selectedplayer = this.value;
    };
  }
});

function destroy7() {
  let element = document.getElementById("KickPlayerSystem");
  while (element.firstChild) {
    element.removeChild(element.firstChild);
  }
}

function extendmenu() {
  $(".container-modmenu").css("width", "96%");
  $(".container-modmenu").css("transition", "1");
  $(".left-nav").css("width", "2.5%");
  $(".top-nav").css("width", "97.4%");
  $(".top-nav").css("left", "2.60%");
  $(".actions-scroll").css("width", "101.5%");
  $(".actions-scroll").css("left", "-8%");
  $(".actions-scroll").css("top", "-1%");
  $("#individualplayer").css("top", "-20.5%");
  $("#individualplayer").css("left", "-0%");

  $(".playerscontainer").css("left", "-0.1%");
  $(".playerscontainer").css("width", "103.4%");

  $(".container3").css("width", "108.25%");
  $(".container3").css("left", "-1.5%");

  $(".content").css("left", ".1%");
  $(".content").css("width", "92.025%");

  $(".playerlist").css("height", "88%");
  $(".extend-menu").hide();
  $(".shorten-menu").show();
}

function shortenmenu() {
  $(".container-modmenu").css("width", "22.7%");
  $(".container-modmenu").css("transition", "1");
  $(".left-nav").css("width", "10.05%");
  $(".top-nav").css("width", "90%");
  $(".top-nav").css("left", "10%");
  $(".actions-scroll").css("width", "90%");
  $(".actions-scroll").css("top", "1%");
  $(".actions-scroll").css("left", "");
  $("#individualplayer").css("top", "-5%");
  $("#individualplayer").css("width", "90%");

  $(".playerscontainer").css("left", "4.5%");
  $(".playerscontainer").css("width", "96.5%");

  $(".container3").css("width", "100%");
  $(".container3").css("left", "0%");

  $(".content").css("left", ".6%");
  $(".content").css("width", "91.85%");

  $(".playerlist").css("height", "91%");
  $(".extend-menu").show();
  $(".shorten-menu").hide();
}

function userstage() {
  $(".stage-players").hide();
  $(".stage-two").hide();
  $(".stage-admin").hide();
  $(".stage-user").show();
  //$('.stage-three').hide();
  //$('.stage-four').fadeIn();
  document.getElementById("stage1button").classList.remove("btnactive");
  document.getElementById("stage2button").classList.remove("btnactive");
  document.getElementById("stageplayerbutton").classList.remove("btnactive");
  document.getElementById("stageuserbutton").classList.add("btnactive");
}

function playersstage() {
  $(".stage-players").show();
  $(".stage-two").hide();
  $(".stage-admin").hide();
  $(".stage-user").hide();
  //$('.stage-three').hide();
  //$('.stage-four').fadeIn();
  document.getElementById("stage1button").classList.remove("btnactive");
  document.getElementById("stage2button").classList.remove("btnactive");
  document.getElementById("stageplayerbutton").classList.add("btnactive");
  document.getElementById("stageuserbutton").classList.remove("btnactive");
}

function stageone() {
  $(".stage-players").hide();
  $(".stage-two").hide();
  $(".stage-admin").show();
  $(".stage-user").hide();
  //$('.stage-three').hide();
  //$('.stage-four').fadeIn();

  document.getElementById("stage1button").classList.add("btnactive");
  document.getElementById("stage2button").classList.remove("btnactive");
  document.getElementById("stageplayerbutton").classList.remove("btnactive");
  document.getElementById("stageuserbutton").classList.remove("btnactive");
}

function stagetwo() {
  $(".stage-players").hide();
  $(".stage-two").show();
  $(".stage-admin").hide();
  $(".stage-user").hide();
  //$('.stage-three').hide();
  //$('.stage-four').fadeIn();

  document.getElementById("stage1button").classList.remove("btnactive");
  document.getElementById("stage2button").classList.add("btnactive");
  document.getElementById("stageplayerbutton").classList.remove("btnactive");
  document.getElementById("stageuserbutton").classList.remove("btnactive");
}

function tptomarker() {
  $.post("http://np-admin1/tptomarker", JSON.stringify({}));
}

function sendAnnounce() {
  var message = document.getElementById("announce").value;

  $.post("http://np-admin1/sendAnnouncement", JSON.stringify({ message }));
}

function maxstats() {
  $.post("http://np-admin1/maxstats", JSON.stringify({}));
}

function currentcoords() {
  $.post("http://np-admin1/getplayercoords", JSON.stringify({}));
}

function spawncarmenu() {
  $(".content").hide();
  $(".spawnmoneyamt").hide();
  $(".solo-input").show();
  $(".spawncarinput").show();
  $(".garagestateinput").hide();
  $(".modelchange").hide();
}

function spawncarnow() {
  var carname = document.getElementById("spawncar").value;
  $.post("http://np-admin1/spawncar", JSON.stringify({ carname }));
  $(".vehcont").hide();
  $(".spawncarinput").hide();
  $(".solo-input").hide();
}

function spawnitemnow() {
  $(".solo-input").hide();
  $(".spawniteminput").hide();
  $(".itemcont").hide();
  var itemname = document.getElementById("spawnitem").value;
  var itemamount = document.getElementById("spawnitemamount").value;

  $.post("http://np-admin1/spawnitem", JSON.stringify({ itemname, itemamount }));
}

function spawnmoneyconfirm() {
  $(".solo-input").hide();
  $(".spawniteminput").hide();
  $(".spawnmoneycont").hide();
  var MoneyAmt = document.getElementById("spawnmoneyamount").value;

  $.post("http://np-admin1/np-admin1:spawnmoney", JSON.stringify({ MoneyAmt }));
}

function spawnitemmenu() {
  $(".content").hide();
  $(".spawnmoneyamt").hide();
  $(".solo-input").show();
  $(".spawniteminput").show();
  $(".spawncarinput").hide();
  $(".garagestateinput").hide();
  $(".modelchange").hide();
}

function BackItem() {
  $(".spawniteminput").hide();
  $(".itemcont").hide();
  $(".solo-input").hide();
}

function BackSpawnMoney() {
  $(".spawnmoneyamt").hide();
  $(".spawnmoneycont").hide();
  $(".solo-input").hide();
}

function BackVeh() {
  $(".vehcont").hide();
  $(".spawncarinput").hide();
  $(".solo-input").hide();
}

function backfromsolo() {
  $(".solo-input").hide();
  $(".spawncarinput").hide();
  $(".spawniteminput").hide();
  $(".garagestateinput").hide();
}

function setgaragestatemenu() {
  $(".content").hide();
  $(".solo-input").show();
  $(".spawnmoneyamt").hide();
  $(".garagestateinput").show();
  $(".spawniteminput").hide();
  $(".spawncarinput").hide();
  $(".modelchange").hide();
}

function setModelMenu() {
  $(".content").hide();
  $(".solo-input").show();
  $(".modelchange").show();
  $(".spawnmoneyamt").hide();
  $(".garagestateinput").hide();
  $(".spawniteminput").hide();
  $(".spawncarinput").hide();
}

function setCoordMenu() {
  $(".content").hide();
  $(".solo-input").show();
  $(".spawnmoneyamt").show();
  $(".modelchange").hide();
  $(".garagestateinput").hide();
  $(".spawniteminput").hide();
  $(".spawncarinput").hide();
}

function modelContMenu() {
  $(".solo-input").show();
  $(".changemodelinput").show();
  $(".spawniteminput").hide();
  $(".spawncarinput").hide();
}

function setgaragestate() {
  $(".solo-input").hide();
  $(".garagestateinput").hide();
  $(".modelchange").hide();
  $(".garagecont").hide();
  var licenseplate = document.getElementById("licenseplate").value;

  $.post(
    "http://np-admin1/np-admin1:vehicle_garage",
    JSON.stringify({ licenseplate })
  );
}

function setPlayerModel() {
  $(".solo-input").hide();
  $(".garagestateinput").hide();
  $(".modelcont").hide();
  var model = document.getElementById("model").value;

  $.post("http://np-admin1/np-admin1:model_change", JSON.stringify({ model }));
}

function BackFromModel() {
  $(".solo-input").hide();
  $(".garagestateinput").hide();
  $(".modelcont").hide();
}

function BackFromGarState() {
  $(".solo-input").hide();
  $(".garagestateinput").hide();
  $(".garagecont").hide();
}

function viewentity() {
  $.post("http://np-admin1/viewentity", JSON.stringify({}));
}

function devmodecheckbox() {
  // Get the checkbox
  var checkBox = document.getElementById("devmodecheckbox");
  // Get the output text

  // If the checkbox is checked, display the output text
  var returnvalue = checkBox.checked;
  if (checkBox.checked == true) {
    $.post("http://np-admin1/devmode", JSON.stringify({ returnvalue }));
  } else {
    $.post("http://np-admin1/devmode", JSON.stringify({ returnvalue }));
  }
}

function debugmodecheckbox() {
  // Get the checkbox
  var checkBox = document.getElementById("debugmodecheckbox");
  // Get the output text

  // If the checkbox is checked, display the output text
  var returnvalue = checkBox.checked;

  if (checkBox.checked == true) {
    $.post("http://np-admin1/debugmode", JSON.stringify({ returnvalue }));
  } else {
    $.post("http://np-admin1/debugmodeoff", JSON.stringify({ returnvalue }));
  }
}

function godmodecheckbox() {
  $.post("http://np-admin1/godmode", JSON.stringify({}));
}

function invisiblecheckbox() {
  // Get the checkbox
  var checkBox = document.getElementById("invisiblecheckbox");
  // Get the output text

  // If the checkbox is checked, display the output text
  var returnvalue = checkBox.checked;

  if (checkBox.checked == true) {
    $.post("http://np-admin1/invisible", JSON.stringify({ returnvalue }));
  } else {
    $.post("http://np-admin1/invisible", JSON.stringify({ returnvalue }));
  }
}

function healcheckbox() {
  $.post("http://np-admin1/heal", JSON.stringify({}));
}

function revivepersonal() {
  $.post("http://np-admin1/revivepersonal", JSON.stringify({}));
}

function spectateplayer() {
  $.post("http://np-admin1/spectateplayer", JSON.stringify({ selectedplayer }));
}

function bringplayer() {
  $.post("http://np-admin1/bringplayer", JSON.stringify({ selectedplayer }));
}

function KickPlayer() {
  $.post(
    "http://np-admin1/np-admin1:KickPlayer",
    JSON.stringify({ selectedplayer })
  );
}

function teleporttoplayer() {
  $.post(
    "http://np-admin1/teleporttoplayer",
    JSON.stringify({ selectedplayer })
  );
}

function reviveplayer() {
  $.post("http://np-admin1/reviveplayer", JSON.stringify({ selectedplayer }));
}

function healplayer() {
  $.post("http://np-admin1/healplayer", JSON.stringify({ selectedplayer }));
}

function fixcarplayer() {
  $.post("http://np-admin1/fixcarplayer", JSON.stringify({ selectedplayer }));
}

function fixcarpersonal() {
  $.post("http://np-admin1/fixcarpersonal", JSON.stringify({}));
}

function RemoveStress() {
  $.post("http://np-admin1/removestress", JSON.stringify({}));
}

function barbermenu() {
  $(".container-modmenu").hide();
  $.post("http://np-admin1/barbermenu", JSON.stringify({}));
}

function searchplayer() {
  $(".container-modmenu").hide();
  $.post(
    "http://np-admin1/searchinventoryplayer",
    JSON.stringify({ selectedplayer })
  );
}

function Clothingmenuplayer() {
  $(".container-modmenu").hide();
  $.post(
    "http://np-admin1/clothingmenuplayer",
    JSON.stringify({ selectedplayer })
  );
}
