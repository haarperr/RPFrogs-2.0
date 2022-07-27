$(document).ready(function () {
    window.addEventListener("message", function (event) {
        if (event.data.action == "open") {
            $("#rank").text(event.data.rank);
            $("#name").text(event.data.name);
            $("#callsign").text(event.data.callsign);

            if (event.data.img == "0") {
                $("#pic").attr("src", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg");
            } else {
                $("#pic").attr("src", event.data.img);
            }

            let background = 'url("images/police.png")'
            switch (event.data.job) {
                case "police":
                    background = 'url("images/police.png")'
                    break;
                case "sheriff":
                    background = 'url("images/sheriff.png")'
                    break;
                case "park_ranger":
                    background = 'url("images/park_ranger.png")'
                    break;
                case "state_police":
                    background = 'url("images/state_police.png")'
                    break;
            }

            $("#badge").css("background", background);

            $("#badge").show();
        } else if (event.data.action == "close") {
            $("#badge").hide();
        }
    });

    // $("#rank").text("Deputy Sheriff Bonus II");
    // $("#name").text("Dummer Dummy");
    // $("#callsign").text("000");
    // $("#pic").attr("src", "https://upload.wikimedia.org/wikipedia/commons/thumb/b/bc/Unknown_person.jpg/434px-Unknown_person.jpg");
    // $("#badge").css("background", 'url("images/police.png")');

    // $("#badge").show();
});