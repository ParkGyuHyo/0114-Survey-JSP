<div class="type_sel_frm">
    <input id="tab1" type="radio" name="tabs" checked>
    <label for="tab1">단답형</label>
    <input id="tab2" type="radio" name="tabs">
    <label for="tab2">장문형</label>
    <input id="tab3" type="radio" name="tabs">
    <label for="tab3">라디오박스</label>
    <input id="tab4" type="radio" name="tabs">
    <label for="tab4">체크박스</label>

    <section id="contents_1">
        <h3>단답형은 설정 없이 바로 사용 가능합니다.</h3>
        <input type="submit" id="text_submit" value="저 장" />
    </section>
    <section id="contents_2">
        <h3>장문형은 설정 없이 바로 사용 가능합니다.</h3>
        <input type="submit" id="textarea_submit" value="저 장" />
    </section>
    <section id="contents_3">
        <p>
            <span id="radi_no">1</span>. &nbsp;<input type="radio" name="radi_1" disabled>
            <input type="text" name="radi_val_1" size="30" />
        </p>
        <p>
            <span id="radi_no">2</span>. <input type="radio" name="radi_2" disabled>
            <input type="text"  name="radi_val_2" size="30" />
        </p>
        <p class="add_radi">+ 라디오박스를 추가합니다. (최대 5개)</p>
        <input type="submit" id="radi_submit" value="저 장" />
    </section>
    <section id="contents_4">
        <p>
            <span id="check_no">1</span>. &nbsp;<input type="checkbox" name="check_1" disabled>
            <input type="text" name="check_val_1" size="30" />
        </p>
        <p>
            <span id="check_no">2</span>. <input type="checkbox" name="check_2" disabled>
            <input type="text"  name="check_val_2" size="30" />
        </p>
        <p class="add_check">+ 체크박스를 추가합니다. (최대 5개)</p>
        <input type="submit" id="check_submit" value="저 장" />
    </section>
</div>