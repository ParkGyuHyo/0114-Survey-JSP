$(function(){
    
    const sv_row_top_begin_val = $("#sub_section").html();
    const sv_row_con_begin_val = $(".sv_content").html();
    const sv_type_sel_begin_val = $(".type_sel_frm").html();

    $("#pop_close_btn").click(function(){
        $("#sv_cover").fadeOut(400);
        $(".sv_content").html(sv_row_con_begin_val);
        $("#sub_section").html(sv_row_top_begin_val);
        row_type_config.clear();
        row_getParameter = new Array();
        $(".type_sel_frm").html(sv_type_sel_begin_val);
        save_row = true;
    });
    
    let save_row = true;
    let sv_top_save = false;
    var s_in_result = false;
    let view_survey_index = 0;
    let view_child_index = 0;

    function save_sv_top(){
        var fdata = $("#sv_top_frm").serialize();

        var dresult;

        $.ajax({
            url: "./sv_top_insert.jsp",
            type: "post",
            async: false,
            dataType: "json",
            data: fdata,
            success: function(data){
                if(data.result == "success")
                    {
                        view_survey_index = data.idx;
                        dresult = true;
                    }
                else
                    {
                        dresult = false;
                    }
            }
        });


        return dresult;

    }

	$("#add_row").on("click", function(){
        
        if ($("#sub_section input[name=sv_top_subject]").val() == ""){
            alert("제목을 입력하세요.");
            $("#sub_section input[name=sv_top_subject]").focus();
            return;
        }
        
        if ($("#sub_section input[name=sv_top_start_date]").val() == ""){
            alert("시작일을 입력하세요.");
            $("#sub_section input[name=sv_top_start_date]").focus();
            return;
        }
        
        if ($("#sub_section input[name=sv_top_end_date]").val() == ""){
            alert("종료일을 입력하세요.");
            $("#sub_section input[name=sv_top_end_date]").focus();
            return;
        }

        if (save_sv_top() == false) return;

        sv_top_save = true;
        
        if (save_row == false){
            alert("기존 항목을 저장 후 추가할 수 있습니다.");
            return;
        }

		var n_cnt = $("#sv_table tr").length;
        
        var add_row = ''+
        '<tr name="row_'+(n_cnt)+'">'+
         '   <td><input type="checkbox" name="sv_chk" value="chk'+(n_cnt)+'"/></td>'+
         '   <td>'+(n_cnt)+'</td>'+
         '   <td><input type="text" name="sv_subject" /></td>'+
         '   <td><p class="sv_type_pop" id="sel_type_'+(n_cnt)+'">[선 택]</p></td>'+
         '   <td><input type="text" size="2" name="sv_move" /></td>'+
         '   <td><input type="button" value="저 장" id="rows_save" name="sv_row_'+(n_cnt)+'"></td>'+
        '</tr>'+
        '';

        view_child_index = n_cnt;

		$("#sv_table").append(add_row);
        save_row = false;

		//$("#sv_table").append($("#sv_template").html());

    });
    
    var sel_row_id;
    
    $(document).on("click", ".sv_type_pop", function(){
        $(".type_sel_cover").slideDown();
        sel_row_id = $(this).attr("id");
    });
    
    let stype, scnt;

    let row_getParameter = new Array();
    
    function rows_type(r_type, r_cnt){
        stype = r_type;
        scnt = r_cnt;
    }

    $(document).on("click", "#rows_save", function(){

        let scsub = $("#sv_table tr[name=row_" + view_child_index + "] td input[name=sv_subject]").val();
        let sctype = stype;
        let sctcnt = scnt;
        let type_val = new Array();
        for (var i = 0; i <= 5; i++){
            type_val[i] = row_getParameter[i];
        }
        let postData = {
            sv_no:view_survey_index,
            sc_no:view_child_index,
            sc_subject:scsub,
            sc_type:sctype,
            sc_tcnt:sctcnt,
            sc_tval_1:type_val[0],
            sc_tval_2:type_val[1],
            sc_tval_3:type_val[2],
            sc_tval_4:type_val[3],
            sc_tval_5:type_val[4]
        };

		$.ajax({
            url: "./sv_child_insert.jsp",
            type: "post",
            dataType: "json",
            data: postData,
            success: function(data){
                alert(data);
            }
        });
        row_getParameter = new Array();
        $(".type_sel_frm").html(sv_type_sel_begin_val);
        save_row = true;
    });
    
    $(document).on("click", "#radi_submit, #check_submit, #text_submit, #textarea_submit", function(){
        let type_cnt;
        if ($(this).attr("id") == "radi_submit"){
            type_cnt = $("#contents_3 input[type=radio]").length;
            for(i=1; i<=type_cnt; i++){
                row_getParameter.push($("#contents_3 input[name=radi_val_"+i+"]").val());   
            }
            rows_type("radio", type_cnt);
            $("#" + sel_row_id).html("라디오박스("+type_cnt+")<br/>[변 경]");
        }
        else if($(this).attr("id") == "check_submit")
        {
            type_cnt = $("#contents_4 input[type=checkbox]").length;
            for(i=1; i<=type_cnt; i++){
                row_getParameter.push($("#contents_4 input[name=check_val_"+i+"]").val());   
            }
            rows_type("check", type_cnt);
            $("#" + sel_row_id).html("체크박스("+type_cnt+")<br/>[변 경]");
        }
        else if($(this).attr("id") == "text_submit")
        {
            $("#" + sel_row_id).html("단답형<br/>[변 경]");
            stype = "text";
        }
        else
        {
            $("#" + sel_row_id).html("장문형<br/>[변 경]");
            stype = "textarea";
        }
        $(".type_sel_cover").slideUp();
    });
    
    $(document).on("click", ".add_radi, .add_check", function(){
        var type_cnt;
        var rc_type;
        var rc_type2;
        if ($(this).attr("class") == "add_radi"){
            rc_type = "radi";
            rc_type2 = "radio";
            type_cnt = $("#contents_3 input[type=radio]").length;
        }
        else
        {
            rc_type = "check";
            rc_type2 = "checkbox";
            type_cnt = $("#contents_4 input[type=checkbox]").length;  
        }
        
        var add_data =  '<p>' +
                        '<i class="fas fa-minus-circle" id="del_'+rc_type+'"></i>' +
                        '     <span id="'+rc_type+'">'+(type_cnt+1)+'</span>. <input type="'+rc_type2+'" name="'+rc_type+'_'+(type_cnt+1)+'" disabled>' +
                        '   <input type="text"  name="'+rc_type+'_val_'+(type_cnt+1)+'" size="30" />' +
                        '</p>';
        
        $(this).before(add_data);
        if((type_cnt+1) >= 5)
            $(this).css("display", "none");            
    });
    
    $(document).on("click", "#del_radi, #del_check", function(){
       $(this).parent().remove(); 
        var type_cnt;
        var rc_type;
        var rc_type2;
        var c_name;
        if ($(this).attr("id") == "del_radi"){
            rc_type = "radi";
            rc_type2 = "radio";
            c_name = "#contents_3";
            type_cnt = $("#contents_3 input[type=radio]").length;
        }
        else
        {
            rc_type = "check";
            rc_type2 = "checkbox";
            c_name = "#contents_4";
            type_cnt = $("#contents_4 input[type=checkbox]").length;  
        }
        for(i=2; i<type_cnt; i++){
            $(c_name+" p:eq("+(i)+") span").text((i+1));
            $(c_name+" p:eq("+(i)+") input[type="+rc_type2+"]").attr("name", rc_type+"_"+(i+1));
            $(c_name+" p:eq("+(i)+") input[type=text]").attr("name", rc_type+"_val_"+(i+1));
        }
        if((type_cnt) < 5)
            $(".add_"+rc_type).css("display", "block");
    });
    
});