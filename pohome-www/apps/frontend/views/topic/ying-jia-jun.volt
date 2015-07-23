<div id="carousel">
    <div id="carousel_canvas" style="background-image: url(/image/yingjiajun/yingjiajun.jpg);"></div>
</div>
<div class="wrap">
    <div class="quote" style="width: 600px; margin: auto;padding: 20px; color: #fff; background-color: rgba(120, 0, 120, 0.5); position: relative; z-index: 5;display: none;">
        <p style="line-height: 150%;">曾经我也有家，一个幸福快乐的家。爸爸妈妈都跟我玩儿，妈妈有时候还会亲自下厨给我做好吃的。后来，妈妈越来越胖，原来，她要生小宝宝啦，好开心，爸爸妈妈这么照顾我，我要好好照顾小宝宝报答爸爸妈妈。</p>
        <p style="line-height: 150%;">有一天爸爸妈妈找来好多人，把家里东西都搬出来，原来我们要搬家了，好开心呀，看着最后一样东西都装好，大家都上车了，我也开心地跑过去，可是我被绳子拽了回来。爸爸妈妈，你们忘了我了！任凭我怎么喊，他们也听不到……</p>
    </div>
    <div class="yingjiajun list">
        <?php $pet_count = 0; $row = -1; $col = 0; ?>
        {% for pet in pets %}
        <?php $col = $pet_count % 7; if($col == 0) {$row++;}; ?>
        <div class="avatar" style="position: absolute; top: {{ row * 140 }}px; left: {{ col * 140 }}px">
            <a href="/pet/{{pet.id}}" target="_blank">
                <div><img src="/upload/image/512/{{ pet.id }}.jpeg" {% if pet.status_id == 7 or pet.status_id == 8 %}style="filter: grayscale(1);-webkit-filter: grayscale(1);-moz-filter:grayscale(1);-ms-filter: grayscale(100%);filter: url(/image/gray.svg#grayscale);filter: gray;"{% endif %}></div>
                <div class="pet_info">
                    <div style="font-size: 1.2em; margin-bottom: 1em;">{{ pet.name }}</div>
                    <div><span>{{ pet.getAge() }}</span><span> {{ pet.getStatus() }}</span></div>
                </div>
            </a>
        </div>
        <?php if($pet_count == 15) {$pet_count +=4;} elseif($pet_count == 22) {$pet_count += 4;} else {$pet_count++;} ?>
        {% endfor %}
        
        <div class="ruin">
            <div style="background-color: rgba(20, 20, 20, 0.7);width: 100%;height: 100%;padding: 20px;color: rgba(240,240,240,0.9);position: relative; z-index: 10;">
                <p>2010年7月，为了实施北京南城发展计划，大兴区瀛海镇进行了大规模拆迁，拆迁范围涉及22个村，6700户村民，所有拆迁工作将于8月6日结束。据调查显示有近九成拆迁户将遗弃猫狗，目前村民正在大批搬离，大量曾经的伴侣动物被遗留在废墟上，猫狗贩子们已在该地开始抓捕并且四处张贴收购信息。等待着它们的将是大棒和屠刀，对于该地遗留的伴侣动物的救助已经刻不容缓！</p>
                <p>汪汪喵呜孤儿院与北京爱它动物保护公益基金会的前身——中国保护动物记者沙龙、国际爱护动物基金会（IFAW）、瑞家志愿者团队及媒体朋友们共同发起了“带我去新家”集体救助活动，救助并收容了来自瀛海镇的22只大中小型犬，治疗、照顾它们并坚持为它们找家直到今天。</p>
            </div>
        </div>
        <div style="clear: both"></div>
    </div>
    <div style="clear: both"></div>

    <div class="ui grid" style="margin-top: 40px; margin-bottom: 40px">
        <div class="ten wide column" id="main_article">
            <h1>我想有个家</h1>
            <p>曾经我也有家，一个幸福快乐的家。爸爸妈妈都跟我玩儿，妈妈有时候还会亲自下厨给我做好吃的。后来，妈妈越来越胖，原来，她要生小宝宝啦，好开心，爸爸妈妈这么照顾我，我要好好照顾小宝宝报答爸爸妈妈。</p>
            <p>有一天爸爸妈妈找来好多人，把家里东西都搬出来，原来我们要搬家了，好开心呀，看着最后一样东西都装好，大家都上车了，我也开心地跑过去，可是我被绳子拽了回来。爸爸妈妈，你们忘了我了！任凭我怎么喊，他们也听不到。没关系，一会到了新家发现我不在身边就该着急了吧？没事，我不怪你们，我等着你们。天都黑了还没有人接我，我听到肚子咕咕叫，饭盆里空空的。没事，再等等吧，天亮了，又黑了，又亮了…我想去找点水喝，找口吃的，可是绳子拴着我走不了。下起大雨了，我太冷了，也太饿了，我费了好大力气终于挣开了绳索。我找不到吃的，就在洼地里喝了些雨水。不行，我还是去找点吃的吧，我漫无目的地走着，突然看到一个塑料袋里有半根油条，我冲过去狼吞虎咽地吃掉了。这简直是我吃过最美味的油条，吃完油条我赶紧回家门口等着…这天来了好多人来拆房子，他们怎么可以把我家拆了？那爸爸妈妈回来住哪儿？我去阻拦他们，结果被重重地踢到一边，我觉得身上剧烈得疼痛然后就晕倒了。等我迷迷糊糊醒来，房子正被拆毁，我想跑，但是腿疼得站不起来，眼睁睁看着倒塌的房屋压过来…不知道多久我醒过来，天已经黑了，我浑身疼，但是我得去告诉爸爸妈妈这里太危险，不能过来，于是我咬紧牙关一点一点挪出来，一点一点爬着走，希望能尽快给爸爸妈妈报告这个消息。</p>
            <p>我不知道过了多少个天明又天黑、不知道走了多久多远，我依然没有找到爸爸妈妈，有时候，好心的叔叔阿姨哥哥姐姐爷爷奶奶会给我点吃的，有时候我就捡垃圾吃，还有的时候我不得不饿肚子。虽然有人会同情可怜我给我食物，但是也有人讨厌我驱赶我打我骂我，我依然没有放弃…</p>
            <p>我太累了，就睡着了，突然感到有人在抱我，我一看，啊，是妈妈！我好开心，接着爸爸过来给我放在温暖的窝里，对我温柔地说，睡醒了给你做好吃的。我一听好吃的马上从窝里蹦起来，想告诉爸爸我现在就要吃，我好饿！</p>
            <p>“哎哟！”我的头撞在了硬硬的石头墙上，我的爸爸我的妈妈我温暖的小窝都不见了，我还睡在外面，原来，我做了一个梦…</p>
            <div style="text-align: right"><img src="/image/yingjiajun/wenyan.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">文燕</div></div>
        </div>
        <div class="six wide column">
            <h3>特约撰稿</h3>
            <div style="border-left: 8px #ffef00 solid; padding: 5px 0 5px 14px; margin-bottom: 14px;">
                <img src="/image/yingjiajun/yinming.jpg" style="width: 60px; border-radius: 60px;float: left;display: block;">
                <div style="float: left; width: 240px; margin-left: 14px;">
                    <div style="font-weight: bold">隐明</div>
                    <div>遥想当初加入汪汪喵呜孤儿院，一群年轻的人和笑脸，乐观和坦荡，勇敢和善良。大家互相鼓励，抱团作战...</div>
                    <div class="readmore" onclick="$('#yinming_modal').modal('show')">阅读全文</div>
                </div>
                <div style="clear: both;"></div>
            </div>
            
            <div style="border-left: 8px #ffacb0 solid; padding: 5px 0 5px 14px; margin-bottom: 14px;">
                <img src="/image/yingjiajun/linxiaomao.jpg" style="width: 60px; border-radius: 60px;float: left;display: block;">
                <div style="float: left; width: 240px; margin-left: 14px;">
                    <div style="font-weight: bold">林小猫</div>
                    <div>汪汪喵呜孤儿院的客服组,经常会遇到这样的质疑: 你们不是救助组织吗,为什么不能收我捡的小狗。每每听到...</div>
                    <div class="readmore" onclick="$('#linxiaomao_modal').modal('show')">阅读全文</div>
                </div>
                <div style="clear: both;"></div>
            </div>
            
            <div style="border-left: 8px #96e45f solid; padding: 5px 0 5px 14px; margin-bottom: 14px;">
                <img src="/image/yingjiajun/xiaoxiao.jpg" style="width: 60px; border-radius: 60px;float: left;display: block;">
                <div style="float: left; width: 240px; margin-left: 14px;">
                    <div style="font-weight: bold">笑笑</div>
                    <div>任职模拟家庭管理员之后，我就听说了，这里有个和我拥有一个名字的小家伙。两个星期之后我第一次到小院...</div>
                    <div class="readmore" onclick="$('#xiaoxiao_modal').modal('show')">阅读全文</div>
                </div>
                <div style="clear: both;"></div>
            </div>
            
            <div style="border-left: 8px #81cef2 solid; padding: 5px 0 5px 14px; margin-bottom: 14px;">
                <img src="/image/yingjiajun/maodouma.jpg" style="width: 60px; border-radius: 60px;float: left;display: block;">
                <div style="float: left; width: 240px; margin-left: 14px;">
                    <div style="font-weight: bold">毛豆妈</div>
                    <div>作为一个从未参加过任何活动的菜鸟志愿者，鬼使神差，从微博上报名去了小院，参加活动，刚开始只是好奇...</div>
                    <div class="readmore" onclick="$('#maodouma_modal').modal('show')">阅读全文</div>
                </div>
                <div style="clear: both;"></div>
            </div>
            
            <div style="border-left: 8px #c391be solid; padding: 5px 0 5px 14px; margin-bottom: 14px;">
                <img src="/image/yingjiajun/vivien.jpg" style="width: 60px; border-radius: 60px;float: left;display: block;">
                <div style="float: left; width: 240px; margin-left: 14px;">
                    <div style="font-weight: bold">Vivien</div>
                    <div>瀛大海，来自北京大兴瀛海镇的拆迁村。2010年7月，为了实施北京南城发展计划...</div>
                    <div class="readmore" onclick="$('#vivien_modal').modal('show')">阅读全文</div>
                </div>
                <div style="clear: both;"></div>
            </div>
        </div>
    </div>
    
    <h1>五年光阴的印象</h1>
    <div id="waterfall">
    </div>
