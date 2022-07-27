const showBoostList = (carName, carModel, boostClass) => {
  const li = `
  <li class="boostListItem">
  <p style="margin-bottom: 10px">Vehicle: ${carName}</h5>
  <p style="margin-bottom: 10px">Contract Type: ${boostClass}</p>
  <div class="boost-list-btns">
    <button id="boostAccept" style="margin-left: 2.6vh;" class="btn-boosting-buttons" carModel="${carModel}" carName="${carName}" boostClass="${boostClass}" > Start Contract</button>
    <button id='boostDecline' style="margin-left: 3.6vh;" class="btn-boosting-buttons"> Decline Contract </button>
    <button  style="margin-left: 4.6vh;" class="btn-boosting-buttons" > Transfer Contract
    </button>
  </div>
  </li>
  `;
  $("#carBoostList").append(li);
};

$(function () {
  function display(bool) {
    if (bool) {
      $("#boosting_container").show();
      $.post("https://np-boosting/getXp", JSON.stringify({}));
    } else {
      $("#boosting_container").hide();
    }
  }

  window.addEventListener("message", function (e) {
    let data = e.data;
    if (data.type === "ui") {
      if (data.status === true) {
        display(true);
        $("#date").html(data.date);
        $("#time").html(data.time);
      } else {
        display(false);
      }
    }
    if (data.isBoostReady === true) {
      showBoostList(data.carName, data.carModel, data.boostClass);
    }
    if (data.type === "xpCheck") {
      setXpBar(data.xp);
      setLevelStr(data.level);
    }
    if (data.type === "complete") {
      $("#boostInProgress").hide();
      $("#boostAppMain").show();
      isBoostActive = false;
    }
  });

  const setLevelStr = (level) => {
    if (level === 1) {
      $("#levelleft").html("D");
      $("#levelright").html("C");
    } else if (level === 2) {
      $("#levelleft").html("C");
      $("#levelright").html("B");
    } else if (level === 3) {
      $("#levelleft").html("B");
      $("#levelright").html("A");
    } else if (level === 4) {
      $("#levelleft").html("A");
      $("#levelright").html("S");
    } else if (level === 5) {
      $("#levelleft").html("S");
      $("#levelright").html("S+");
    } else if (level === 6) {
      $("#levelleft").html("S+");
      $("#levelright").html("?");
    }
  };

  const setXpBar = (xp) => {
    let widthNum = xp > 100 ? 100 : xp;
    let width = widthNum.toString() + "%";

    $("#myBar").css("width", width);
  };

  display(false);
  $("#boostingApp").hide();
  $("#loading").hide();
  $("#boostAppMain").hide();
  $("#confirmDeclineModal").hide();
  $("#leaveQueueBtn").hide();

  document.onkeyup = function (data) {
    if (data.which == 27) {
      $.post("https://np-boosting/close", JSON.stringify({}));
    }
  };

  let isLoggedIn = false;
  let isBoostActive = false;
  let isInQueue = false;

  $("#openBoostApp").click(function () {
    $("#boostInProgress").hide();
    $("#boostingApp").show();
    if (!isLoggedIn) {
      $("#boostAppMain").show();
    } else {
      $("#boostAppMain").show();
    }

    if (isLoggedIn) {
      $("#boostAppMain").show();
    } else if (!isLoggedIn) {
      $("#boostAppMain").show();
    } else if (isBoostActive && isLoggedIn) {
      $("#boostAppMain").hide();
    }
  });

  $("#closeBoostApp").click(function () {
    $("#boostingApp").hide();
  });

  $("#queueBtn").click(function () {
    if (isInQueue === false) {
      $("#loading").show();
      $("#queueBtn").hide();
      setTimeout(() => {
        $.post("https://np-boosting/joinBoostQueue"), JSON.stringify({});
        $("#leaveQueueBtn").show();
        $("#loading").hide();
        isInQueue = true;
      },);
    }
  });

  $("#leaveQueueBtn").click(function () {
    if (isInQueue === true) {
      $("#loading").show();
      $("#leaveQueueBtn").hide();
      setTimeout(() => {
        $.post("https://np-boosting/leaveBoostQueue"), JSON.stringify({});
        $("#queueBtn").show();
        $("#loading").hide();
        isInQueue = false;
      },);
    }
  });

  $(document).on("click", "#boostAccept", function () {
    const carModel = $(this).attr("carModel");
    const carName = $(this).attr("carName");
    const carClass = $(this).attr("boostClass");

    $("boostInProgress").show();
    $.post(
      "https://np-boosting/startBoost",
      JSON.stringify({
        carName: carName,
        carModel: carModel,
        carClass: carClass,
      })
    );
    $(this).closest(".boostListItem").remove();
    $("#boostCarName").text(carName);
    $("#boostAppMain").hide();
    $("#boostInProgress").show();
    $.post("https://np-boosting/leaveBoostQueue"), JSON.stringify({});
    $("#queueBtn").show();
    $("#leaveQueueBtn").hide();
    $("#loading").hide();
    isInQueue = false;
    isBoostActive = true;
  });

  let liTargetDel = null;

  $(document).on("click", "#boostDecline", function () {
    liTargetDel = $(this).closest(".boostListItem");
    liTargetDel.remove();
  });

  $("#cancelBoost").click(function () {
    $.post("https://np-boosting/cancelContract", JSON.stringify({}));
    $("#boostAppMain").show();
    $("#boostInProgress").hide();
    isBoostActive = false;
    // ALSO LOSE XP?
  });
});

// New

  $(document).on('click',".btn-boosting", function(){
    let task = $(this).data('task')
    id = $(this).data('id')
  if(task === null) {
  return
  }
    if(task === 'start') {
        // close()

        $(document).on('click',"#closevin", function(){
            $("#StartContract").fadeOut()
        })
      
        if(idsvin.indexOf(id) >= 0) {
            $("#StartContract").fadeIn()
        } else {
            close()
            $.post('https://np-boosting/dick', JSON.stringify({
                id: id,
            }));
        }
      
      
    } else if(task === 'decline') {
        amountoftasks = amountoftasks - 10
        // close()
        $(`div.vehicle-boosting[data-id="${id}"]`).remove()
        $.post('https://np-boosting/decline', JSON.stringify({
            id: id,
        }));
    }

  });

  $(".settings").click(function() {
      $(".boosting-settings").fadeToggle('slow')
  })

  $("#background-apply").click(function() {
    $.post('https://np-boosting/updateBoostBackground', JSON.stringify({url: $("#bacgkroundurl").val()}));

    $(".tablet-container").css('background-image' ,"url(" +  $("#bacgkroundurl").val() + ")")
  })

  $("#background-reset").click(function() {
      $.post('https://np-boosting/updateuupdateBoostBackgroundrl', JSON.stringify({url: dddurl}));

      $(".tablet-container").css('background-image' ,"url(" +  dddurl + ")")
  })