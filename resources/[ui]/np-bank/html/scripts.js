var active = 0;
var isATM = false;

$(document).ready(function () {
    $("#bank-container").hide();

    window.addEventListener("message", function (event) {
        var item = event.data;

        if (item.type == "load") {
            $("#load-container").show();
            $(".spinner").show();
            isATM = item.atm;
        }

        if (item.type == "bank") {
            if (item.toggle) {
                $(".spinner").hide();
                $("#bank-container").slideToggle(500);
                $("#load-container").hide();
            } else {
                $("#bank-container").hide();
            }
        }

        if (item.type == "accounts") {
            $(".cash").html(`Cash: $${item.cash.toLocaleString()}.00`);

            $("#accounts").empty();

            let accounts = item.accounts

            for (var i = 0; i < accounts.length; i++) {
                let element = ``

                element += `<div class="accounts-box" id="${accounts[i].account_id}">`
                    element += `<div id="account_info_${accounts[i].account_id}" class="account-f">${accounts[i].account_name} / ${accounts[i].account_id}</div>`
                    element += `<div class="account-f-type">${accounts[i].account_type}</div>`
                    element += `<div class="account-f-name">${accounts[i].account_owner}</div>`
                    element += `<div class="account-f-balance">$${accounts[i].account_balance.toLocaleString()}.00</div>`
                    element += `<div class="account-f-balance-text">Account Balance</div>`
                    element += `<button id="button_withdraw_${accounts[i].account_id}" class="withdraw-button o">WITHDRAW</button>`
                if (isATM == false) {
                    element += `<button id="button_deposit_${accounts[i].account_id}" class="deposit-button g">DEPOSIT</button>`
                }
                    element += `<button id="button_transfer_${accounts[i].account_id}" class="transfer-button w">TRANSFER</button>`
                element += `</div>`

                $("#accounts").append(element);

                if (accounts[i].is_frozen) {
                    $("#account_info_" + accounts[i].account_id).append(` <span class="frozen">(FROZEN)</span>`);
                };

                if (accounts[i].cantWithdraw || accounts[i].is_frozen) {
                    $("#button_withdraw_" + accounts[i].account_id).prop("disabled", true);
                    $("#button_transfer_" + accounts[i].account_id).prop("disabled", true);
                    $("#button_withdraw_" + accounts[i].account_id).attr("class", "withdraw-button disabled");
                    $("#button_transfer_" + accounts[i].account_id).attr("class", "transfer-button disabled");
                }

                if (accounts[i].cantDeposit || accounts[i].is_frozen) {
                    $("#button_deposit_" + accounts[i].account_id).prop("disabled", true);
                    $("#button_deposit_" + accounts[i].account_id).attr("class", "deposit-button disabled");
                }

                $("#" + accounts[i].account_id).data("id", accounts[i].account_id);
                $("#" + accounts[i].account_id).data("name", accounts[i].account_name);
            }
        }

        if (item.type == "transactions") {
            $("#transaction").empty();

            let transactions = item.transactions

            $("#" + active).removeClass("active");
            active = item.id;
            $("#" + active).addClass("active");

            for (var i = 0; i < transactions.length; i++) {
                let timesences = humanized_time_span(transactions[i].transcation_date)

                let pos = ""
                let color = "#7bda78"

                if (transactions[i].transcation_amount < 0) {
                    pos = "-"
                    color = "#eea06d"
                }

                let element

                element = `<div id="transaction-box">`
                    element += `<div class="tr-head">`
                        element += `<h3 style="text-align: left; float: left">${transactions[i].transcation_receiver_name} / ${transactions[i].transcation_receiver} [${transactions[i].transcation_type.toUpperCase()}]</h3>`
                        element += `<h3 style="text-align: right; float: right">${transactions[i].transcation_uid}</h3>`
                        element += `<h3 class="headr"></h3>`
                    element += `</div>`
                    element += `<div class="middle">`
                        element += `<div class="money" style="color:${color} ">${pos}$${Math.abs(transactions[i].transcation_amount).toLocaleString()}.00</div>`
                        element += `<div class="name">${transactions[i].transcation_user_receiver}</div>`
                        element += `<div class="clock">${timesences}</div>`
                    element += `</div>`
                    element += `<div class="middle-two">`
                        element += `<div class="name-bottom">${transactions[i].transcation_user_sender}</div>`
                    element += `</div>`
                    element += `<div class="bottom">`
                        element += `<div class="msg-font">Message</div>`
                        element += `<div class="msg-ex">${transactions[i].transcation_comment}</div>`
                    element += `</div>`
                element += `</div>`

                $("#transaction").append(element);
            }
        }

        if (item.type == "loadstart") {
            $(".spinner-co").show();
            $(".hide-co").hide();
        }

        if (item.type == "loadend") {
            $("#withdraw-page").hide();
            $("#transfer-page").hide();
            $("#deposit-page").hide();
            $(".back-filter").hide();
            $(".hide-co").show();
            $(".spinner-co").hide();
        }

    })
});

document.onkeyup = function (data) {
    if (data.which == 27) {
        $.post("https://np-bank/close");

        $("#withdraw-page").fadeOut();
        $("#deposit-page").fadeOut();
        $("#transfer-page").fadeOut();
        $(".back-filter").hide();
    }
}