</div>

<div class="ui long modal" id="yinming_modal">
    <div class="header">写在遇见瀛大米&瀛小米的第五年</div>
    <div class="content">
        <p>五年，似乎很长的时间，很快就过来了。</p>
        <p>遥想当初加入汪汪喵呜孤儿院，一群年轻的人和笑脸，乐观和坦荡，勇敢和善良。大家互相鼓励，抱团作战，一次一次的救助，一次一次的攻克难关。五年过去了，我们变成了“资深年轻人”，每个人的人生都经历着变化，自觉不自觉的磨砺下，善良和勇敢都有了“包浆”，变得更坚毅和有担当。</p>
        <p>五年，能让一只小狗变成什么样子？遥想当年的一次救助，大兴瀛海镇拆迁，搬走的人们出于各种原因，将不愿意继续养下去的狗狗们留在了拆迁现场。我们组织参与了这次集中救助行动，接回小院的一共22个小家伙，被我们称为“瀛家军”。其中，两个黑色小肉球，就是瀛大米和瀛小米小朋友。当时它们刚刚两个月左右大小，不知道是不是流浪狗后代，但是非常亲人，见到我们巨热情，爱尖叫，离老远就已经激动的跳起来，还像橄榄球运动员一样互相“卡位”，阻挡我们的手落在别的小狗身上。当时小院新址刚刚租下来不久，建设还不完善，至今都能想到，两个小黑球儿一打滚带起来的暴土烟儿，以及抱着我们的腿之后留下的土印儿。唯一的特点就是，他们虽然亲人，但是不喜欢被抱，我们想，也许这就是流浪犬后代的特点：不习惯亲近到这个程度。</p>
        <p>缘分从此开始，我们接手照顾它们，在这个“中转站”等待再次进入家庭。它们看着我们一步一步的完善小院建设，完善管理模式，探索提高领养率的办法，寻找更好的募款途径，孤儿院一天天的在前进。我们也看着他们由小肉球变成大肉滚儿，对人的亲近一如既往，但是，我们也清楚，最佳的寻找领养的机会也在一天一天过去，因为没有在最合适的时间进入家庭，很多性格的养成就越为不适应家庭生活，因此，对领养人的要求从爱心，责任心和耐心等方面将会有更多的考验。</p>
        <p>现在结局还是来了，就在即将到来的整整第五年，小米由于鼻子有顽固的过敏性皮肤病，每到夏天就要被带到医院进行治疗，由于不习惯被陌生人拴狗链，在护士拴着两条狗链遛它的时候，还是挣脱了链子跑丢了，至今仍然在寻找中。紧接着大米迎来了愿意领养它的家庭，由于生活环境的巨大差异，目前还处在艰难的磨合期，领养家庭付出巨大的耐心，在我们的建议下一点点跟它建立感情和彼此的信任。我们心里即欣慰又忐忑，自己家的孩子一定要在新家乖啊，要招人喜欢啊，同时，一定要幸福啊。</p>
        <p>匆匆的五年，大米小米并不算完美的结局，其实是汪汪喵呜孤儿院的一个缩影，我们的最初，只是很简单的想为这些流离失所的孩子们提供这样一个遮风避雨的环境，尽量满足它们快乐生活的条件，但最终目的，还是要帮助它们进入新的家庭，变成一个幸福的家庭成员安度生涯。这是最朴素的想法，为此我们付出着最大的努力。</p>
        <p>五年里我们并不独孤，有非常多的人们毫不吝啬的在支持和帮助汪汪喵呜孤儿院，但是就结果来说，我们不想用“我们已经尽力了”来总结我们的工作成果。我们不需要这样的自我安慰，我们希望更多的人，更多的社会力量来帮助这里，达到大家共同的愿望，让领养成功的机会越来越多，让流浪的小动物们越来越少。不止一次地我们在想，如果我们的宣传力度再大一点儿，效果再好一点儿，是不是在最可爱的肉球阶段，大米和小米就能进入温暖的领养家庭，就会避免目前让人感到无奈和遗憾的结局？因此，面对未来我们清晰的知道需要继续努力，也需要大家更多的支持和传播。</p>
        <p>我们坚信，这条路上我们并不孤独。</p>
        <p>五年里，组织成员来来去去，有的在这里结缘组建了家庭，有的喜得贵子，还有一位很意外的突然昏迷至今未醒来。。。。在与曾经在的各位，我们还是荣辱与共，汪汪喵呜是用大家的付出支撑到如今的，也将有更多的支持越做越好。祝福所有的人，所有的美丽生命。</p>
        <p>写在这个五年，盼望更好的五年。</p>
        <div style="text-align: right"><img src="/image/yingjiajun/yinming.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">隐明</div></div>
    </div>
    <div class="actions">
        <div class="ui green deny button">关闭</div>
    </div>
