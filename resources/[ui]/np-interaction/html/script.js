window.addEventListener("message", function(event){
    var data = event.data

    if (data.display) {
        let text = data.text

        text = text.replace(/[\[']+/g, `<span class="strokeme">[`);
        text = text.replace(/[\]']+/g, `]</span>`);

        $("#interaction-text").html(text);
        $("#interaction-text").css("background-color", data.color);

        LeftSlideRight("#interaction-text", 700, "0.5");
    } else {
        RightSlideLeft("#interaction-text", 700, "-20");
    }
})

function LeftSlideRight(Object, Timeout, Percentage) {
    $(Object).css("display", "inline-block").animate({
        left: Percentage + "%",
    }, Timeout);
}

function RightSlideLeft(Object, Timeout, Percentage) {
    $(Object).css("display", "inline-block").animate({
        left: Percentage + "%",
    }, Timeout, function(){
        $(Object).css("display", "none");
        $("#interaction-text").html("");
    });
}
