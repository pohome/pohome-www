<!DOCTYPE html>
<html>
    <head>
        <style>
            @media print {
                body {
                    margin: 0;
                }
                
                .page {
                    margin: 1.5cm;
                    page-break-after: always;
                }
            }
            
            @media screen {
                body {
                    margin: 57pt;
                    font-size: 10pt;
                    width: 800px;
                }
            }
            
            h1 {
                font-family: "FZFYSJW--GB1-0";
                font-size: 14pt;
                font-weight: normal;
                text-align: center;
                margin-bottom: 2em;
            }
            
            h2 {
                font-family: "FZS3JW--GB1-0";
                font-size: 12pt;
                font-weight: normal;
                border-bottom: 1px black solid;
                display: inline-block;
                margin-top: 0;
                margin-bottom: 0;
            }
            
            p {
                font-size: 10pt;
                font-family: "FZSYJW--GB1-0";
                line-height: 15pt;
            }
            
            .bold {
                font-family: "FZXBSJW--GB1-0";
            }
            
            #agreement_id {
                font-family: "FZXBSJW--GB1-0";
                background-color: #222;
                color: #fff;
                text-align: right;
                position: absolute;
                left: 1.5cm;
                top: 0.3cm;
                font-size: 10pt;
                padding: 3pt;
            }
            
            .agreement_sign {
                font-family: "FZXBSJW--GB1-0";
                font-size: 10pt;
                line-height: 15pt;
                margin-top: 4em;
            }
            
            .signature {
                width: 40%;
                float: left;
                font-size: 10pt;
                font-family: "FZSYJW--GB1-0";
                border-top: 1px black solid;
                margin-right: 10%;
                margin-top: 30pt;
                padding-top: 4pt;
                text-align: right;
            }
            
            .date_whitespace {
                display: inline-block;
                width: 6em;
                border-bottom: 1px black solid;
            }
            
            #avatar {
                width: 80%;
                vertical-align: middle;
            }
                        
            #avatar_cell {
                width: 18%;
            }
                        
            table {
                width: 100%;
                margin-bottom: 18pt;
                line-height: 18pt;
                vertical-align: middle;
                border: 1px #999 solid;
                border-collapse:collapse;
                border-spacing:0;
                font-size: 9pt;
                font-family: "FZSYJW--GB1-0";
            }
            
            td {
                border: 1px #999 solid;
                text-align: center
            }
            
            td.field {
                width: 80pt;
            }
            
            td.field_value {
                width: 160pt;
            }
            
            #notice {
                height: 100pt;
            }
            
            #medical_record {
                height: 100pt;
            }
            
            thead tr td {
                background-color: #eee;
            }
        </style>
    </head>
    <body>
        <div class="page">
            <div id="agreement_id">#{{ pal.agreement_id }}</div>
            <h1>汪汪喵呜孤儿院领养协议</h1>
            <p><span class="bold">提示：</span><span>我们编制领养协议的初衷只有一个——保护那些我们曾经用心照顾过的伴侣动物。如果您对于协议有任何疑问，请及时与我们沟通。谢谢您的合作。</span>
            </p>
            
            <table id='pet_info'>
                <thead>
                    <tr><td colspan="5">基本信息</td></tr>
                </thead>
                <tbody>
                    <tr>
                        <td rowspan="3" id="avatar_cell"><img id='avatar' src="/upload/image/512/{{ pet.id }}.jpeg" /></td>
                        <td class="field">姓名</td>
                        <td class="field_value">{{ pet.name }}</td>
                        <td class="field">性别</td>
                        <td class="field_value">{{ pet.getGender() }}</td>
                    </tr>
                    <tr>
                        <td class="field">年龄</td>
                        <td class="field_value">{{ pet.getAge() }}</td>
                        <td class="field">物种</td>
                        <td class="field_value">{{ pet.getSpecies() }}</td>
                    </tr>
                    <tr>
                        <td class="field">免疫时间</td>
                        <td class="field_value"></td>
                        <td class="field">已绝育</td>
                        <td class="field_value">{% if pet.extra.neutered == 1 %}是{% else %}否{% endif %}</td>
                    </tr>
                </tbody>
                <thead>
                    <tr><td colspan="5">领养需知</td></tr>
                </thead>
                <tbody>
                    <tr><td colspan="5" id="notice">{{ pet.notice }}</td></tr>
                </tbody>
                <thead>
                    <tr><td colspan="5">已知疾病史</td></tr>
                </thead>
                <tbody>
                    <tr><td colspan="5" id="medical_record"></td></tr>
                </tbody>
            </table>
            
            <table>
                <thead><tr><td colspan="4">领养人信息</td></tr></thead>
                <tbody>
                    <tr>
                        <td class="field">姓名</td>
                        <td></td>
                        <td class="field">性别</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field">证件类型</td>
                        <td></td>
                        <td class="field">证件编码</td>
                        <td></td>
                    </tr>
                </tbody>
                <thead><tr><td colspan="4">家庭住址 & 单位信息</td></tr></thead>
                <tbody>
                    <tr>
                        <td class="field" rowspan="2">家庭住址</td>
                        <td rowspan="2"></td>
                        <td class="field">邮编</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>电话</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field">单位名称</td>
                        <td></td>
                        <td class="field">单位电话</td>
                        <td></td>
                    </tr>
                </tbody>
                <thead><tr><td colspan="4">联系方式</td></tr></thead>
                <tbody>
                    <tr>
                        <td class="field">手机</td>
                        <td></td>
                        <td class="field">Email</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field">QQ</td>
                        <td></td>
                        <td class="field">微博</td>
                        <td></td>
                    </tr>
                    <tr>
                        <td class="field">紧急联系人</td>
                        <td></td>
                        <td class="field">联系方式</td>
                        <td></td>
                    </tr>
                </tbody>
            </table>
        </div>
        
        <div class="page">
            <h2>家庭关爱</h2>
            <p>领养人将对这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}未来的幸福承担全部责任。领养人同意给予这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}良好的照顾，<span class="bold">包括为它提供充足、健康的食物，干净的饮用水，基础的医疗护理和美容修饰，干净、安全的室内居所，以及这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}应得的细心呵护与关爱。</span></p>
            <h2>居住-运输</h2>
            <p>领养人承诺将这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}作为家庭的成员养于室内。严禁将它养于阴暗、肮脏的环境中（例如地下室{% if pet.species == 'D' %}、无人看管的狗屋{% endif %}），或是其它不具备防寒避暑条件的户外建筑。<span class="bold">{% if pet.species == 'D' %}领养人不得将狗狗长期栓于户外。当处于没有围栏的室外场所时，严禁以任何理由不给狗狗栓牵引绳。{% else %}领养人携带猫咪外出时，必须将猫咪装于猫包或航空箱内，抵达目的地后，在封闭的场所中才可将猫咪放出。{% endif %}当领养人不在家时可以将{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}关于宠物用笼子或航空箱中，但每天在无人陪伴的情况下被关于笼子或航空箱内的时间不得超过8小时。{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}不得在无人看管的情况下，被独自留于封闭的汽车内。</span></p>
            <h2>医疗照顾</h2>
            <p>在{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}被领养后，领养人对其身体健康承担全部责任。<span class="bold">领养人可在领养后的几周内带{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}去动物医院对其健康状况进行检查，并购买体内外驱虫药。{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}将在未来的生活种，始终得到职业动物医师的良好照顾，包括每年进行体检和狂犬病疫苗、免疫疫苗的注射。领养人在动物患病或受伤后须及时为它安排动物医师进行治疗。</span>领养人需告知汪汪喵呜孤儿院相关负责人员接诊的动物医师的姓名和电话，以便于我们确认动物确实接受了必须的治疗。</p>
            {% if pet.species == 'D' %}<h2>犬证</h2>
            <p><span class="bold">领养人需按照《北京市养犬管理规定》为狗狗办理养犬登记，并每年定期办理年检。</span>在每年全市检查犬证期间，领养人带狗狗外出必须随身携带犬证。</p>{% endif %}
            <h2>绝育</h2>
            <p><span class="bold">这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的生育将被绝对禁止。</span>如果该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}被领养时还不适合接受绝育手术，领养人需同意在它身体条件符合要求时带其去动物医院完成绝育手术，并将绝育证明的复印件邮寄给汪汪喵呜孤儿院。</p>
            <h2>{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的行为和健康</h2>
            <p>领养人充分理解没有人能够完全预知一只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}对于新的环境会产生的反应。因此，领养人需在该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}完全适应新环境并且慢慢熟悉了该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的独特性格前采取谨慎小心的态度。领养人对这只{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的行为——包括它对人或物品造成的伤害——负有全部责任。汪汪喵呜孤儿院对该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的健康和脾气/性格不做任何显性或隐性的保证。汪汪喵呜孤儿院承诺{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}被领养时的状态做出如实陈述，因为未来可能发生改变，汪汪喵呜孤儿院无法对任何动物的健康做出担保，也不对未来可能产生的任何治疗费用负责。</p>
            <h2>其它用途</h2>
            <p>该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}不得被用于祭祀、竞速、打斗、医疗或实验用途。<span class="bold">它是且仅是一只家养宠物、伴侣动物和家庭成员。</span></p>
            <h2>转移所有权</h2>
            <p>该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的所有权和相关责任属于且仅属于领养人。然而如果领养人无法继续拥有它或为它提供良好的照顾，包括食物、居所或医疗保障，领养人应和汪汪喵呜孤儿院联系，给予救助人为该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}寻找一个新家的机会。未得到汪汪喵呜孤儿院的许可，领养人不可将该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}出售、转让或转由他人领养，也不许将其所有权转交给任何企业、公司和流浪动物组织，如救助机构或动物收容所。领养人应给予汪汪喵呜孤儿院充足的时间来为{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}安排一个合适的新家。同时，领养人应告知汪汪喵呜孤儿院是否存在行为或健康上的问题，以至于很难为其寻找到另一个新家。如果领养人必须将{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}退回汪汪喵呜孤儿院，领养人应承担运输的责任。</p>
        </div>
        <div class="page">
            <h2>回访</h2>
            <p>领养人充分理解汪汪喵呜孤儿院可能在未来会对该{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的生活状况进行回访。领养人应充分配合汪汪喵呜孤儿院，提供一切汪汪喵呜孤儿院需要了解的信息，并允许汪汪喵呜孤儿院进行家访或与动物医生取得联系。<span class="bold">如果家庭住址、电子邮件地址或电话号码发生变化，领养人应及时告知汪汪喵呜孤儿院，以保证在{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的一生汪汪喵呜孤儿院都可与领养人保持联系。</span>如果{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}走失，领养人应第一时间通知汪汪喵呜孤儿院。</p>
            <h2>收回</h2>
            <p>领养人理解在她/他无法遵守本协议之条款时，或领养人出现忽视或虐待{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}的情况时，汪汪喵呜孤儿院有权收回被领养的{% if pet.species == 'D' %}狗狗{% else %}猫咪{% endif %}。</p>
            
            <div class="agreement_sign">
                于<span class="date_whitespace"></span>年<span class="date_whitespace"></span>月<span class="date_whitespace"></span>日，我确认我已经完整阅读并且完全理解这份伴侣动物领养协议的相关条款，对于被领养动物的信息不存在任何疑问，并且保证领养人信息填写属实。
            </div>
            <div style="margin-top: 40pt;">
                <div class="signature">第一领养人签字</div>
                <div class="signature">第二领养人签字</div>
                <div class="signature">汪汪喵呜孤儿院代表签字</div>
            </div>
        </div>
    </body>
</html>