</div>

<div class="ui long modal" id="linxiaomao_modal">
    <div class="header">22只狗·1800天·55万</div>
    <div class="content">
        <p>汪汪喵呜孤儿院的客服组,经常会遇到这样的质疑: 你们不是救助组织吗,为什么不能收我捡的小狗。每每听到这样的声音,我们的心里都有难以言喻的辛酸,亲们,真不是小院的人各个都铁石心肠,臣妾真的做不到啊。</p>
        <p>就从最典型的案例—大兴瀛海镇大救助说起，这是汪汪喵呜孤儿院史上最大型的一次救助行动，当时大兴瀛海镇拆迁，一时间满地弃狗，无饭无水，终日流浪，哀嚎遍地，还有很多初生的小狗，刚刚睁眼就只见得一地废墟。在这里身强力壮也未必是好事，不知道那天就被附近的坏人盯上，而后误入陷阱，成了他们的盘中餐。当时汪汪喵呜孤儿院的热血青年们，不忍心这些流浪的孩子们无依无靠，就急匆匆的加入了救助的行列，这次救助大行动之后，就为汪汪喵呜孤儿院的狗群数量奠定了“坚实的基础”，正好22只，从此来到了小院这个大家庭，也从此有了新的姓“瀛”。</p>
        <p>那个时候，真的是没有做好心理准备，没有想到领养的工作会这么艰难，也没有想到救助的孩子们都这么多灾多难，好几个孩子都还没有来得及享受到甜蜜的生活，就匆匆的离开了这个世界，还有些孩子们，由于遭受了严重的心理创伤，至今都无法和人类建立起紧密的关系，到了今年，整整的五年中，至今仍生活在小院的，当年瀛海镇获救的孩子们，仍有17只，也曾经做了很多的宣传，希望有很多善良的人，能够给他们温暖的家，可是事情常常是事与愿违，岁月一点点过去，回家的希望也越来越渺茫。</p>
        <p>为了狗狗的福利，汪汪喵呜孤儿院之后一直严格控制狗狗的数量，绝不多于50只狗狗，以保证他们每个孩子在这里都能够有高品质的生活，坐下来细细的算起帐来，赫然发现一个可怕的事实，这五年间，22个瀛家军的孩子，竟然已花费了55万人民币，这只是粗略的算了吃住的费用，有些孩子当年的医药费还没有细细的计算在内，数额之大直让人冒汗，而在这些款项中，接受的捐助仅为N分之1，剩余部分都是团队成员自己垫付，已够得上一辆奔驰汽车了，震惊之余我们在接到新的求助的时候，总会对自己默念：要挺住要挺住，我们真的无力负担。</p>
        <p>马上就到了瀛家军救助5周年的纪念日了，回想起那个冲动但很有意义的救助，总是让人思绪万千，我们也恳请大家，在这个时候对我们伸出援助之手，对瀛家军剩下的孩子伸出温暖的双手，如果你有能力也有领养的愿望，请先考虑考虑这些可怜的孩子，努力给他们一个温暖的家，这些流浪的孩子们，会加倍珍惜自己的幸福，只需要一点点时间，他们就会让你看到，如果你确实不能够领养，但是也有帮助他们的愿望，也请支持我们助养这些狗狗，给他们温暖的生活，一只小型的狗狗每年的吃住，大概要花费2000多一点，每个月不到200块钱，一只大型的狗狗，每个月的吃住，大概要花费4000多块钱，每个月不到400块钱，俗话说的好，滴水之爱，亦能成河，有足够多的人支持我们，流浪动物的救助才能够顺利的进行下去，才会有更多的流浪狗狗能够期盼到美好的明天，在这里，谢谢大家了。</p>
        <div style="text-align: right"><img src="/image/yingjiajun/linxiaomao.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">林小猫</div></div>
    </div>
    <div class="actions">
        <div class="ui green deny button">关闭</div>
    </div>
