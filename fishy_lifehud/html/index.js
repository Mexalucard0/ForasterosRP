window.addEventListener('message', function (event) {
    if (event.data.action == "updateStatus") {
        updateStatus(event.data.st);
    }
    switch (event.data.action) {
        case 'tick':
            if (event.data.show) {
                $('.container2').fadeOut();
            } else {
                $('.container2').fadeIn();
            }
            if (event.data.armor >= 5){
                $(".shield-c").fadeIn();
            } else {
                $(".shield-c").fadeOut();
            }
            $(".health-b").css("width", event.data.health + "%");
            $(".shield-b").css("width", event.data.armor + "%");
        break
        case 'Status':
            $(".hunger-b").css("width", event.data.hunger + '%');
            $(".thirst-b").css("width", event.data.thirst + '%');
            $(".stress-b").css("width", event.data.stress + '%');
            $(".stamina-b").css("width", event.data.stamina + '%');
            if (event.data.stamina >= 100) {
                $('.stamina-c').fadeOut();
            } else {
                $('.stamina-c').fadeIn();
            }
            if (event.data.stress >= 20) {
                $('.stress-c').fadeIn();
            } else {
                $('.stress-c').fadeOut();
            }
        break
    }
})
