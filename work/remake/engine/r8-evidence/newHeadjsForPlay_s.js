function D(item){return document.getElementById(item);}
function array_chunk(array, size) {
	var result = [];
	for (var x = 0; x < Math.ceil(array.length / size); x++) {
		var start = x * size;
		var end = start + size;
		result.push(array.slice(start, end));
	}
	return result;
}
function getCNXH(){
	$.ajax({  
		url:'//gprp.4399.com/cg/recommend_api.php?from=index&page_size=27&page_num=1&simple=1&timestamp='+new Date().getTime(),
		dataType:"jsonp",
		callbackParameter:"callback",
		timeout:2000,  
		success:function(data){
			var combine = new Array();
			//显示平台推荐,根据 recommends 顺序，去game_infos对象中寻找游戏信息
			for(var x in data.recommends){
				var row = data.game_infos[data.recommends[x]];
				var jsspecialarr = new Array();
				for(var aii=0;aii<2;aii++){
					if(row.sList[aii]){
						var arrs = [row.sList[aii]['sName'],"/special/"+row.sList[aii]['sId']+".htm"];
						jsspecialarr.push(arrs);
					}
				}
				var onegame = [data.recommends[x],row.name,row.url,row.pic,row.tidName,"/flash_fl/"+row.tid+"_1.htm",jsspecialarr];
				combine[x] = onegame;
			}
			if(combine.length<27){
				//合并自身推荐去重
				for(var i=0,j=0,ci,r={},c=[];ci=combine[i++]||basic_game_info[j++];){
					if(r[ci[0]])continue;
					r[ci[0]]=1;
					c.push(ci);
				}
				combine = c;
			}
			arr(combine);
		},  
		error:function(XMLHttpRequest, textStatus, errorThrown) {  
			//显示自己预设
			arr(basic_game_info);
		},  
		complete: function(XMLHttpRequest, textStatus) {}
	}); 
	hasgetCNXH = 1;
	$(".cnxhchg").show();
}