</div>

<div class="ui long modal" id="xiaoxiao_modal">
    <div class="header">笑笑 vs 瀛笑笑</div>
    <div class="content">
        <p>任职模拟家庭管理员之后，我就听说了，这里有个和我拥有一个名字的小家伙。两个星期之后我第一次到小院，才有了第一次见面。见面之前我看了关于它的故事，实打实的苦孩子。</p>
        <p>笑笑是瀛家军里的一员，原名瀛红豆，来自大兴瀛海镇的拆迁地。汪汪喵呜孤儿院的新浪博客上就有笑笑找领养的一篇文章。笑笑曾经从汪汪喵呜孤儿院成功领养出去，这个名字就是领养家庭给的。笑笑还安心陪伴被主人捡来救助的猫咪小毛，笑笑一度成为大家标榜和羡慕的孩子，然而，笑笑的命运却是多舛。因为领养家庭中家人猫狗毛引起哮喘这个问题始终存在，终于，夏天的到来加剧了矛盾，笑笑连同小毛又重新失去家庭。</p>
        <p>瀛笑笑：中小型身材，有点苦瓜脸，因为敏感，显得有些胆小，因为兴奋紧张，所以叫声有点急。它并不是极尽谄媚邀宠的孩子，和其它孩子相比总是显得太过规矩和安静，但又不自闭。它在汪汪喵呜孤儿院和领养家庭中感受过爱，所以它爱人，但，它又失去过爱，这种变化，让它变得不同。很多猫狗，因为失去家庭，变得敏感或忧郁，我们的小院里有不少这样的孩子，面对外界多少有些恐惧，蜷缩在自己狭小黑暗的内心空间，走不出来。所以，对于领养条件，我们也是总结了千百次的经验教训而制定的，因为我们不能拿它们的未来去做赌注。我有一个很受挫的领养经历，其实，可能在致力于动物救助和领养的同胞们看来并不是大事，也不值得一提，但这个事情，在我心里一直是个疙瘩。我一直都觉得，它们在模拟家庭个性变得越来越健康，每个孩子都那么可爱，为什么就领养不出去呢？于是我放宽了来参观的人，接受了一个高中生的领养申请，当然当时并不知道，见面之后才知道这个高中女孩是以她妈妈的身份写的申请表。但是也没介意，之后，跟随流程一直走下来，她们确定领养豆丁（一只生活在汪汪喵呜孤儿院-模拟家庭的猫）。后来送养当天的情况，却是让人瞠目。因为我的疏忽和不好意思，少问了很多问题，当天到了，我才发现了那么多的隐藏问题：合租、出入人杂、即将面临高三高考的女孩主要负责养猫、妈妈并不赞成养猫、屋门离楼梯口很近、最要命的是，这个女孩曾经养过藏獒，后来因为爸妈反对，把狗送走了……这么多不安定的因素，又考虑到豆丁的个性并不是一个容易融入陌生环境的猫，但也想试试，也许就成了呢？有时候别人骗你不好骗，但当你自己想让别人骗你的时候，就另当别论了。虽然妥善安顿好之后再离开，当时有经验的阿姨和有经验的同事都表示，如果不行，就还是接回模拟家庭。果不其然，第3天就打电话说找不到豆丁了，也没看到豆丁吃喝，只尿了一次。幻想中的泡泡被打破了，当天下午我们赶到领养家庭，好在虚惊一场，从马桶后面找回了豆丁，但回了模拟家庭豆丁就多了一种习惯，每到下午4点多就会叫，像小猫找妈妈那种。每次都会让我想起这件事情。之后有一个星期的时间，豆丁不爱出来玩，后来才又慢慢好起来，回归一身腱子肉，偶尔“喳喳喳”追逐猎物的豆丁。一次送养就能对豆丁造成这样的影响，试想笑笑呢？</p>
        <p>对了，还有一个生活在模拟家庭，我照顾很多的小狗：钱多多，也是一个比较幸福的案例。钱多多，原名福多多，白色比熊，被人遗弃，撞断了腰和腿，在护城河边被我们救起，成为了汪汪喵呜孤儿院【小天使基金】21号救助对象。后来，手术成功了，再后来，它住进了模拟家庭。多多性格焦虑，粘人，爱叫，因为在模拟家庭生活时，捡钱成名，改名：钱多多。多多刚来模拟家庭生活时，一眼看不见人，就吠叫不止，而且边叫边跳，后来，叫，就任它叫，每次它不叫，我就给它好吃的，每次出去拉了便便，就夸奖它，慢慢形成习惯。虽说我们的训练以奖励为主，但是，我必须说，为了能加快它的性格和生活习惯的形成，我还是批评过它的，它很聪明，虽然不知道你具体在讲什么，但绝对能感知你的情绪，况且狗狗可爱的一点在于，它永远都是以主人的意志为转移，所以，狗狗其实是最好相处的。抱歉我的训练能力很低，可能在摸索中，没有训练给多多什么技能。但笑笑真的是来自正规的训练，训练师叫小龙，现在我们内部的训练视频都是拍摄的笑笑和八戒的训练视频，蹲、坐、趴、航空箱等待、拒食、握手……笑笑其实是拥有非常非常棒的与人相处的能力，但是，自上次领养后，它却没能再被领养。</p>
        <p>为了让孩子能长久而且稳定的被领养，我们尽可能努力对于它们进行良性的生活习惯训练和健康的心理建设，目的只有一个，给它们找到适合并属于它们的家。</p>
        <div style="text-align: right"><img src="/image/yingjiajun/xiaoxiao.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">笑笑</div></div>
    </div>
    <div class="actions">
        <div class="ui green deny button">关闭</div>
    </div>
