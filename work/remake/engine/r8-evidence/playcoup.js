if(typeof __sc !='function'){
    function __sc(key,value,expiredays){var exdate=new Date();exdate.setDate(exdate.getDate()+expiredays);exdate.setHours(0);exdate.setMinutes(0);exdate.setSeconds(0);document.cookie = key+ "=" +escape(value)+";domain=4399.com;path=/"+((expiredays==null) ? "" : ";expires="+exdate.toGMTString())}
}
if(typeof __gc !='function'){
    function __gc(c_name){if (document.cookie.length>0){c_start=document.cookie.indexOf(c_name + "=");if (c_start!=-1){c_start=c_start + c_name.length+1;c_end=document.cookie.indexOf(";",c_start);if (c_end==-1) c_end=document.cookie.length;return unescape(document.cookie.substring(c_start,c_end));}}return ""}
}
(function(){
    var str = '<div class="xndgg" style="display:none"><a onclick="tracead(\'play_float_close\');" href="" class="xndclose"></a><a onclick="tracead(\'play_float\');" href="" class="xndimg"><img src="" alt=""><i></i><span></span></a></div>';
    document.write(str);
    $(".xndclose").click(function(){
        $(".xndgg").hide();
        __sc("play4399corp",1,1);
        return false;   
    });
    $(".xndimg").click(function(){
        $(".xndgg").hide();
        __sc("play4399corp",1,1);
    });
    if(__gc("play4399corp")<1 && $(".xndimg").attr("href")!=''){
        $(".xndgg").show();
    }else{
        $(".xndgg").hide();
    }
    var aplaybanner_json = [{"titletop":"\u4e91\u6e38\u620f","imgtop":"\/\/imga5.5054399.com\/upload_pic\/2026\/2\/11\/4399_09574148169.jpg","linktop":"https:\/\/y.4399.com\/","percent":0,"tongji_key":"play_horizontal"}];
    if(aplaybanner_json.length>0){
        var aplaybanner_json_nopercent = [];
        var aplaybanner_json_item = null;
        var aplaybanner_random = Math.round(Math.random() * 100);
        var precent_begin = 0;
        for (var i = 0; i < aplaybanner_json.length; i++) {
            var item = aplaybanner_json[i];
            if(item['percent']==0){
                aplaybanner_json_nopercent.push(item);
            }else{
                if(precent_begin < aplaybanner_random && aplaybanner_random <= precent_begin + item['percent']){
                    aplaybanner_json_item = item;
                    break;
                }else{
                    precent_begin = precent_begin + item['percent'];
                }
            }
        }
        if(!aplaybanner_json_item && aplaybanner_json_nopercent.length>0){
            var aplaybanner_randomIndex = Math.floor(Math.random() * aplaybanner_json_nopercent.length);
            aplaybanner_json_item = aplaybanner_json_nopercent[aplaybanner_randomIndex];
        }
        if(!aplaybanner_json_item){return false;}
        $("#xndshower").html('<a onclick="tracead(\''+aplaybanner_json_item['tongji_key']+'\');" href="'+aplaybanner_json_item['linktop']+'" class="xndshower"><img src="'+aplaybanner_json_item['imgtop']+'" alt="'+aplaybanner_json_item['titletop']+'"></a>');
    }
})();