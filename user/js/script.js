$(function(){
    nDate = new Date();
    tYear = nDate.getFullYear();

    tMonth = nDate.getMonth()+1;
    if ((tMonth + "").length < 2){ tMonth = "0" + tMonth; }
    
    tDay = nDate.getDate();
    if ((tDay + "").length < 2) { tDay = "0" + tDay; }

    fDate = tYear + "" + tMonth + "" + tDay;
    fDate = parseInt(fDate);

    $(".ctr_warp table tbody tr").click(function(){
        Click_row = $(this).children();
        CsDate = (Click_row.eq(2).text()).replace(/-/gi, "");
        CeDate = (Click_row.eq(3).text()).replace(/-/gi, "");

        if (CsDate > fDate) { alert("설문조사 기간이 아닙니다."); }
        else if (CeDate < fDate) { alert("설문조사 기간이 아닙니다."); }
        else { location.href='./sv_view.jsp?sv_no=' + Click_row.eq(0).text(); }
    });

    //======================================================================//
    // 페이지 로드시 모든 데이터 Name 값 추출 ( submit시 null값 체크하기 위함 ) //
    //======================================================================//
    var targetForm = $("#check_frm input[type=text], #check_frm textarea, #check_frm input[type=checkbox], #check_frm input[type=radio]");
 
    var check_name = [];

    $.each(targetForm, function(index, elem){
        if($.inArray($(this).attr("name"), check_name) == -1    )
        {
            check_name.push($(this).attr("name"));
        }
    });

    $("#check_frm").submit(function(){
        var checknull = 0;
        var nullfield = [];
        for (i=0; i<check_name.length; i++)
        {
            var sctype = check_name[i].split("_");
            console.log(sctype[0]);
            if (sctype[0] == "Textarea")
            {
                if ($("#check_frm textarea[name="+check_name[i]+"]").val() == "" || $("#check_frm textarea[name="+check_name[i]+"]").val() == null)
                {
                    nullfield.push(check_name[i]);
                    checknull++;
                }
            }
            else if (sctype[0] == "Check" || sctype[0] == "Radio")
            {
                if ($("#check_frm input[name="+check_name[i]+"]:checked").length == 0)
                {
                    nullfield.push(check_name[i]);
                    checknull++;
                }
            }
            else
            {
                if ($("#check_frm input[name="+check_name[i]+"]").val() == "" || $("#check_frm input[name="+check_name[i]+"]").val() == null)
                {
                    nullfield.push(check_name[i]);
                    checknull++;
                }
            }
        }

        if (checknull > 0){
            alert("응답하지 않은 항목이 존재합니다.\n\n모든 항목을 채워주시기 바랍니다.");
            console.log(nullfield);
            return false;
        }
        else
        {
            return true;
        }
    });
});