</div>

<div class="ui long modal" id="maodouma_modal">
    <div class="header">我是菜鸟</div>
    <div class="content">
        <p>作为一个从未参加过任何活动的菜鸟志愿者，鬼使神差，从微博上报名去了小院，参加活动，刚开始只是好奇，可是当一大群狗狗狂吠着集体向你奔来的时候，心中掠过一丝惊慌“我会不会死在这里？”然而，剧情急转直下，当它们靠近我的那一刻，通通伸出了爪子让我抱抱，各种求抚摸，摇着尾巴用祈求的眼神望着你，瞬间，心就这么融化了……</p>
        <p>它们跟我印象中有家庭的狗完全不同，倒是有些像孤儿院里，那些极度渴望被领养的孩子们，没有骄傲从容，只有不安和渴望。其中有一只叫瀛拉拉的狗，它的眼神特别揪心，挥之不去，它并没有冲到我的面前，而是不远不近地望着我，不叫、不闹，默默地等着我看到它，那是一种羞怯又祈盼的眼神，我多想跟自己说“把它抱回家，就现在。”可我只是走过去，摸了摸它，跟它说我还会来看你的。</p>
        <p>这个小院的每一只狗都有一段悲惨的心酸血泪史，有一只叫毛豆的金毛它出生在繁殖场，从未吃饱过，直到它有了生育能力，就重复着被强暴—生baby—失去baby—打激素—又被强暴……的生活，直到丧失生育功能的那一刻，等着它的是狗肉市场。还有一只叫路飞的古牧，被发现时全身没有一根毛，乍看上去，像一只粉色的羊，N多病、奄奄一息。我却一直没有勇气去询问拉拉的身世，总觉得那种无辜的眼神背后，不应被命运赋予残忍的色彩，这种自欺欺人是因为不忍心，也是因为我能做的太少了。其实瀛拉拉是瀛家军中的一员，那是大兴瀛海村拆迁中被救助的狗狗们，可能被抛弃过，所以特别特别的怕人，总是处于恐惧又渴望中，它们数量庞大以至于我根本搞不清楚它们的名字。</p>
        <p>我不明白，面对如此弱小、可爱又充满善意的生灵，人类，你怎么能那么残忍？其实，我之前的无视也同样残忍，路边被汽车压死的狗狗，瘦骨嶙峋的流浪狗，无数次与我擦肩而过，却从未引起我的注意，我甚至认为那是生物法则，优胜劣汰，其实狗狗不是狮子老虎，城市也不是原始森林。狗这一物种自古就是人类的助手，看家护院、捕杀猎物，当机械取代了原始劳作，我们就一定要兔死狗烹吗？忘 恩 负 义！</p>
        <p>佛家有云，“欲知前世因，今生受者是；欲知后世果，今生作者是。”你的残忍终究会让你体味，你的善行也绝不会被辜负。救助，我们在路上。</p>
        <div style="text-align: right"><img src="/image/yingjiajun/maodouma.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">毛豆妈</div></div>
    </div>
    <div class="actions">
        <div class="ui green deny button">关闭</div>
    </div>
