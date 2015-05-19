<form class="ui form" method="post">
    <div class="inline field">
        <label>动物</label>
        <span>{{ pet.name }}</span>
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
    <div class="header">添加动物健康护理记录成功！</div>
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
            $("form").addClass("loading");
            $('form').ajaxSubmit({
                success : function(responseText, statusText) {
                    console.log(responseText);
                    if(responseText == "S") {
                        $(".ui.modal .content").text("已登记{{ pet.name }}于" + $("#happened_at").val() + "完成 " + $("#type :selected").text() + "护理项目");
                        $(".ui.modal").modal({
                            closable : false,
                            onApprove : function() {
                                window.location.href = "/admin/pet/index";
                            }
                        }).modal("show");
                    } else {
                        $("form").removeClass("loading");
                    }
                },
                resetForm : false
            });
        });
        
       $("#type").change(getProduct);
       
       // 根据当前的动物物种和选择的护理类型
       // 从服务器获取相应的产品目录
       function getProduct()
       {
           $.post('/admin/pet/get-product/', {
               species : "{{ pet.species }}",
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