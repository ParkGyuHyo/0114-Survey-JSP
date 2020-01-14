$(function(){

    var time_arr = $("#time_out").text().split(":");
    var tminute = parseInt(time_arr[0]);
    var tseconds = parseInt(time_arr[1]);

    setInterval(function(){
        
        $("#time_out").text(tminute + ":" + tseconds);

        if (tseconds <= 0)
        {
            tminute--;
            tseconds = 59;
        }
        else
        {
            tseconds--;
        }

        if (tminute == 0 && tseconds == 0) location.href="./index.jsp";

    }, 1000);

    $("#rg_cancel").click(function(){
        $(".f_cover2").fadeOut(700);
        $(".rgbox").slideDown(700);
    });

    $("#rg_btn").click(function(){
        $(".f_cover2").fadeIn(700);
        $(".rgbox").slideDown(700);
    });

    $("#rg_submit").on("click", function(){
        var dep = true;
        var rg_frm = $(".rfrm input");
        $.each(rg_frm, function(index, elem)
        {
            if ($(this).val() == "")
            {
                var null_name;

                switch(index)
                {
                    case 0 : null_name = "아이디가"; break;
                    case 1 : null_name = "패스워드가"; break;
                    case 2 : null_name = "성명이"; break;
                    case 3 : null_name = "생년월일이"; break;
                    case 4 : null_name = "성별이"; break;
                }
                alert(null_name + " 입력되지 않았습니다.");
                $(this).focus();
                dep = false;
                return false;
            }
        });

        if (dep == false)
        {
            return false;
        }

        var post_data = {};
            post_data["user_id"] = $(".rfrm input[name=user_id").val();
            post_data["user_pwd"] = $(".rfrm input[name=user_pwd").val();
            post_data["user_name"] = $(".rfrm input[name=user_name").val();
            post_data["user_birth"] = $(".rfrm input[name=user_birth").val();
            post_data["user_gender"] = $(".rfrm input[name=user_gender").val();

        $.ajax({
            url: "./regi_user.jsp",
            type: "post",
            dataType: "json",
            data: post_data,
            success: function(data){
                if (data.result == "success")
                {
                    alert("회원가입이 완료되었습니다.");
                    $(".f_cover2").fadeOut(700);
                    $(".rgbox").slideDown(700);
                }
                else if (data.result == "overlap id")
                {
                    alert("중복된 아이디가 존재합니다.");
                    $(".rfrm input[name=user_id]").val("");
                    $(".rfrm input[name=user_id]").focus();
                }
            }
        });
    });

    $("#login_btn").on("click", function(){
        var login_url;
        var id_name;
        var pwd_name;
        var user_type;
        if ($(".lnbox p").text() == "관리자 로그인")
        {
            user_type = "adm";
        }
        else
        {
            user_type = "user"
        }

        login_url = "./" + user_type + "_loginchk.jsp";
        id_name = user_type + "_id";
        pwd_name = user_type + "_pwd";

        var post_data = {};
            post_data[""+id_name] = $("#" + user_type + "_id").val(),
            post_data[""+pwd_name] = $("#" + user_type + "_pwd").val()

        $.ajax({
            url: login_url,
            type: "post",
            dataType: "json",
            data: post_data,
            success: function(data){
                if (data.user_type == "user")
                {
                    if (data.login_result == "success")
                    {
                        location.href="./user/sv_list.jsp";
                    }
                    else if (data.login_result == "diffrent password")
                    {
                        alert("비밀번호가 틀렸습니다.");
                    }
                    else
                    {
                        alert("아이디를 찾을 수 없습니다.");
                    }
                }
                else
                {
                    if (data.login_result == "success")
                    {
                        location.href="./sv_list.jsp";
                    }
                    else if (data.login_result == "diffrent password")
                    {
                        alert("비밀번호가 틀렸습니다.");
                    }
                    else
                    {
                        alert("아이디를 찾을 수 없습니다.");
                    }
                }
            },
			error:function(xhr, status, error){
						alert(error);
			}
        });

    });

    $(".lmenu h3").click(function(){
		$(".lmenu ul ul").slideUp();
		if(!$(this).next().is(":visible"))
		{
			$(this).next().slideDown();
		}
    })
    
    $(".lmenu h2").click(function(){
        $(".lmenu").slideUp(1000);
    });

    $(".lmenu_btn h2").click(function(){
        $(".lmenu").slideDown(1000);
    });

    $("#sch_open_btn").click(function(){
        
        $("#schfrm").animate({
            width: "toggle",
            height: "toggle"
        }, 700);
    });

    $("#sch_open_btn").click(function(){
        $("#sch_open_btn").toggleClass("fa-search");
        $("#sch_open_btn").toggleClass("fa-times");
    });

    $("#del_btn").click(function(){
        $("input[name=sv_lst_chk]:checked").each(function(){
            
        });
    });

    $("#ins_btn").on("click", function(){
        $("#sv_cover").fadeIn(400);
    });

    $(document).on("focus", "#sub_section table td input", function(){
        $("#sub_section").css("border", "1px solid rgb(57, 163, 177)");
    });

    $(document).on("blur", "#sub_section table td input", function(){
        $("#sub_section").css("border", "1px solid #e2e2e2");
    });

});