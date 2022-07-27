window.addEventListener("message", function(event) {
    const payload = event.data.payload

    if (event.data.action == "refresh") {
        //Refresh data items entity
        arraydatainteract = payload
    }else if(event.data.action == "update"){
        //Update View of items looking
        $(".target-label").html("");
        if (payload.active == true) {
            $(".target-eye").attr("src", "peek-active-1.png");
        }else{
            $(".target-eye").attr("src", "peek.png");
        }

        $.each(arraydatainteract, function (index1, item1) {
            $.each(payload.options, function (index2, item2) {
                if(index1 == index2 && item2 == true){
                    $(".target-label").append("<div id='target-"+index1+"'<li><span class='target-icon'><i class='fas fa-"+item1.icon+"'></i></span>&nbsp"+item1.label+"</li></div>");
                    $("#target-"+index1).hover((e)=> {
                        $("#target-"+index1).css("color",e.type === "mouseenter"?"#2D98DA":"white")
                    })
                    $("#target-"+index1+"").css("padding-top", "7px");
                    $("#target-"+index1).data('eventData', item1.event);
                    $("#target-"+index1).data('parametersData', item1.parameters);
                }
            })
        })
    }else if(event.data.action == "peek"){
        //Update eye event show or display
        if (payload.display == true) {
            $(".target-label").html("");
            $('.target-wrapper').show();
            $(".target-eye").attr("src", "peek.png");
        }else{
            $(".target-label").html("");
            $('.target-wrapper').hide();
        }

        if (payload.active == true) {
            $(".target-eye").attr("src", "peek-active-1.png");
        }else{
            $(".target-eye").attr("src", "peek.png");
            $(".target-label").html("");
        }
    }else if(event.data.action == "interact"){
        contextdata = payload.context
        entitydata = payload.entity
    }
});

$(document).on('mousedown', (event) => {
    let element = event.target;
    if (element.id.split("-")[0] === 'target') {
        let eventData = $("#"+element.id).data('eventData');
        let parametersData = $("#"+element.id).data('parametersData');
        $.post('https://np-eye/np-ui:targetSelectOption', JSON.stringify({
            entity : entitydata,
            option :{
                event: eventData,
                parameters: parametersData
            },
            context: contextdata,
        }));

        $(".target-label").html("");
        $('.target-wrapper').hide();
    }
});

$(document).on('keydown', function() {
    switch(event.keyCode) {
        case 27: // ESC
            $(".target-label").html("");
            $('.target-wrapper').hide();
            $.post('https://np-eye/closeTarget');
            break;
        case 18: // ALT
            $(".target-label").html("");
            $('.target-wrapper').hide();
            $.post('https://np-eye/closeTarget');
            break;
    }
});