$("#accounts").on("click", ".accounts-box", function (e) {
    e.preventDefault();

    let name = $("#" + active).data("name");
    $(".box-header").html(`${name} /<br>${active}`);

    let id = $(this).data("id");
    $.post("https://np-bank/transactions", JSON.stringify({
        id: id,
    }));
});

$("#accounts").on("click", ".withdraw-button", function (e) {
    e.preventDefault();

    $("#w-number").val("");
    $("#w-comment").val("");

    $("#withdraw-page").fadeIn();
    $(".back-filter").show();
});

$("#accounts").on("click", ".deposit-button", function (e) {
    e.preventDefault();

    $("#d-number").val("");
    $("#d-comment").val("");

    $("#deposit-page").fadeIn();
    $(".back-filter").show();
});

$("#accounts").on("click", ".transfer-button", function (e) {
    e.preventDefault();

    $("#t-number").val("");
    $("#t-comment").val("");
    $("#t-target").val("");

    $("#transfer-page").fadeIn();
    $(".back-filter").show();
});

$(".cancel").click(function (e) {
    e.preventDefault();
    $("#withdraw-page").fadeOut();
    $("#deposit-page").fadeOut();
    $("#transfer-page").fadeOut();
    $(".back-filter").hide();
});

$(".w-okay").click(function (e) {
    var wvalue = document.getElementById("w-number").value;
    var wcomment = document.getElementById("w-comment").value;
    let id = $("#" + active).data("id");

    if (wvalue != "" && wvalue > 0) {
        $.post("https://np-bank/withdraw", JSON.stringify({
            id: id,
            value: wvalue,
            comment: wcomment
        }));
    }
});

$(".d-okay").click(function (e) {
    var dvalue = document.getElementById("d-number").value;
    var dcomment = document.getElementById("d-comment").value;
    let id = $("#" + active).data("id");

    if (dvalue != "" && dvalue > 0) {
        $.post("https://np-bank/deposit", JSON.stringify({
            id: id,
            value: dvalue,
            comment: dcomment
        }));
    }
});

$(".t-okay").click(function (e) {
    var tvalue = document.getElementById("t-number").value;
    var tcomment = document.getElementById("t-comment").value;
    var tid = document.getElementById("t-target").value;
    let id = $("#" + active).data("id");

    if (tvalue != "" && tvalue > 0 && tid != "" && tid > 0) {
        $.post("https://np-bank/transfer", JSON.stringify({
            id: id,
            value: tvalue,
            comment: tcomment,
            to: tid
        }));
    }
});

function humanized_time_span(date, ref_date, date_formats, time_units) {
    //Date Formats must be be ordered smallest -> largest and must end in a format with ceiling of null
    date_formats = date_formats || {
        past: [
            { ceiling: 60, text: "$seconds seconds ago" },
            { ceiling: 3600, text: "$minutes minutes ago" },
            { ceiling: 86400, text: "$hours hours ago" },
            { ceiling: 2629744, text: "$days days ago" },
            { ceiling: 31556926, text: "$months months ago" },
            { ceiling: null, text: "$years years ago" }
        ],
        future: [
            { ceiling: 60, text: "in $seconds seconds" },
            { ceiling: 3600, text: "in $minutes minutes" },
            { ceiling: 86400, text: "in $hours hours" },
            { ceiling: 2629744, text: "in $days days" },
            { ceiling: 31556926, text: "in $months months" },
            { ceiling: null, text: "in $years years" }
        ]
    };
    //Time units must be be ordered largest -> smallest
    time_units = time_units || [
        [31556926, "years"],
        [2629744, "months"],
        [86400, "days"],
        [3600, "hours"],
        [60, "minutes"],
        [1, "seconds"]
    ];

    date = new Date(date);
    ref_date = ref_date ? new Date(ref_date) : new Date();
    var seconds_difference = (ref_date - date) / 1000;

    var tense = "past";
    if (seconds_difference < 0) {
        tense = "future";
        seconds_difference = 0 - seconds_difference;
    }

    function get_format() {
        for (var i = 0; i < date_formats[tense].length; i++) {
            if (date_formats[tense][i].ceiling == null || seconds_difference <= date_formats[tense][i].ceiling) {
                return date_formats[tense][i];
            }
        }
        return null;
    }

    function get_time_breakdown() {
        var seconds = seconds_difference;
        var breakdown = {};
        for (var i = 0; i < time_units.length; i++) {
            var occurences_of_unit = Math.floor(seconds / time_units[i][0]);
            seconds = seconds - (time_units[i][0] * occurences_of_unit);
            breakdown[time_units[i][1]] = occurences_of_unit;
        }
        return breakdown;
    }

    function render_date(date_format) {
        var breakdown = get_time_breakdown();
        var time_ago_text = date_format.text.replace(/\$(\w+)/g, function () {
            return breakdown[arguments[1]];
        });
        return depluralize_time_ago_text(time_ago_text, breakdown);
    }

    function depluralize_time_ago_text(time_ago_text, breakdown) {
        for (var i in breakdown) {
            if (breakdown[i] == 1) {
                var regexp = new RegExp("\\b" + i + "\\b");
                time_ago_text = time_ago_text.replace(regexp, function () {
                    return arguments[0].replace(/s\b/g, "");
                });
            }
        }
        return time_ago_text;
    }

    return render_date(get_format());
}