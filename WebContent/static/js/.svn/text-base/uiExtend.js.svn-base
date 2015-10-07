/// <reference path="jquery-1.8.3.min.js" />
/// <reference path="common.js" />
jc.uiExtend("header", {
    isLogin: function (userName, userFaceSrc, mailCount) {
        this.oNot.hide();
        this.oLogin.show();

        this.oUserName.html('<i class="icon">󰄭</i>' + userName);
        this.oUserFace.attr("src", userFaceSrc);
        if (mailCount) {
            this.oMail.html('<i class="icon">󰄸</i>我的消息 ( ' + mailCount + ' )');
        }
    },
    notLogin: function () {
        this.oNot.show();
        this.oLogin.hide();

        this.oUserName.html('<i class="icon">󰄭</i>');
        this.oUserFace.attr("src", "#");
        this.oMail.html('<i class="icon">󰄸</i>我的消息');
    },
    init: function () {
        this.oNav = this.$element.find(".i_nav");
        this.oItem = this.oNav.find(".n_item");

        this.oShoppingCart = this.$element.find(".i_shoppingCart");

        this.oNot = this.$element.find(".not");

        this.oLogin = this.$element.find(".login");
        this.oUserName = this.oLogin.find(".l_userName");
        this.oUserFace = this.oLogin.find(".u_face img");
        this.oMail = this.oLogin.find(".l_mail");

        /* 购物车层 */
        this.oShoppingCart.hover(function () {
            $(".s_menu").show();
        }, function () {
            $(".s_menu").hide();
        });

        this.oItem.add(this.oShoppingCart).add(this.oNot).add(this.oLogin).hover(function () {
            $(this).find(".i_menu").show();
            if (!$(this).hasClass("current")) {
                $(this).addClass("active")
            }
        }, function () {
            $(this).find(".i_menu").hide();
            if (!$(this).hasClass("current")) {
                $(this).removeClass("active")
            }
        });
        this.oLogin.hover(function () {
            $(this).find(".u_menu").show();
        }, function () {
            $(this).find(".u_menu").hide();
        });



    }

});

jc.uiExtend("picHolder", {

    init: function () {
        this.$element.on("mouseover", ".m_item", function () {
            $(this).find(".p_mask").show();
        });
        this.$element.on("mouseout", ".m_item", function () {
            $(this).find(".p_mask").hide();

        });
    }

});

jc.uiExtend("silder", {
    timer: null,
    iNow: 0,
    iMax: 0,
    animate: function (oInfo) {
        var iT = oInfo.scrollTop;
        var offsetTop = this.$element.offset().top;
        var offsetHeight = 400
        var iPre = (iT - offsetTop + 60) / offsetHeight;



        if (iPre >= -1 && iPre <= 1) {
            if (this.aItem) {
                this.aItem.each(function (i, obj) {
                    $(obj).css("backgroundPosition", "50% " + -parseInt(iPre * (offsetHeight / 2)) + "px");
                });


            }
        }
    },
    scroll: function (oInfo) {
        /* 暂不开放 */
        //this.animate(oInfo);
    },
    next: function () {
        if (this.iNow == this.iMax - 1) {
            this.iNow = 0;
        }
        else {
            this.iNow++;
        }
        this.jump(this.iNow);

    },
    prev: function () {
        if (this.iNow == 0) {
            this.iNow = this.iMax - 1;
        }
        else {
            this.iNow--;
        }
        this.jump(this.iNow);

    },
    jump: function (eq) {
        this.iNow = eq;
        this.aItem.eq(eq).stop().animate({ opacity: 1 }, "slow", function () {
            $(this).addClass("active");
        }).siblings().stop().animate({ opacity: 0 }, "slow", function () {
            $(this).removeClass("active");
        });
        this.aDot.eq(eq).addClass("active").siblings().removeClass("active");

    },
    autoPlay: function (bool) {
        var _this = this;
        if (bool) {
            clearInterval(this.timer);
            this.timer = setInterval(function () {
                if (_this.iNow == _this.iMax - 1) {
                    _this.iNow = 0;
                }
                else {
                    _this.iNow++
                }
                _this.jump(_this.iNow);
            }, 6000);
        }
        else {
            clearInterval(this.timer);
        }

    },
    init: function (oInfo) {

        var _this = this;

        /* 暂不开放 */
        //this.animate(oInfo);

        this.oMain = this.$element.find(".s_main");
        this.aItem = this.oMain.children();

        this.oStep = this.$element.find(".s_step").children();

        this.oController = this.$element.find(".s_controller");


        this.aItem.each(function (i, obj) {
            var oA = $("<a>").attr("href", "javascript:;").mousemove(function () {
                _this.jump($(this).index());
            });
            _this.oController.append(oA);
        });

        this.aDot = this.oController.children();

        this.iMax = this.aItem.length;
        this.jump(0);
        if (this.iMax == 1) return;


        this.oStep.eq(0).click(function () {
            _this.prev();
        });

        this.oStep.eq(1).click(function () {
            _this.next();
        });


        this.$element.hover(function () {
            _this.autoPlay(false);
            _this.oStep.eq(0).stop().animate({ left: 20 }, "fast");
            _this.oStep.eq(1).stop().animate({ right: 20 }, "fast");
        }, function () {
            _this.oStep.eq(0).stop().animate({ left: -60 }, "fast");
            _this.oStep.eq(1).stop().animate({ right: -60 }, "fast");
            _this.autoPlay(true);
        });


        this.autoPlay(true);
    }


});

