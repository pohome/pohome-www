<?php
    
// backend permission constant
define('PERMISSION_LOGIN_BACKEND', 1);
define('PERMISSION_CREATE_NEW_PET', 2);
define('PERMISSION_EDIT_PET', 4);
define('PERMISSION_ALL', 4294967295);

$petStatus = array(
    '1' => '等待领养',
    '2' => '住院治疗',
    '3' => '康复中',
    '4' => '训练中',
    '5' => '家庭寄养中',
    '6' => '已领养',
    '7' => '走失',
    '8' => '死亡',
);

$petLocation = array(
    '1' => '良乡基地',
    '2' => '模拟家庭',
    '3' => '小十三里寄养中心',
    '10' => '宠福鑫动物医院 - 天通苑店',
    '11' => '万康动物医院 - 良乡店',
);

$blogCatelog = array(
    '1' => '领养故事',
    '2' => '救助故事',
    '3' => '小天使基金',
    '4' => '志愿者活动',
    '5' => '知识库',
    '6' => '曹菡艾教授专栏',
    '7' => '动保新闻',
    '8' => '未分类',
);

$faqCatelog = array(
    '1' => '关于汪汪喵呜孤儿院',
    '2' => '领养',
    '3' => '助养',
    '4' => '汪星人',
    '5' => '喵星人',
    '6' => '帮助我们'
);

$eventType = array(
    '1' => '良乡基地劳动',
    '2' => '模拟家庭劳动',
    '3' => '社区义卖宣传',
    '4' => '其它'
);