var arr_cnxh = new Array();
function arr(data){
	var tjstring = '<ul class="top-list cf" id="repage1">';
	var cnxh2string = "";
	var tjindex = 0;
	var tjsrc;
	for(var x in data){
		if(tjindex<27){
			if(tjindex<9){tjsrc='src';}else{tjsrc='lz_src';}
			tjstring += '<li><a href="'+data[x][2]+'"><img '+tjsrc+'="'+data[x][3]+'" />'+data[x][1]+'</a></li>';
			if(tjindex==8){tjstring += '</ul><ul class="top-list cf" id="repage2" style="display:none;">';}
			if(tjindex==17){tjstring += '</ul><ul class="top-list cf" id="repage3" style="display:none;">';}
			if(tjindex<24){
				var arr_one = new Array();
				arr_one['title'] = data[x][1];
				arr_one['img'] = data[x][3];
				arr_one['link'] = data[x][2];
				arr_one['tidName'] = data[x][4];
				arr_one['tidUrl'] = data[x][5];
				arr_one['specialList'] = data[x][6];
				arr_cnxh.push(arr_one);
			}
			tjindex++;
		}
	}
	tjstring += "</ul>";
	$('#tjgame').html(tjstring);
	arr_cnxh = array_chunk(arr_cnxh,6);
	fillcnxh2(arr_cnxh[0]);
	tpage(1);
}
//填充页面下方的猜你喜欢栏目
function fillcnxh2(data){
	var cnxh2string = "";
	for(var x in data){
		cnxh2string += '<li>';
		cnxh2string += '<a class="le" href="'+data[x]['link']+'"><img alt="'+data[x]['title']+'" lzimg="1" lz_src="'+data[x]['img']+'"></a>';
		cnxh2string += '<p><a class="a1" href="'+data[x]['link']+'">'+data[x]['title']+'</a></p>';
		cnxh2string += '<p><a class="a2" href="'+data[x]['tidUrl']+'">'+data[x]['tidName']+'小游戏</a></p>';
		cnxh2string += '<p class="spe">';
		for(var spi in data[x]['specialList']){
			cnxh2string += '<a href="'+data[x]['specialList'][spi][1]+'">'+data[x]['specialList'][spi][0]+'</a>';
		}
		cnxh2string += '</p>';
		cnxh2string += '</li>';
	}
	$('#cnxh2').html(cnxh2string);
	lzimg_load();
}
function tpage(num){
	var pre = 0;
	var nex = 0;
	var str = "";
	if(num==3){pre=2;nex=1;}else if(num==2){pre=1;nex=3;}else{pre=3;nex=2;}
	str = '<a class="pre" href="" onclick="tpage('+pre+');return false;"></a>';
	str += '<div class="pag-ico">';
	for(var a=1;a<4;a++){
		if(num==a){
			str += '<a class="on" href="" onclick="tpage('+a+');return false;"></a>';
			$("#repage"+a).show();
			$("#repage"+num).html(D("repage"+num).innerHTML.replace(/lz_src/g,"src"));
		}else{
			$("#repage"+a).hide();
			str += '<a href="" onclick="tpage('+a+');return false;"></a>';
		}
	}
	str += '</div>';
	str += '<a class="nex" href="" onclick="tpage('+nex+');return false;"></a>';
	$("#rel_pag").html(str);
}
//我玩过的游戏
function getPlayed(){
	$.ajax({
		url:'//gprp.4399.com/cg/get_gamehistory.php?from=index&simple=true&page_size=27&page_number=1&timestamp='+new Date().getTime(),
		dataType:"jsonp",
		callbackParameter:"callback",
		timeout:2000,  
		success:function(data){
			var combine = new Array();
			var totnum = data.total;
			if(totnum>0){
				$("#showword").hide();
			}else{
				$("#showword").show();
			}
			$("#reading1").hide();
			//显示平台推荐,根据 played_gids 顺序，去 game_infos 对象中寻找游戏信息
			for(var x in data.played_gids){
				var row = data.game_infos[data.played_gids[x].gid];
				var onegame = [data.played_gids[x].gid,row.name,row.url,row.pic,0];
				combine[x] = onegame;
			}
			if(combine.length<27){
				//合并自身推荐去重
				for(var i=0,j=0,ci,r={},c=[];ci=combine[i++]||basic_game_info_play[j++];){
					if(r[ci[0]])continue;
					r[ci[0]]=1;
					c.push(ci);
				}
				combine = c;
			}
			arrplay(combine);
		},  
		error:function(XMLHttpRequest, textStatus, errorThrown) {  
			//显示自己预设
			arrplay(basic_game_info_play);
		},  
		complete: function(XMLHttpRequest, textStatus) {}
	}); 
	hasgetPlayed = 1;
}
function showcc(num){$("#cc"+num).css("display","block");}
function showgg(num){$("#cc"+num).css("display","none");}
function killgame(gid){
	$.ajax({
		url:'//gprp.4399.com/cg/delete_history.php?gid='+gid+'&timestamp='+new Date().getTime(),
		dataType:"jsonp",
		callbackParameter:"callback",
		timeout:10000,  
		success:function(data){
			getPlayed();
		},  
		error:function(XMLHttpRequest, textStatus, errorThrown) {  
			alert('删除失败,请稍候重试');
		},  
		complete: function(XMLHttpRequest, textStatus) {}
	}); 
}
function arrplay(data){
	var tjstring = '<ul class="top-list cf" id="repageplay1">';
	var tjindex = 0;
	var tjsrc;
	for(var x in data){
		if(tjindex<27){
			if(tjindex<9){tjsrc='src';}else{tjsrc='lz_src';}
			var ccid = "cc"+data[x][0];
			if(data[x][4]==1){
				tjstring += '<li><a href="'+data[x][2]+'">';
				tjstring += '<span class="i-rec"></span>';
			}else{
				tjstring += '<li onmouseover="showcc('+data[x][0]+');" onmouseout="showgg('+data[x][0]+');"><em class="del" id="'+ccid+'" onclick="killgame('+data[x][0]+');return false;"></em><a href="'+data[x][2]+'">';
			}
			tjstring += '<img '+tjsrc+'="'+data[x][3]+'" />'+data[x][1]+'</a></li>';
			if(tjindex==8){tjstring += '</ul><ul class="top-list cf" id="repageplay2" style="display:none;">';}
			if(tjindex==17){tjstring += '</ul><ul class="top-list cf" id="repageplay3" style="display:none;">';}
			tjindex++;
		}
	}
	tjstring += "</ul>";
	$('#tjgameplay').html(tjstring);
	tpageplay(1);
}
function tpageplay(num){
	var pre = 0;
	var nex = 0;
	var str = "";
	if(num==3){pre=2;nex=1;}else if(num==2){pre=1;nex=3;}else{pre=3;nex=2;}
	str = '<a class="pre" href="" onclick="tpageplay('+pre+');return false;"></a>';
	str += '<div class="pag-ico">';
	for(var a=1;a<4;a++){
		if(num==a){
			str += '<a class="on" href="" onclick="tpageplay('+a+');return false;"></a>';
			$("#repageplay"+a).show();
			$("#repageplay"+num).html(D("repageplay"+num).innerHTML.replace(/lz_src/g,"src"));
		}else{
			$("#repageplay"+a).hide();
			str += '<a href="" onclick="tpageplay('+a+');return false;"></a>';
		}
	}
	str += '</div>';
	str += '<a class="nex" href="" onclick="tpageplay('+nex+');return false;"></a>';
	$("#rel_pagplay").html(str);
}