jc.uiExtend("title", {

    init: function () {
        this.aA = this.$element.find(".t_nav a");
        this.aA.click(function () {
            $(this).parent().addClass("active").siblings().removeClass("active");
        });


    }
});

jc.uiExtend("viewChange", {

    init: function () {
        this.aBtn = this.$element.find(".b_btn a");
        this.aBtn.click(function () {
            $(this).parent().addClass("active").siblings().removeClass("active");

        });

    }


});

jc.uiExtend("leftMenu", {

    init: function () {
        this.aItem = this.$element.find(".l_item");

        this.aItem.click(function () {
            $(this).addClass("active").siblings().removeClass("active");
        });

    }


});


jc.uiExtend("courseList", {

    init: function () {
        this.aChild = this.$element.find(".i_child");
        this.aChild.hover(function () {
            $(this).addClass("active");
        }, function () {
            $(this).removeClass("active");
        });

    }

});



jc.uiExtend("userFaceList", {
    init: function () {
        this.aItem = this.$element.find(".u_item");

        this.aItem.hover(function () {
            $(this).addClass("active");
        }, function () {
            $(this).removeClass("active");
        });
    }
});

jc.uiExtend("tab", {
    jump: function (eq) {
        this.aHitem.eq(eq).addClass("active").siblings().removeClass("active");
        this.aTitem.eq(eq).addClass("active").siblings().removeClass("active");

    },
    init: function () {
        var _this = this;

        this.aHitem = this.$element.find(".h_item");
        this.aTitem = this.$element.find(".t_item");


        this.aHitem.click(function () {
            _this.jump($(this).index());
        });

    }

});


jc.uiExtend("courseInfo", {
    init: function () {
        this.aItem = this.$element.find(".l_item");
        this.oBar = this.$element.find(".p_bar");

        this.iTmpWidth = this.oBar.width();

        var iHeight = 340 / this.aItem.length;
        this.aItem.css({ lineHeight: iHeight + "px", height: iHeight });


        if (this.iTmpWidth) {
            this.oBar.width(0);
            this.oBar.animate({ width: this.iTmpWidth }, "slow");
        }



    }

});




jc.uiExtend("select", {
    open: function () {
        this.oMain.addClass("active");
    },
    close: function () {
        this.oMain.removeClass("active");
    },
    get: function () {
        return this.oSelect;
    },
    updata: function () {
        var _this = this;

        this.oMain = this.$element.find(".s_main");

        if (this.oMain.length) {
            this.oMain.html("");
        }
        else {
            this.oMain = $("<div>").addClass("s_main");
            this.$element.append(this.oMain);
        }

        this.oSelect = this.$element.find("select");

        this.oChild = this.oSelect.children();

        this.oChild.each(function (i, obj) {
            var oItem = $("<div>").addClass("m_item").html('<a href="javascript:;">' + obj.innerHTML + '</a>');

            _this.oMain.append(oItem);

            oItem.click(function (e) {
                e = e || window.event;
                if (e.stopPropagation) { //W3C阻止冒泡方法  
                    e.stopPropagation();
                } else {
                    e.cancelBubble = true; //IE阻止冒泡方法  
                }
                if (_this.oMain.hasClass("active")) {
                    $(this).parent().prepend($(this));
                    _this.oSelect.val($(this).find("a").html());
                    if (_this.change) _this.change(_this.oSelect);
                    _this.close();
                }
                else {
                    _this.open();
                }
            });
            _this.oMain.width(_this.oSelect.width() + 20);
            _this.$element.width(_this.oMain.width() + 30);
        });


    },
    init: function () {
        var _this = this;

        $(document).click(function () {
            _this.close();
        });


        this.updata();
    }



});

jc.uiExtend("reply", {
    init: function () {
        var _this = this;
        this.oTextarea = this.$element.find(".t_textarea");
        this.oRange = this.$element.find(".l_range");
        this.oSubmitBtn = this.$element.find(".b_submit");

        this.oTextarea.keydown(function (e) {
            var iLength = $(this).val().length;


            if (iLength > 255) {
                _this.oTextarea.val(_this.oTextarea.val().substring(0, 255));
                _this.oTextarea.blur();
            }
            else {
                _this.oRange.html(255 - iLength);
            }


        }).keyup(function (e) {
            var iLength = $(this).val().length;
            if (iLength > 255) {
                _this.oTextarea.val(_this.oTextarea.val().substring(0, 255));
                _this.oTextarea.blur();
            }
            else {
                _this.oRange.html(255 - iLength);
            }
        });;

        this.oSubmitBtn.click(function () {

            if (_this.oTextarea.val().length > 255) {
                alert("文字超长请修改");
            }
        });


    }


});


jc.uiExtend("filter", {

    init: function () {
        this.aA = this.$element.find(".f_right a");

        this.aA.click(function () {
            $(this).addClass("active").siblings().removeClass("active");

        });
    }


});
jc.uiExtend("filterRow", {

    init: function () {
        this.aA = this.$element.find(".f_right a");

        this.aA.click(function () {
            $(this).addClass("active").siblings().removeClass("active");

        });
    }


});


jc.uiExtend("registerOver", {
    timer: null,
    init: function () {
        var _this = this;
        this.oB = this.$element.find("b");
        this.sHref = this.$element.find("a").attr("href");
        this.iMax = parseInt(this.oB.html());
        this.oB.html(_this.iMax--);
        this.timer = setInterval(function () {
            if (_this.iMax == 0) {
                window.location.href = _this.sHref;
                clearTimeout(_this.timer);
            }
            _this.oB.html(_this.iMax--);

        },1000);

    }

});