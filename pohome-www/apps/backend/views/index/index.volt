<div class="segment">
    <div class="pie">
        <div class="title">物种统计</div>
        <canvas id="speciesStat" width="180" height="180"></canvas>
    </div>
    <div class="pie">
        <div class="title">性别统计</div>
        <canvas id="genderStat" width="180" height="180"></canvas>
    </div>
    <div class="pie">
        <div class="title">状态统计</div>
        <canvas id="statusStat" width="180" height="180"></canvas>
    </div>
</div>
<div class="segment">
    <div class="title">浏览量前10的动物</div>
    <canvas id="petViewStat" width="640" height="270"></canvas>
</div>

<script>
    var ctx;
    
    ctx = $("#speciesStat").get(0).getContext("2d");
    var speciesChart = new Chart(ctx).Pie({{ speciesData }});
    
    ctx = $("#genderStat").get(0).getContext("2d");
    var genderChart = new Chart(ctx).Pie({{ genderData }});
    
    ctx = $("#statusStat").get(0).getContext("2d");
    var statusChart = new Chart(ctx).Pie({{ statusData }});
    
    ctx = $("#petViewStat").get(0).getContext("2d");
    var petViewChart = new Chart(ctx).Bar({{ petViewData }});
</script>