/*换肤相关代码*/
var selectedskin = 0;
var currentskintype = 1;
var totcommendpage = Math.ceil(skincommendlistlength/12);
var totnewpage = Math.ceil(skinnewlistlength/12);
if(index4399skin<0 || index4399skin>skinnewlistlength-1){index4399skin=0;}
//只有默认皮肤下且有默认皮肤链接的才显示左右按钮
var nowDialogId = null,dialog_w,dialog_h;
function showWin(id, woraname, word, w, h){if(nowDialogId){closeWin();}nowDialogId = id;dialog_w = w || $("#"+nowDialogId).width();dialog_h = h || $("#"+nowDialogId).height();var height = $(document).height();var w1 = $(window).width();var h1 = $(window).height();var sh = $(window).scrollTop();var str = '<div style="position:absolute;left:0;top:0;background: url(/images/index/ptlogin_mask.png) repeat scroll 0 0 rgba(0, 0, 0, 0);_background:url(about:blank);_filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(enabled=true,sizingMethod=scale, src=/images/index/ptlogin_mask.png);width:100%; height:'+height+'px; z-index:9999;" id="div_dialog">';$("body").append(str);$("#"+nowDialogId).fadeIn().css({"top":((h1-dialog_h)/2+sh)+"px","left":(w1-dialog_w)/2,"zIndex":"99999","position":"absolute"});$(window).bind("resize", change_dialog);$(window).bind("scroll", change_dialog);if(word && woraname){D(woraname).innerHTML = word;}return false;}
function closeWin(){$("#div_dialog").remove();$("#"+nowDialogId).hide();$(window).unbind("resize",change_dialog);$(window).unbind("scroll",change_dialog);nowDialogId = null;return false;}
function change_dialog(){var height = $(document).height();var w1 = $(window).width();var h1 = $(window).height();var sh = $(window).scrollTop();if(height != $('#div_dialog').height()){$('#div_dialog').height(height);}$("#"+nowDialogId).css({"top":((h1-dialog_h)/2+sh)+"px","left":(w1-dialog_w)/2,"zIndex":"99999","position":"absolute"});return false;}
function setCookie3(name,value){var Days = 99999;var exp = new Date();exp.setTime(exp.getTime() + Days*24*60*60*1000);document.cookie = name + "="+ escape (value) + ";path=/;domain=.4399.com;expires=" + exp.toGMTString();}
function getcskininfo(index){for(a in skinnewlist){if(skinnewlist[a][0]==index){return [skinnewlist[a][8],skinnewlist[a][4]];}}}
function isIE6(){return !!window.ActiveXObject && !window.XMLHttpRequest;}
//保存当前的皮肤图片
var tmp_cskinimg_small = cskinimg_small;
function setSkin(type,index){
	selectedskin = index;
	currentskintype = type;
	if(type==1){
		$("#skincommend").html(getskinstr(type,skincommendlist,index));
	}else{
		$("#skinnew").html(getskinstr(type,skinnewlist,index));
	}
	//动态改变新样式
	var temskininfo = getcskininfo(index);
	$("#skincss").attr("href",temskininfo[0]);
	if(temskininfo[1]=="-"){
		$("#skinbody").attr("style","background:url("+defaultbackgroundimg+") no-repeat top center "+defaultbackgroundcolor+";");
		//清空样式
		cskinimg_small = "";
	}else{
		$("#skinbody").attr("style","background:url("+temskininfo[1]+") no-repeat top center;");
		//赋值为当前所选样式
		cskinimg_small = temskininfo[1];
	}
}
function getskinstr(num,str,index){
	if(num==1){
		var skinpage = "skincommendpage";
		var strlength = skincommendlistlength;
		var ttpage = totcommendpage;
	}else{
		var skinpage = "skinnewpage";
		var strlength = skinnewlistlength;
		var ttpage = totnewpage;
	}
	var skinliststr = '<ul id="'+skinpage+'1">';
	var skinpagesrc;
	for(var a=0;a<strlength;a++){
		if(a<12){skinpagesrc='src';}else{skinpagesrc='lz_src';}
		skinliststr += '<li><a href="" onclick="setSkin('+num+','+str[a][0]+');return false;">';
		if(str[a][0]==index){
			skinliststr += '<span class="sel"></span>';
		}
		skinliststr += '<img '+skinpagesrc+'="'+str[a][3]+'" />'+str[a][1]+'</a></li>';
		var ccpage = Math.ceil(a/12);
		if(ccpage>0){
			if(a==(12*ccpage-1)){skinliststr += '</ul><ul id="'+skinpage+(parseInt(ccpage)+1)+'" style="display:none;">';}
		}
	}
	//计算距离12倍数的余数
	var elsenums = ttpage*12-a;
	for(var b=0;b<elsenums;b++){
		skinliststr += '<li><img src="/images/index/waiting.jpg" /></li>';
	}
	skinliststr += "</ul>";
	return skinliststr;
}
function tskinpage(type,num){
	var pre = 0;
	var nex = 0;
	var str = "";
	if(type==1){
		var skinpage = "skincommendpage";
		var totpages = totcommendpage;
	}else{
		skinpage = "skinnewpage";
		var totpages = totnewpage;
	}
	if(num==totpages){
		pre=totpages-1;
		if(pre<1){pre=1;}
		nex=1;
	}else if(num==1){
		pre=totpages;
		nex=2;
	}else{
		pre=num-1;
		nex=num+1;
		if(pre<1){pre=1;}
		if(nex>totpages){nex=totpages;}
	}
	str = '<a class="sk_le" href="" onclick="tskinpage('+type+','+pre+');return false;"></a>';
	str += '<div class="skin_pag">';
	for(var a=1;a<=totpages;a++){
		if(num==a){
			str += '<a class="s_on" href="" onclick="tskinpage('+type+','+a+');return false;">'+a+'</a>';
			$("#"+skinpage+a).show();
			D(skinpage+num).innerHTML = D(skinpage+num).innerHTML.replace(/lz_src/g,"src");
		}else{
			$("#"+skinpage+a).hide();
			str += '<a href="" onclick="tskinpage('+type+','+a+');return false;">'+a+'</a>';
		}
	}
	str += '</div>';
	str += '<a class="sk_ri" href="" onclick="tskinpage('+type+','+nex+');return false;"></a>';
	if(totpages>1){
		$("#skinpager").html(str);
		$("#skinpager").show();
	}
}
function chgskintype(num){
	if(num==1){//推荐
		var skincommendliststr = getskinstr(num,skincommendlist,index4399skin);
		$("#skincommend").html(skincommendliststr);
		$("#skincommend").show();
		$("#skinnew").hide();
		$("#skincommendtab").attr('class','on');
		$("#skinnewtab").attr('class','');
	}else{//最新
		var skinnewliststr = getskinstr(num,skinnewlist,index4399skin);
		$("#skinnew").html(skinnewliststr);
		$("#skincommend").hide();
		$("#skinnew").show();
		$("#skincommendtab").attr('class','');
		$("#skinnewtab").attr('class','on');
	}
	tskinpage(num,1);
}
function saveskin(){
	closeWin();
	displayswf();
	index4399skin = selectedskin;
	//更新为所选样式
	tmp_cskinimg_small = cskinimg_small;
	setCookie3("index4399skin",selectedskin);
	chgSkinInner();
	return false;
}
function cancelskin(){
	closeWin();
	displayswf();
	//替换回当前样式
	cskinimg_small = tmp_cskinimg_small;
	setSkin(currentskintype,index4399skin);
	return false;
}
//同步切换作品iframe皮肤
function chgSkinInner(){
    try{
		D('tuya').contentWindow.chgSkinInner();
    }catch(e) {}
}
$("#chskin").bind("click",function(){chgskintype(1);showWin('skiner');hiddenswf();return false;});

jsloadcomplate = 1;

//显示背景
if(cskinimg_small!="-" && cskinimg_small!=''){
	D("skinbody").style.backgroundImage="url("+cskinimg_small+")";
	D("skinbody").style.backgroundRepeat	="no-repeat";
	D("skinbody").style.backgroundPosition="top center";
}else if(defaultbackgroundimg){
	D("skinbody").style.backgroundImage="url("+defaultbackgroundimg+")";
	D("skinbody").style.backgroundRepeat	="no-repeat";
	D("skinbody").style.backgroundPosition="top center";
	D("skinbody").style.backgroundColor = defaultbackgroundcolor;
}

function hiddenswf(){try{D("pusher").style.display = "block";D("pusher").style.height="2000px";}catch(e){}}
function displayswf(){try{D("pusher").style.display = "none";D("pusher").style.height="0px";}catch(e){}}
$(".tx").mouseenter(function(){$(".wechat-QR").show();}).mouseleave(function(){$(".wechat-QR").hide();}).click(function(){return false;});