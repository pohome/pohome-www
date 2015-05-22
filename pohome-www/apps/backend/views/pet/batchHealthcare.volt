<form class="ui form" method="post">
    <div class="inline field">
        <label>位置</label>
        <select class="ui dropdown" name="location" id="filter_location">
            {% for location_id, location_name in location %}
            <option value="{{ location_id }}">{{ location_name }}</option>
            {% endfor %}
        </select>
    </div>
    <div class="inline field">
        <label>物种</label>
        <select class="ui dropdown" name="species" id="filter_species">
            <option value="D">狗狗</option>
            <option value="C">猫咪</option>
        </select>
    </div>
    <div class="ui orange button" id="filter_button">筛选</div>
    <div class="ui yellow button" id="select_all_button">全部选择</div>
    <div class="ui divider"></div>
    <div class="inline fields">
        <label>动物</label>
        <div style="width: 500px;display: inline-block;vertical-align: top" id="filtered_pets">
            {% for pet in pets %}
            <div class="field" style="margin-bottom: 1em">
                <div class="ui checkbox">
                    <input type="checkbox" name="selected_pets[]" value="{{ pet.id }}">
                    <label>{{ pet.name }}</label>
                </div>
            </div>
            {% endfor %}
        </div>
    </div>
    
    <div class="inline field">
        <label>护理类型</label>
        <select class="ui dropdown" name="type" id="type">
            <option value="疾病免疫">疾病免疫</option>
            <option value="狂犬免疫">狂犬免疫</option>
            <option value="体内驱虫">体内驱虫</option>
            <option value="体外驱虫">体外驱虫</option>
            <option value="洗澡">洗澡</option>
        </select>
    </div>
    
    <div class="inline field">
        <label>产品名</label>
        <select class="ui dropdown" name="product" id="product">
        </select>
    </div>
    
    <div class="inline field">
        <label>日期</label>
        <input type="text" name="happened_at" value="{{ today }}" placeholder="YYYY-MM-DD" id="happened_at" />
    </div>
    
    <div class="ui positive button" id="save_button">保存</div>
</form>

<div class="ui small modal">
    <div class="header">批量添加动物健康护理记录成功！</div>
    <div class="content"></div>
    <div class="actions">
        <div class="ui positive button">确定</div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {
        // 页面载入完成后自动获取当前默认
        // 选择的疾病免疫护理对应的产品名录
        getProduct();
        
        $("#save_button").click(function() {
            $("#save_button").addClass("loading");
            $('form').ajaxSubmit({
                success : function(responseText, statusText) {
                    //console.log(responseText);
                    if(responseText == "F") {
                        $("#save_button").removeClass("loading");
                        
                    } else {
                        var result = $.parseJSON(responseText);
                        $(".ui.modal .content").text("已登记" + result['success'] + "只动物于" + $("#happened_at").val() + "完成" + $("#type :selected").text() + "护理项目");
                        $(".ui.modal").modal({
                            closable : false,
                            onApprove : function() {
                                window.location.href = "/admin/pet/index";
                            }
                        }).modal("show");
                    }
                },
                resetForm : false
            });
        });
        
        // 筛选
        $("#filter_button").click(function() {
            $("#filter_button").addClass("loading");
            $.post("/admin/pet/filter", {
                location : $("#filter_location :selected").val(),
                species : $("#filter_species :selected").val()
            }, function(data, status) {
                var pets = $.parseJSON(data);

                $("#filtered_pets").empty();
                for(var id in pets)
                {
                    var str = '<div class="field" style="margin-bottom: 1em"><div class="ui checkbox"><input type="checkbox" name="selected_pets[]" value="' + id + '"><label>' + pets[id] + '</label></div></div>';
                    $("#filtered_pets").append(str);
                }
                $("#filter_button").removeClass("loading");
                $(".ui.checkbox").checkbox();
                
                getProduct();
            });
        });
        
        // 选择全部动物
        $("#select_all_button").click(function() {
            $('#filtered_pets').find('input[type="checkbox"]').each(function() {
                $(this).prop('checked', true);
            })
        });
        
       $("#type").change(getProduct);
       
       // 根据当前的动物物种和选择的护理类型
       // 从服务器获取相应的产品目录
       function getProduct()
       {
           $.post('/admin/pet/get-product/', {
               species : $("#filter_species :selected").val(),
               type : $("#type :selected").val()
           }, function(data, status) {
               var products = $.parseJSON(data);
               var optionString = "";
               for(var i in products)
               {
                   optionString += '<option value="' + products[i] + '">' + products[i] + '</option>';
               }
               $("#product").html(optionString);
               console.log(products[0]);
               $("#product").dropdown("set selected", products[0]).dropdown("set text", products[0]);
           })
       }
    });
</script>