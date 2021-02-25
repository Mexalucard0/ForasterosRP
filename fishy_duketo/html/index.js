let seatbeltPressed = false

$(document).ready(function(){
    window.addEventListener("message", function(event){
        if (event.data.isonvehicle == true) {
            $("#hud").slideUp("slow");
            $("#hud-car").slideDown("slow");
        } else if (event.data.isonvehicle == false) {
            $("#hud").slideDown("slow");
            $("#hud-car").slideUp("slow");
        }

        if (event.data.displayhudcar == true){
            $('.car-hud').fadeIn();
        } else if (event.data.displayhudcar == false) {
            $('.car-hud').fadeOut();
        }


        switch (event.data.action) {
            case 'tick':
                $(".health-bar").css("width", event.data.health + "%");
                $(".shield-bar").css("width", event.data.armor + "%");
                $(".hunger-bar").css("width", event.data.hunger + '%');
                $(".water-bar").css("width", event.data.thirst + '%');
                $(".stress-bar").css("width", event.data.stress + '%');
                $('.rpm').html(event.data.rpm);
                $('.speed').html(event.data.velocidad);
                $('.fuel').html(event.data.gas);
                $('.streetfacheron').html(event.data.street1);

                if (event.data.health <= 25 && event.data.shield >= 0) {
                    $('.health-bar').css('background', 'red');
                }

                if (event.data.shield <= 25 && event.data.shield >= 0) {
                    $('.shield-bar').css('background', 'red');
                }

            break
            case 'info':
                $('.job').html(event.data.job);
                $('.cash').html('$' + event.data.wallet);
                $('.bank').html('$' + event.data.bank);
                $('.blackmoney').html(event.data.blackMoney);
            break
            case 'fishySlide':
                $('.player-info2').fadeIn();
                $('.player-info').fadeIn();
                setTimeout(() => {
                    $('.player-info2').fadeOut();
                    $('.player-info').fadeOut();
                }, 3000);
			break
        }

        if (event.data.seatbelt == true) {
            $('.cinturon').css('color', 'green');
        } else if (event.data.seatbelt == false) {
            $('.cinturon').css('color', 'red');
        } 

    });
});