</div>

<div class="ui long modal" id="vivien_modal">
    <div class="header">纪念瀛大海</div>
    <div class="content">
        <p>瀛大海，来自北京大兴瀛海镇的拆迁村。</p>
        <p>2010年7月，为了实施北京南城发展计划，大兴区瀛海镇进行了大规模拆迁，拆迁范围涉及22个村，6700户村民，所有拆迁工作将于8月6日结束。据调查显示有近九成拆迁户将遗弃猫狗，目前村民正在大批搬离，大量曾经的伴侣动物被遗留在废墟上，猫狗贩子们已在该地开始抓捕并且四处张贴收购信息。等待着它们的将是大棒和屠刀，对于该地遗留的伴侣动物的救助已经刻不容缓！</p>
        <p>汪汪喵呜孤儿院与北京爱它动物保护公益基金会的前身——中国保护动物记者沙龙、国际爱护动物基金会（IFAW）、瑞家志愿者团队及媒体朋友们共同发起了“带我去新家”集体救助活动，救助并收容了来自瀛海镇的22只大中小型犬，治疗、照顾它们并坚持为它们找家，瀛大海就是其中的一员。</p>
        <p>大海比较特殊，它是中大型老年犬，当时已经10岁多了。我们见到大海的时候，它的家已经变成了废墟，它的主人早已搬到了新的地方，大海坚持待在家门口，不离不弃。大海很温顺，对于志愿者非常友好，安静，不吵不闹，虽然有点儿不情愿，但还是接受了我们给它拴上狗链，带上车去医院检查身体。之后，免疫、绝育、从大兴接到了我们位于良乡的领养中心。</p>
        <p>刚刚进入领养中心的大海，秉承着一贯的生活习惯——看门！它牢牢的坚守在自己狗舍的门口，不出来，也不进去，就是看着这个门，也许，这也是中国大部分农村和城乡结合部狗狗的命运和使命吧！</p>
        <p>大海用了将近2个月才逐渐适应了汪汪喵呜孤儿院，而在这两个月之中，我们甚至担心它会像网上很多故事主角那样，因为突然离开家园，极度不适应而抑郁而亡。但是，大海没有，它在志愿者们的爱心守护中坚持过来了，慢慢恢复健康，而且心情也越来越开朗呢！不得不自夸一下，汪汪喵呜孤儿院，绝对是流浪动物的一片乐土。</p>
        <p>2012年，在生活了2年多之后的一天清晨，大海，突然离开了我们，原因是“急性胃扭转”。事后，百度了一下，急性胃扭转常发生于老年中大型犬，而且发病突然，病程很短，通常在可以观察出来到死亡只有1小时左右。大海就是在送往医院，手术中途离开的。</p>
        <p>大海的死亡，让我们一时都很难接受，因为，它是全体汪汪喵呜孤儿院成员都非常喜爱的狗狗，懂事、安静、温暖。我们以为可以让它的幸福延续的再长一点点。</p>
        <p>在此，只想向瀛大海说一声：在汪星，你要快乐！</p>
        <div style="text-align: right"><img src="/image/yingjiajun/vivien.jpg" style="width: 60px; border-radius: 60px;vertical-align: middle; margin-right: 20px"><div style="display: inline-block;font-weight: bold">Vivien</div></div>
    </div>
    <div class="actions">
        <div class="ui green deny button">关闭</div>
    </div>
</div>

<script type="text/javascript">
    $('document').ready(function() {
        $('.yingjiajun.list .avatar').hover(function() {
            $(this).find('.pet_info').fadeIn(400);
        }, function() {
            $(this).find('.pet_info').fadeOut(300);
        });
        
        $('#waterfall').waterfall({
            itemCls: 'waterfall-item',
            prefix: 'waterfall',
            colWidth: 236,
            gutterWidth: 12,
            gutterHeight: 12,
            minCol: 4,
            checkImagesLoaded: true,
            dataType: 'html',
            path: function(page) {
                return '/topic/waterfall/' + page;
            }
        });
    });
</script>