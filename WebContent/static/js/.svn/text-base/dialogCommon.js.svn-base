/// <reference path="zepto.min.js" />
/// <reference path="jquery-1.8.3.min.js" />
/// <reference path="zepto.animate.js" />

(function (window, undefined) {
    /* 命名空间 */
    var jc = {};

    /* 判断客户端 */
    jc.isMobile = !!(/AppleWebKit.*Mobile/i.test(navigator.userAgent) || (/MIDP|SymbianOS|NOKIA|SAMSUNG|LG|NEC|TCL|Alcatel|BIRD|DBTEL|Dopod|PHILIPS|HAIER|LENOVO|MOT-|Nokia|SonyEricsson|SIE-|Amoi|ZTE/.test(navigator.userAgent)));

    /* 存放所有Ready要执行的函数 */
    jc.fnInit = [];

    /* 存放所有UI */
    jc.ui = {};

    /* 存放UI所有属性 */
    jc.tmpUiValue = {}

    /* ui继承 */
    jc.uiExtend = function (uiName, obj) {
        jc.tmpUiValue[uiName] = function ($element, _element, value) {
            this.$element = $element;
            this._element = _element;
            this.isInit = false;
            this.initValue = value;
        };

        for (var attr in obj) {
            jc.tmpUiValue[uiName].prototype[attr] = obj[attr];
        }
    };

    /* 判断UI是否存在 返回个数 */
    jc.hasUI = function (uiName) {
        if (typeof uiName != "string" || !jc.ui[uiName]) return 0;
        if (jc.ui[uiName].length) return jc.ui[uiName].length;
    }


    /* 装载插件 */
    jc.uiUpdate = function () {
        /* 取出所有的DIV元素 */
        var aDiv = document.querySelectorAll ? document.querySelectorAll('div[data-ui]') : document.getElementsByTagName("div");

        for (var i = 0, l = aDiv.length; i < l; i++) {
            var curElement = aDiv[i];

            /* 如果已存在ui */
            if (curElement.uiFlag) continue;

            var sPlugName = curElement.getAttribute("data-ui");

            /* 存续init传参 */
            var initValue = curElement.getAttribute("data-init");

            if (sPlugName) {
                /* 判断插件是否有写在ui里面 */
                if (!jc.ui[sPlugName]) jc.ui[sPlugName] = {
                    length: 0,

                    eq: function (num) {
                        return this[num];
                    },
                    all: function (fn) {
                        for (var i = 0, l = this.length; i < l; i++) {
                            if (fn) fn(i, this[i]);
                        }
                    },
                    filter: function (term, fn) {/* token=a */
                        var attr = $.trim(term).split("=");
                        if (attr.length < 2) return;
                        for (var i = 0, l = this.length; i < l; i++) {
                            if (this[i]._element.getAttribute("data-" + $.trim(attr[0])) === $.trim(attr[1])) {
                                if (fn) fn(i, this[i]);
                            }
                        }
                    }

                }

                /* 增加元素 */
                var curUI = jc.ui[sPlugName];

                /* 增加属性 看看有没有写业务 */
                if (jc.tmpUiValue[sPlugName]) {
                    curElement.uiFlag = sPlugName;
                    curUI[curUI.length] = new jc.tmpUiValue[sPlugName]($(curElement), curElement, initValue);
                    /* 自增 */
                    curUI.length++;
                }

            }

        }

        var oInfo = jc.tools.getWindowInfo();

        for (var attr in jc.ui) {
            var cur = jc.ui[attr];
            /* 如果元素数量不等于0 */
            if (jc.hasUI(attr)) {
                for (var i = 0, l = cur.length; i < l; i++) {
                    if (cur[i].init && !cur[i].isInit) {
                        cur[i].init(oInfo, cur[i].initValue);
                        cur[i].isInit = true;
                    }
                    if (cur[i].mobile && jc.isMobile && !cur[i].isInit) cur[i].mobile(oInfo);
                }
            }
        }





    };

    /* 初始化控件*/
    jc.fnInit.push(jc.uiUpdate);

    /* 工具方法 */
    jc.tools = {
        formatMoney: function (num) {
            num += '';
            num = num.replace(/[^0-9|\.]/g, ''); //清除字符串中的非数字非.字符  

            if (/^0+/) //清除字符串开头的0  
                num = num.replace(/^0+/, '');
            if (!/\./.test(num)) //为整数字符串在末尾添加.00  
                num += '.00';
            if (/^\./.test(num)) //字符以.开头时,在开头添加0  
                num = '0' + num;
            num += '00';        //在字符串末尾补零  
            num = num.match(/\d+\.\d{2}/)[0];
            return num;
        },
        eventListener: {
            add: function (obj, evType, fn) {
                obj.addEventListener ? obj.addEventListener(evType, fn, false) : obj.attachEvent("on" + evType, fn);
            },
            remove: function (obj, evType, fn) {
                obj.removeEventListener ? obj.removeEventListener(evType, fn, false) : obj.detachEvent("on" + evType, fn);
            }
        },
        range: function (iNow, iMin, iMax) {
            if (iNow > iMax) return iMax;
            else if (iNow < iMin) return iMin;
            return iNow;
        },
        getWindowInfo: function () {
            return {
                scrollTop: (document.documentElement.scrollTop || document.body.scrollTop),
                scrollLeft: (document.documentElement.scrollLeft || document.body.scrollLeft),
                windowWidth: (document.documentElement.clientWidth || document.body.clientWidth),
                windowHeight: (document.documentElement.clientHeight || document.body.clientHeight)
            }
        }
    };

    /* cookie */
    jc.cookie = {
        add: function (name, value, path, days) {//四个参数，第一个是cookie的名称，第二个是值，第三个是路径， 第四个是保存天数
            var expDays = days || 30;	// 默认保存30天
            var exp = new Date(); //new Date("December 31, 9998");
            exp.setTime(exp.getTime() + expDays * 24 * 60 * 60 * 1000);
            document.cookie = name + "=" + escape(value) + ";expires=" + exp.toGMTString() + ((!path) ? ";path=/" : ";path=" + path);

        },
        get: function (name) {
            var arr = document.cookie.match(new RegExp("(^| )" + name + "=([^;]*)(;|$)"));
            if (arr != null) return unescape(arr[2]);
            return null;
        },
        remove: function (name) {
            var exp = new Date();
            exp.setTime(exp.getTime() - 2);
            var cval = jc.cookie.get(name);
            if (cval != null) document.cookie = name + "=" + cval + ";expires=" + exp.toGMTString();
        }



    };

    /* rem */
    jc.rem = {
        nowPx: 50,
        oStyle: null,
        _fnResize: function () {
            var _width = document.documentElement.clientWidth || document.body.clientWidth;
            var zoom = _width / 320, fontsizerem = zoom * 50;
            if (_width < 320) fontsizerem = 50;

            var oRoot = document.getElementById("root");
            if (!oRoot) {
                var oRoot = document.createElement("STYLE");
                oRoot.id = "root"
                oRoot.type = "text/css";
                document.head.appendChild(oRoot);
            }

            oRoot.innerHTML = 'html{font-size:' + fontsizerem + 'px;}';

            jc.rem.nowPx = fontsizerem;
        },
        on: function () {
            if (window.addEventListener) {
                window.addEventListener("resize", this._fnResize);
                this._fnResize();
            }
        },
        off: function () {
            if (window.removeEventListener) {
                window.removeEventListener("resize", this._fnResize);
                document.documentElement.style.cssText = "";
            }
        },
        pxToRem: function (px, def) {
            return (parseFloat(px) / (def ? 50 : this.nowPx)) + "rem";
        },
        remToPx: function (rem, def) {
            return (parseFloat(rem) * (def ? 50 : this.nowPx)) + "px";
        },
        log: function (iMin, iMax) {
            if ((iMin > iMax) || !iMin || !iMax || !window.console) return;

            var sLog = "/*\n";
            for (var i = iMin; i <= iMax; i++) {
                sLog += "* " + i + "px == " + this.pxToRem(i) + "\n";
            }
            console.log(sLog + "*/");
        }
    };

    /* 文本转HTML对象 */
    jc.parseHTML = function (str) {
        var oDiv = document.createElement("div");
        var aResult = [];
        oDiv.style.display = "none";
        oDiv.innerHTML = str;
        document.body.appendChild(oDiv);

        for (var i = 0, l = oDiv.children.length; i < l; i++) {
            aResult.push(oDiv.children[i]);
        }
        document.body.removeChild(oDiv);
        return aResult;
    }

    /* 屏蔽层 */
    jc.mask = {
        oMask: null,
        create: function () {
            if (this.oMask) return this.oMask;
            this.oMask = document.createElement("DIV");
            document.body.appendChild(this.oMask);
            this.oMask.style.cssText = 'display:none;position:fixed;top:0;left:0;width:100%;height:100%;background :#545454;z-index:9999;filter:alpha(opacity=50);opacity:0.5';
        },
        show: function (toShowObj) {
            if (!this.oMask) this.create();
            this.oMask.style.display = "block";
            this.oMask.style.opacity = "0.5";
            this.oMask.style.filter = "alpha(opacity=50)";
            if (toShowObj) toShowObj.show();
        },
        hide: function (toHideObj) {
            if (!this.oMask) this.create();
            this.oMask.style.display = "none";
            this.oMask.style.opacity = "0";
            this.oMask.style.filter = "alpha(opacity=0)";
            if (toHideObj) toHideObj.hide();
        }
    };

    /* 异步请求窗口 */
    jc.dialog = {
        dialogList: {},
        get: function (url, fnSuccess, token) {

            var oAjax = window.XMLHttpRequest ? new XMLHttpRequest() : new ActiveXObject("Microsoft.XMLHTTP");

            if (url.indexOf("?") > -1) {
                url += "&";
            }
            else {
                url += "?";
            }

            oAjax.open("GET", url + "r=" + parseInt(Math.random() * 10000), true);
            oAjax.send();
            oAjax.onreadystatechange = function () {
                if (oAjax.readyState == 4 && oAjax.status == 200) {//请求成功
                    var str = oAjax.responseText;

                    //HTML
                    var sHtml = str.match(/<body>([\s\S]*?)<\/body>/)[1];
                    sHtml = jc.parseHTML(sHtml);
                    if (sHtml.length) sHtml = sHtml[0];

                    if (fnSuccess) fnSuccess(new jc.dialog.setup(sHtml, token), sHtml);

                    //脚本
                    aScriptInner = str.match(/<script type=\"text\/javascript\">([\s\S]*?)<\/script>/);

                    if (aScriptInner) {//有JS
                        var sScript = aScriptInner[1];
                        if (!!(window.attachEvent && !window.opera)) {
                            //ie 
                            execScript(sScript);
                        } else {
                            //not ie 
                            window.eval(sScript);
                        }
                    }

                }
            }
        },
        setup: function (rootObj, token) {
            this.oDialog = rootObj;
            this.token = token;
            /* 先删除之前的 */
            jc.dialog.remove(this.token);

            jc.dialog.dialogList[this.token] = rootObj;
            document.body.appendChild(rootObj);
            this.oDialog.style.cssText = 'position:fixed;_position:absolute;left:50%;top:50%;margin-left:-' + (this.oDialog.offsetWidth / 2) + 'px;margin-top:-' + (this.oDialog.offsetHeight / 2) + 'px;display:none;z-index:10000;';
            /* 按钮点击注册 */
            this.btns = {}
            var aElement = this.oDialog.getElementsByTagName("*");
            for (var i = 0, l = aElement.length; i < l; i++) {
                var sAttr = aElement[i].getAttribute("data-btns");
                var oClose = aElement[i].getAttribute("data-close");
                if (sAttr) {
                    this.btns[sAttr] = aElement[i];
                }
                if (oClose) {
                    var _this = this;
                    aElement[i].onclick = function () {
                        _this.hide();
                    }
                }
            }
            this.show = function () {
                this.oDialog.style.display = "block";
                jc.mask.show();
            }
            this.hide = function () {
                this.oDialog.style.display = "none";
                jc.mask.hide();
            }


        },
        remove: function (token) {
            /* 如果存在窗口就把他删除 */
            if (token) {
                var curToken = this.dialogList[token]
                if (curToken) {
                    document.body.removeChild(curToken);
                    delete curToken;
                }
            }

        }
    };

    /* progress 页面进度 */
    jc.progress = {
        element: null,
        css: null,
        _fnOnload: function () {
            var _this = jc.progress;
            $(_this.element).stop().animate({ width: "100%" }, "slow", function () {
                $(document.body).fadeOut("fast", function () {
                    window.location.href = _this.iframe.src;
                });
            });
        },
        _fnClick: function (e) {
            var e = e || event;
            var oTarget = e.target || e.srcElement;

            if (oTarget.tagName == "A") {
                // 如果加了 data-fix 直接跳转 
                var oTargetAttr = oTarget.getAttribute("data-fix");
                if (oTargetAttr != null) return;

                // 如果不是网址 不管 
                var sLink = $.trim(oTarget.href).toString();
                if ($.trim(oTarget.getAttribute("href")) == "#" || sLink.indexOf("javascript") > -1) return;

                // 阻止默认事件 
                e.preventDefault ? e.preventDefault() : e.returnValue = false;
                // 判断是否创建进度条 
                var _this = jc.progress;

                // 如果没加载进度条 
                if (!_this.element) {
                    _this.element = document.createElement("div");
                    _this.element.style.cssText = "position:fixed; top:0; left:0; z-index:9999; width:0; height:4px; overflow:hidden; background:#f60;"
                    if (_this.css) $(_this.element).css(_this.css);
                    document.body.appendChild(_this.element);
                }
                $(_this.element).width(0);
                $(_this.element).stop().animate({ width: "20%" }, 1600);

                // 如果没加载iframe
                if (!_this.iframe) {
                    _this.iframe = document.createElement("iframe");
                    _this.iframe.style.cssText = "width:0; height:0; overflow:hidden; display:none";
                    document.body.appendChild(_this.iframe);
                }

                _this.iframe.src = oTarget.href;
                $(_this.element).stop().animate({ width: "40%" }, 2000);
                // 先解绑事件 
                jc.tools.eventListener.remove(_this.iframe, "load", _this._fnOnload);
                // 再添加事件 
                jc.tools.eventListener.add(_this.iframe, "load", _this._fnOnload);


            }
        },
        on: function (css) {
            if (!jQuery) return; //不是用Jquery 一律不加进度条
            jc.tools.eventListener.add(document, "click", this._fnClick);
            if (css) {
                this.css = css;
            }

        },
        off: function () {
            if (!jQuery) return; //不是用Jquery 一律不加进度条
            jc.tools.eventListener.remove(document, "click", this._fnClick);
        }
    };


    /* jsonp */
    jc.data = {
        queue: [], //队列存放 每一条信息 {url:xxxx,data:{a:1,b2,c3},success:fn};
        count: 0,
        script: null,
        setup: function (str) {
            this.queue[this.count - 1].success(str);

            /* 销毁 递归  */
            document.head.removeChild(this.script);
            this.script = null;

            if (this.count < this.queue.length) {

                var cur = this.queue[this.count];
                this.load(cur.url, cur.data, cur.success);
                this.count++;
            }


        },
        load: function (url, data, success) {
            this.script = document.createElement("script");
            this.script.type = "text/javascript";
            var aAttr = [];
            if (typeof data == "object") {
                for (var attr in data) {
                    aAttr.push(attr + "=" + data[attr]);
                }
                /* 增加随机数 防止缓存 */
                aAttr.push("r=" + parseInt(Math.random() * 10000));
                /* 增加jsonp的标识 */
                aAttr.push("jsonp=" + "jc.data.setup");
            }

            this.script.src = url + (aAttr.length ? "?" + aAttr.join("&") : "");
            document.head.appendChild(this.script);
        },
        jsonp: function (url, data, success) {
            /* 处理传参 */
            if ($.isFunction(data)) {
                success = data;
                data = "";
            }
            this.queue.push({ url: url, data: data, success: success });


            if (!this.script) {
                var cur = this.queue[this.count]
                this.load(cur.url, cur.data, cur.success);
                this.count++;
            }
        }
    };


    /* 是否启用自定义滚动条 */
    jc.fnInit.push(function () {
        if ($("html").niceScroll && !jc.isMobile) {
            $("html").niceScroll({ zindex: 9999, autohidemode: false, cursorwidth: "10px", cursorcolor: "#ccc", cursorborder: 0, cursoropacitymax: 0.8 });
        }
    });



    /* 处理reday事件 */
    $(function () {
        if (!jc.fnInit.length) return;
        for (var i = 0, l = jc.fnInit.length; i < l; i++) {
            jc.fnInit[i]();
        }
    });

    /* 处理resize事件 */
    $(window).resize(function () {
        var oInfo = jc.tools.getWindowInfo();

        for (var attr in jc.ui) {
            var cur = jc.ui[attr];
            if (jc.hasUI(attr)) {
                for (var i = 0, l = cur.length; i < l; i++) {
                    if (cur[i].resize) cur[i].resize(oInfo);
                }
            }
        }
    });

    /* 处理scroll事件 */
    $(window).scroll(function () {

        var oInfo = jc.tools.getWindowInfo();

        for (var attr in jc.ui) {
            var cur = jc.ui[attr];
            if (jc.hasUI(attr)) {
                for (var i = 0, l = cur.length; i < l; i++) {
                    if (cur[i].scroll) cur[i].scroll(oInfo);
                }
            }
        }
    });

    window.jc = jc;
})(window);