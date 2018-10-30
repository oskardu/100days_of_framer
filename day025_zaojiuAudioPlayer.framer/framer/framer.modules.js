require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"audio":[function(require,module,exports){
var wrapLayer, wrapSlider,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Events.SliderValueChange = "sliderValueChange";

exports.Slider = (function(superClass) {
  extend(Slider, superClass);

  function Slider(options) {
    if (options == null) {
      options = {};
    }
    this._updateValue = bind(this._updateValue, this);
    this._knobDidMove = bind(this._knobDidMove, this);
    this._updateFrame = bind(this._updateFrame, this);
    this._updateKnob = bind(this._updateKnob, this);
    this._updateFill = bind(this._updateFill, this);
    this._touchEnd = bind(this._touchEnd, this);
    this._touchStart = bind(this._touchStart, this);
    Slider.__super__.constructor.call(this, options);
  }

  Slider._knob = void 0;

  Slider._fill = void 0;

  Slider._background = void 0;

  Slider.prototype._touchStart = function(event) {
    var scaleX, scaleY, touchX, touchY;
    event.preventDefault();
    if (this._background.width > this._background.height) {
      touchX = Events.touchEvent(event).clientX - Screen.canvasFrame.x;
      scaleX = this.canvasScaleX();
      this.value = this.valueForPoint(touchX / scaleX - this.screenFrame.x);
    } else {
      touchY = Events.touchEvent(event).clientY - Screen.canvasFrame.y;
      scaleY = this.canvasScaleY();
      this.value = this.valueForPoint(touchY / scaleY - this.screenFrame.y);
    }
    this._knob.draggable._touchStart(event);
    return this._updateValue();
  };

  Slider.prototype._touchEnd = function(event) {
    return this._updateValue();
  };

  Slider.prototype._updateFill = function() {
    if (this._background.width > this._background.height) {
      return this._fill.width = this._knob.midX;
    } else {
      return this._fill.height = this._knob.midY;
    }
  };

  Slider.prototype._updateKnob = function() {
    if (this._background.width > this._background.height) {
      this._knob.midX = this._fill.width;
      return this._knob.centerY();
    } else {
      this._knob.midY = this._fill.height;
      return this._knob.centerX();
    }
  };

  Slider.prototype._updateFrame = function() {
    this._knob.draggable.constraints = {
      x: -knob.width / 2,
      y: -knob.height / 2,
      width: this._background.width + this._knob.width,
      height: this._background.height + this._knob.height
    };
    if (this.constrained) {
      this._knob.draggable.constraints = {
        x: 0,
        y: 0,
        width: this._background.width,
        height: this._background.height
      };
    }
    if (this._background.width > this._background.height) {
      this._fill.height = this._background.height;
      this._knob.midX = this.pointForValue(this.value);
      this._knob.centerY();
    } else {
      this._fill.width = this._background.width;
      this._knob.midY = this.pointForValue(this.value);
      this._knob.centerX();
    }
    if (this._background.width > this._background.height) {
      this._knob.draggable.speedY = 0;
      return this._knob.draggable.speedX = 1;
    } else {
      this._knob.draggable.speedX = 0;
      return this._knob.draggable.speedY = 1;
    }
  };

  Slider.prototype.addBackgroundLayer = function(layer) {
    this._background = layer;
    this._background.parent = this;
    this._background.name = "background";
    this._background.x = this._background.y = 0;
    return this._background;
  };

  Slider.prototype.addFillLayer = function(layer) {
    this._fill = layer;
    this._fill.parent = this;
    this._fill.name = "fill";
    this._fill.x = this._fill.y = 0;
    this._fill.width = this.width / 2;
    return this._fill;
  };

  Slider.prototype.addKnobLayer = function(layer) {
    this._knob = layer;
    this._knob.parent = this;
    this._knob.name = "knob";
    this._knob.draggable.enabled = true;
    this._knob.draggable.overdrag = false;
    this._knob.draggable.momentum = true;
    this._knob.draggable.momentumOptions = {
      friction: 5,
      tolerance: 0.25
    };
    this._knob.draggable.bounce = false;
    this._knob.x = Align.center();
    this._knob.y = Align.center();
    return this._knob;
  };

  Slider.define("constrained", Slider.simpleProperty("constrained", false));

  Slider.define("min", {
    get: function() {
      return this._min || 0;
    },
    set: function(value) {
      if (_.isFinite(value)) {
        this._min = value;
      }
      return this.emit("change:min", this._min);
    }
  });

  Slider.define("max", {
    get: function() {
      return this._max || 1;
    },
    set: function(value) {
      if (_.isFinite(value)) {
        this._max = value;
      }
      return this.emit("change:max", this._max);
    }
  });

  Slider.define("value", {
    get: function() {
      return this._value;
    },
    set: function(value) {
      if (!_.isFinite(value)) {
        return;
      }
      this._value = Utils.clamp(value, this.min, this.max);
      if (this._background.width > this._background.height) {
        this._knob.midX = this.pointForValue(value);
      } else {
        this._knob.midY = this.pointForValue(value);
      }
      this._updateFill();
      return this._updateValue();
    }
  });

  Slider.prototype._knobDidMove = function() {
    if (this._background.width > this._background.height) {
      return this.value = this.valueForPoint(this._knob.midX);
    } else {
      return this.value = this.valueForPoint(this._knob.midY);
    }
  };

  Slider.prototype._updateValue = function() {
    if (this._lastUpdatedValue === this.value) {
      return;
    }
    this._lastUpdatedValue = this.value;
    this.emit("change:value", this.value);
    return this.emit(Events.SliderValueChange, this.value);
  };

  Slider.prototype.pointForValue = function(value) {
    if (this._background.width > this._background.height) {
      if (this.constrained) {
        return Utils.modulate(value, [this.min, this.max], [0 + (this._knob.width / 2), this._background.width - (this._knob.width / 2)], true);
      } else {
        return Utils.modulate(value, [this.min, this.max], [0, this._background.width], true);
      }
    } else {
      if (this.constrained) {
        return Utils.modulate(value, [this.min, this.max], [0 + (this._knob.height / 2), this._background.height - (this._knob.height / 2)], true);
      } else {
        return Utils.modulate(value, [this.min, this.max], [0, this._background.height], true);
      }
    }
  };

  Slider.prototype.valueForPoint = function(value) {
    if (this._background.width > this._background.height) {
      if (this.constrained) {
        return Utils.modulate(value, [0 + (this._knob.width / 2), this._background.width - (this._knob.width / 2)], [this.min, this.max], true);
      } else {
        return Utils.modulate(value, [0, this._background.width], [this.min, this.max], true);
      }
    } else {
      if (this.constrained) {
        return Utils.modulate(value, [0 + (this._knob.height / 2), this._background.height - (this._knob.height / 2)], [this.min, this.max], true);
      } else {
        return Utils.modulate(value, [0, this._background.height], [this.min, this.max], true);
      }
    }
  };

  Slider.wrap = function(background, fill, knob, options) {
    return wrapSlider(new this(options), background, fill, knob, options);
  };

  Slider.prototype.onValueChange = function(cb) {
    return this.on(Events.SliderValueChange, cb);
  };

  return Slider;

})(Layer);

wrapSlider = function(instance, background, fill, knob) {
  var slider;
  if (!(background instanceof Layer)) {
    throw new Error("AudioLayer expects a background layer.");
  }
  if (!(fill instanceof Layer)) {
    throw new Error("AudioLayer expects a fill layer.");
  }
  if (!(knob instanceof Layer)) {
    throw new Error("AudioLayer expects a knob layer.");
  }
  slider = instance;
  slider.clip = false;
  slider.backgroundColor = "transparent";
  slider.frame = background.frame;
  slider.parent = background.parent;
  slider.index = background.index;
  slider.addBackgroundLayer(background);
  slider.addFillLayer(fill);
  slider.addKnobLayer(knob);
  slider._updateFrame();
  slider._updateKnob();
  slider._updateFill();
  slider._knobDidMove();
  background.onTapStart(function() {
    return slider._touchStart(event);
  });
  slider.on("change:frame", function() {
    return slider._updateFrame();
  });
  knob.on("change:size", function() {
    return slider._updateKnob();
  });
  knob.on("change:frame", function() {
    slider._updateFill();
    return slider._knobDidMove();
  });
  slider.on("change:max", function() {
    slider._updateFrame();
    slider._updateKnob();
    slider._updateFill();
    return slider._knobDidMove();
  });
  return slider;
};

exports.Audio = (function(superClass) {
  extend(Audio, superClass);

  function Audio(options) {
    if (options == null) {
      options = {};
    }
    this.getTimeLeft = bind(this.getTimeLeft, this);
    if (options.backgroundColor == null) {
      options.backgroundColor = "transparent";
    }
    this.player = document.createElement("audio");
    this.player.setAttribute("webkit-playsinline", "true");
    this.player.setAttribute("preload", "auto");
    this.player.on = this.player.addEventListener;
    this.player.off = this.player.removeEventListener;
    this._time = false;
    Audio.__super__.constructor.call(this, options);
    this.onClick(function() {
      var currentTime, duration, ref, ref1;
      currentTime = Math.round(this.player.currentTime);
      duration = Math.round(this.player.duration);
      if (this.player.paused) {
        this.player.play();
        if (this._pauseControl) {
          this._playControl.visible = false;
        }
        if ((ref = this._pauseControl) != null) {
          ref.visible = true;
        }
        if (currentTime === duration) {
          this.player.currentTime = 0;
          return this.player.play();
        }
      } else {
        this.player.pause();
        this._playControl.visible = true;
        return (ref1 = this._pauseControl) != null ? ref1.visible = false : void 0;
      }
    });
    this.player.onplaying = (function(_this) {
      return function() {
        var ref;
        if (_this._pauseControl) {
          _this._playControl.visible = false;
        }
        return (ref = _this._pauseControl) != null ? ref.visible = true : void 0;
      };
    })(this);
    this.player.onended = (function(_this) {
      return function() {
        var ref;
        _this._playControl.visible = true;
        return (ref = _this._pauseControl) != null ? ref.visible = false : void 0;
      };
    })(this);
    this.player.formatTime = function() {
      var min, sec;
      sec = Math.floor(this.currentTime);
      min = Math.floor(sec / 60);
      sec = Math.floor(sec % 60);
      min = min >= 10 ? min : '0' + min;
      sec = sec >= 10 ? sec : '0' + sec;
      return min + ":" + sec;
    };
    this.player.formatTimeLeft = function() {
      var min, sec;
      sec = Math.floor(this.duration) - Math.floor(this.currentTime);
      min = Math.floor(sec / 60);
      sec = Math.floor(sec % 60);
      min = min >= 10 ? min : '0' + min;
      sec = sec >= 10 ? sec : '0' + sec;
      return min + ":" + sec;
    };
    this.audio = options.audio;
    this._element.appendChild(this.player);
  }

  Audio.define("audio", {
    get: function() {
      return this.player.src;
    },
    set: function(audio) {
      this.player.src = audio;
      if (this.player.canPlayType("audio/mp3") === "") {
        throw Error("No supported audio file included.");
      }
    }
  });

  Audio.prototype.addPlayLayer = function(layer) {
    this._playControl = layer;
    this._playControl.parent = this;
    this._playControl.name = "play";
    this._playControl.clip = true;
    return this._playControl;
  };

  Audio.prototype.addPauseLayer = function(layer) {
    this._pauseControl = layer;
    this._pauseControl.parent = this;
    this._pauseControl.name = "pause";
    this._pauseControl.clip = true;
    this._pauseControl.visible = false;
    return this._pauseControl;
  };

  Audio.prototype.getTime = function(layer) {
    if (!(layer instanceof TextLayer)) {
      throw new Error("AudioLayer expects a text layer.");
    }
    layer.text = "00:00";
    return this._time = layer;
  };

  Audio.prototype.getTimeLeft = function(layer) {
    layer.text = "-00:00";
    this._timeLeft = layer;
    return this.player.on("loadedmetadata", (function(_this) {
      return function() {
        return _this._timeLeft.text = "-" + _this.player.formatTimeLeft();
      };
    })(this));
  };

  Audio.prototype.setProgress = function(layer) {
    var currentKnob, isMoving, wasPlaying;
    this.player.oncanplay = (function(_this) {
      return function() {
        return layer.max = Math.round(_this.player.duration);
      };
    })(this);
    if (layer._knob) {
      currentKnob = layer._knob;
    } else {
      currentKnob = layer.knob;
    }
    currentKnob.draggable.momentum = false;
    wasPlaying = isMoving = false;
    if (!this.player.paused) {
      wasPlaying = true;
    }
    layer.on("change:value", (function(_this) {
      return function() {
        if (isMoving) {
          _this.player.currentTime = layer.value;
        }
        if (_this._time) {
          _this._time.text = _this.player.formatTime();
        }
        if (_this._timeLeft) {
          return _this._timeLeft.text = "-" + _this.player.formatTimeLeft();
        }
      };
    })(this));
    layer.onTapStart((function(_this) {
      return function() {
        return _this.player.currentTime = layer.value;
      };
    })(this));
    currentKnob.onDragMove((function(_this) {
      return function() {
        return isMoving = true;
      };
    })(this));
    currentKnob.onDragEnd((function(_this) {
      return function(event) {
        var currentTime, duration, ref;
        currentTime = Math.round(_this.player.currentTime);
        duration = Math.round(_this.player.duration);
        if (wasPlaying && currentTime !== duration) {
          _this.player.play();
        }
        if (currentTime === duration) {
          _this.player.pause();
          _this._playControl.visible = true;
          if ((ref = _this._pauseControl) != null) {
            ref.visible = false;
          }
        }
        return isMoving = false;
      };
    })(this));
    return this.player.ontimeupdate = (function(_this) {
      return function() {
        if (!isMoving) {
          currentKnob.midX = layer.pointForValue(_this.player.currentTime);
          isMoving = false;
        }
        if (_this._time) {
          _this._time.text = _this.player.formatTime();
        }
        if (_this._timeLeft) {
          return _this._timeLeft.text = "-" + _this.player.formatTimeLeft();
        }
      };
    })(this);
  };

  Audio.prototype.setVolume = function(layer) {
    var base, currentKnob;
    if ((base = this.player).volume == null) {
      base.volume = 0.75;
    }
    if (layer._knob) {
      currentKnob = layer._knob;
    } else {
      currentKnob = layer.knob;
    }
    layer.min = 0;
    layer.max = 1;
    layer.value = this.player.volume;
    currentKnob.draggable.momentum = false;
    return layer.on("change:value", (function(_this) {
      return function() {
        return _this.player.volume = layer.value;
      };
    })(this));
  };

  Audio.prototype.showProgress = function(layer) {
    return this.setProgress(layer);
  };

  Audio.prototype.showVolume = function(layer) {
    return this.setVolume(layer);
  };

  Audio.prototype.showTime = function(layer) {
    return this.getTime(layer);
  };

  Audio.prototype.showTimeLeft = function(layer) {
    return this.getTimeLeft(layer);
  };

  Audio.wrap = function(layerA, layerB, options) {
    return wrapLayer(new this(options), layerA, layerB, options);
  };

  return Audio;

})(Layer);

wrapLayer = function(instance, layerA, layerB) {
  var play;
  if (!(layerA instanceof Layer)) {
    throw new Error("AudioLayer expects a layer, not " + layerA + ". Are you sure the layer exists?");
  }
  play = instance;
  play.frame = layerA.frame;
  play.parent = layerA.parent;
  play.index = layerA.index;
  layerA.x = layerA.y = 0;
  if (layerB) {
    layerB.x = layerB.y = 0;
    play.addPauseLayer(layerB);
  }
  play.addPlayLayer(layerA);
  return play;
};


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL2R1Y2h1YW5odS9EZXNrdG9wLzEwMGRheXNfb2ZfZnJhbWVyL2RheTAyNV96YW9qaXVBdWRpb1BsYXllci5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiLCIuLi8uLi8uLi8uLi8uLi9Vc2Vycy9kdWNodWFuaHUvRGVza3RvcC8xMDBkYXlzX29mX2ZyYW1lci9kYXkwMjVfemFvaml1QXVkaW9QbGF5ZXIuZnJhbWVyL21vZHVsZXMvYXVkaW8uY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyIjIEFkZCB0aGUgZm9sbG93aW5nIGxpbmUgdG8geW91ciBwcm9qZWN0IGluIEZyYW1lciBTdHVkaW8uIFxuIyBteU1vZHVsZSA9IHJlcXVpcmUgXCJteU1vZHVsZVwiXG4jIFJlZmVyZW5jZSB0aGUgY29udGVudHMgYnkgbmFtZSwgbGlrZSBteU1vZHVsZS5teUZ1bmN0aW9uKCkgb3IgbXlNb2R1bGUubXlWYXJcblxuZXhwb3J0cy5teVZhciA9IFwibXlWYXJpYWJsZVwiXG5cbmV4cG9ydHMubXlGdW5jdGlvbiA9IC0+XG5cdHByaW50IFwibXlGdW5jdGlvbiBpcyBydW5uaW5nXCJcblxuZXhwb3J0cy5teUFycmF5ID0gWzEsIDIsIDNdIiwiIyBGcmFtZXIgQXVkaW8gTW9kdWxlXG4jIEJ5IEJlbmphbWluIGRlbiBCb2VyXG4jIENvbnRlbnRzOiBTbGlkZXIgYW5kIEF1ZGlvIENsYXNzXG4jIEZvbGxvdyBtZSBhdCBAYmVuamFtaW5uYXRoYW5cbiMgRm9sbG93IEZyYW1lciBhdCBAZnJhbWVyXG5cbkV2ZW50cy5TbGlkZXJWYWx1ZUNoYW5nZSAgPSBcInNsaWRlclZhbHVlQ2hhbmdlXCJcblxuY2xhc3MgZXhwb3J0cy5TbGlkZXIgZXh0ZW5kcyBMYXllclxuXG5cdGNvbnN0cnVjdG9yOiAob3B0aW9ucz17fSkgLT5cblx0XHRzdXBlciBvcHRpb25zXG5cblx0QF9rbm9iID0gdW5kZWZpbmVkXG5cdEBfZmlsbCA9IHVuZGVmaW5lZFxuXHRAX2JhY2tncm91bmQgPSB1bmRlZmluZWRcblxuXHRfdG91Y2hTdGFydDogKGV2ZW50KSA9PlxuXHRcdGV2ZW50LnByZXZlbnREZWZhdWx0KClcblxuXHRcdGlmIEBfYmFja2dyb3VuZC53aWR0aCA+IEBfYmFja2dyb3VuZC5oZWlnaHRcblx0XHRcdHRvdWNoWCA9IEV2ZW50cy50b3VjaEV2ZW50KGV2ZW50KS5jbGllbnRYIC0gU2NyZWVuLmNhbnZhc0ZyYW1lLnhcblx0XHRcdHNjYWxlWCA9IEBjYW52YXNTY2FsZVgoKVxuXHRcdFx0QHZhbHVlID0gQHZhbHVlRm9yUG9pbnQodG91Y2hYIC8gc2NhbGVYIC0gQHNjcmVlbkZyYW1lLngpXG5cdFx0ZWxzZVxuXHRcdFx0dG91Y2hZID0gRXZlbnRzLnRvdWNoRXZlbnQoZXZlbnQpLmNsaWVudFkgLSBTY3JlZW4uY2FudmFzRnJhbWUueVxuXHRcdFx0c2NhbGVZID0gQGNhbnZhc1NjYWxlWSgpXG5cdFx0XHRAdmFsdWUgPSBAdmFsdWVGb3JQb2ludCh0b3VjaFkgLyBzY2FsZVkgLSBAc2NyZWVuRnJhbWUueSlcblxuXHRcdEBfa25vYi5kcmFnZ2FibGUuX3RvdWNoU3RhcnQoZXZlbnQpXG5cdFx0QF91cGRhdGVWYWx1ZSgpXG5cblx0X3RvdWNoRW5kOiAoZXZlbnQpID0+XG5cdFx0QF91cGRhdGVWYWx1ZSgpXG5cblx0X3VwZGF0ZUZpbGw6ID0+XG5cdFx0aWYgQF9iYWNrZ3JvdW5kLndpZHRoID4gQF9iYWNrZ3JvdW5kLmhlaWdodFxuXHRcdFx0QF9maWxsLndpZHRoID0gQF9rbm9iLm1pZFhcblx0XHRlbHNlXG5cdFx0XHRAX2ZpbGwuaGVpZ2h0ID0gQF9rbm9iLm1pZFlcblxuXHRfdXBkYXRlS25vYjogPT5cblx0XHRpZiBAX2JhY2tncm91bmQud2lkdGggPiBAX2JhY2tncm91bmQuaGVpZ2h0XG5cdFx0XHRAX2tub2IubWlkWCA9IEBfZmlsbC53aWR0aFxuXHRcdFx0QF9rbm9iLmNlbnRlclkoKVxuXHRcdGVsc2Vcblx0XHRcdEBfa25vYi5taWRZID0gQF9maWxsLmhlaWdodFxuXHRcdFx0QF9rbm9iLmNlbnRlclgoKVxuXG5cdF91cGRhdGVGcmFtZTogPT5cblx0XHRAX2tub2IuZHJhZ2dhYmxlLmNvbnN0cmFpbnRzID1cblx0XHRcdHg6IC1rbm9iLndpZHRoIC8gMlxuXHRcdFx0eTogLWtub2IuaGVpZ2h0IC8gMlxuXHRcdFx0d2lkdGg6IEBfYmFja2dyb3VuZC53aWR0aCArIEBfa25vYi53aWR0aFxuXHRcdFx0aGVpZ2h0OiBAX2JhY2tncm91bmQuaGVpZ2h0ICsgQF9rbm9iLmhlaWdodFxuXG5cdFx0aWYgQGNvbnN0cmFpbmVkXG5cdFx0XHRAX2tub2IuZHJhZ2dhYmxlLmNvbnN0cmFpbnRzID1cblx0XHRcdFx0eDogMFxuXHRcdFx0XHR5OiAwXG5cdFx0XHRcdHdpZHRoOiBAX2JhY2tncm91bmQud2lkdGhcblx0XHRcdFx0aGVpZ2h0OiBAX2JhY2tncm91bmQuaGVpZ2h0XG5cblx0XHRpZiBAX2JhY2tncm91bmQud2lkdGggPiBAX2JhY2tncm91bmQuaGVpZ2h0XG5cdFx0XHRAX2ZpbGwuaGVpZ2h0ID0gQF9iYWNrZ3JvdW5kLmhlaWdodFxuXHRcdFx0QF9rbm9iLm1pZFggPSBAcG9pbnRGb3JWYWx1ZShAdmFsdWUpXG5cdFx0XHRAX2tub2IuY2VudGVyWSgpXG5cdFx0ZWxzZVxuXHRcdFx0QF9maWxsLndpZHRoID0gQF9iYWNrZ3JvdW5kLndpZHRoXG5cdFx0XHRAX2tub2IubWlkWSA9IEBwb2ludEZvclZhbHVlKEB2YWx1ZSlcblx0XHRcdEBfa25vYi5jZW50ZXJYKClcblxuXHRcdGlmIEBfYmFja2dyb3VuZC53aWR0aCA+IEBfYmFja2dyb3VuZC5oZWlnaHRcblx0XHRcdEBfa25vYi5kcmFnZ2FibGUuc3BlZWRZID0gMFxuXHRcdFx0QF9rbm9iLmRyYWdnYWJsZS5zcGVlZFggPSAxXG5cdFx0ZWxzZVxuXHRcdFx0QF9rbm9iLmRyYWdnYWJsZS5zcGVlZFggPSAwXG5cdFx0XHRAX2tub2IuZHJhZ2dhYmxlLnNwZWVkWSA9IDFcblxuXHRhZGRCYWNrZ3JvdW5kTGF5ZXI6IChsYXllcikgLT5cblx0XHRAX2JhY2tncm91bmQgPSBsYXllclxuXHRcdEBfYmFja2dyb3VuZC5wYXJlbnQgPSBAXG5cdFx0QF9iYWNrZ3JvdW5kLm5hbWUgPSBcImJhY2tncm91bmRcIlxuXHRcdEBfYmFja2dyb3VuZC54ID0gQF9iYWNrZ3JvdW5kLnkgPSAwXG5cdFx0cmV0dXJuIEBfYmFja2dyb3VuZFxuXG5cdGFkZEZpbGxMYXllcjogKGxheWVyKSAtPlxuXHRcdEBfZmlsbCA9IGxheWVyXG5cdFx0QF9maWxsLnBhcmVudCA9IEBcblx0XHRAX2ZpbGwubmFtZSA9IFwiZmlsbFwiXG5cdFx0QF9maWxsLnggPSBAX2ZpbGwueSA9IDBcblx0XHRAX2ZpbGwud2lkdGggPSBAd2lkdGggLyAyXG5cdFx0cmV0dXJuIEBfZmlsbFxuXG5cdGFkZEtub2JMYXllcjogKGxheWVyKSAtPlxuXHRcdEBfa25vYiA9IGxheWVyXG5cdFx0QF9rbm9iLnBhcmVudCA9IEBcblx0XHRAX2tub2IubmFtZSA9IFwia25vYlwiXG5cdFx0QF9rbm9iLmRyYWdnYWJsZS5lbmFibGVkID0gdHJ1ZVxuXHRcdEBfa25vYi5kcmFnZ2FibGUub3ZlcmRyYWcgPSBmYWxzZVxuXHRcdEBfa25vYi5kcmFnZ2FibGUubW9tZW50dW0gPSB0cnVlXG5cdFx0QF9rbm9iLmRyYWdnYWJsZS5tb21lbnR1bU9wdGlvbnMgPSB7ZnJpY3Rpb246IDUsIHRvbGVyYW5jZTogMC4yNX1cblx0XHRAX2tub2IuZHJhZ2dhYmxlLmJvdW5jZSA9IGZhbHNlXG5cdFx0QF9rbm9iLnggPSBBbGlnbi5jZW50ZXIoKVxuXHRcdEBfa25vYi55ID0gQWxpZ24uY2VudGVyKClcblxuXHRcdHJldHVybiBAX2tub2JcblxuXHRAZGVmaW5lIFwiY29uc3RyYWluZWRcIiwgQHNpbXBsZVByb3BlcnR5KFwiY29uc3RyYWluZWRcIiwgZmFsc2UpXG5cblx0QGRlZmluZSBcIm1pblwiLFxuXHRcdGdldDogLT4gQF9taW4gb3IgMFxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QF9taW4gPSB2YWx1ZSBpZiBfLmlzRmluaXRlKHZhbHVlKVxuXHRcdFx0QGVtaXQoXCJjaGFuZ2U6bWluXCIsIEBfbWluKVxuXG5cdEBkZWZpbmUgXCJtYXhcIixcblx0XHRnZXQ6IC0+IEBfbWF4IG9yIDFcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBfbWF4ID0gdmFsdWUgaWYgXy5pc0Zpbml0ZSh2YWx1ZSlcblx0XHRcdEBlbWl0KFwiY2hhbmdlOm1heFwiLCBAX21heClcblxuXHRAZGVmaW5lIFwidmFsdWVcIixcblx0XHRnZXQ6IC0+IHJldHVybiBAX3ZhbHVlXG5cdFx0c2V0OiAodmFsdWUpIC0+XG5cdFx0XHRyZXR1cm4gdW5sZXNzIF8uaXNGaW5pdGUodmFsdWUpXG5cblx0XHRcdEBfdmFsdWUgPSBVdGlscy5jbGFtcCh2YWx1ZSwgQG1pbiwgQG1heClcblxuXHRcdFx0aWYgQF9iYWNrZ3JvdW5kLndpZHRoID4gQF9iYWNrZ3JvdW5kLmhlaWdodFxuXHRcdFx0XHRAX2tub2IubWlkWCA9IEBwb2ludEZvclZhbHVlKHZhbHVlKVxuXHRcdFx0ZWxzZVxuXHRcdFx0XHRAX2tub2IubWlkWSA9IEBwb2ludEZvclZhbHVlKHZhbHVlKVxuXG5cdFx0XHRAX3VwZGF0ZUZpbGwoKVxuXHRcdFx0QF91cGRhdGVWYWx1ZSgpXG5cblx0X2tub2JEaWRNb3ZlOiA9PlxuXHRcdGlmIEBfYmFja2dyb3VuZC53aWR0aCA+IEBfYmFja2dyb3VuZC5oZWlnaHRcblx0XHRcdEB2YWx1ZSA9IEB2YWx1ZUZvclBvaW50KEBfa25vYi5taWRYKVxuXHRcdGVsc2Vcblx0XHRcdEB2YWx1ZSA9IEB2YWx1ZUZvclBvaW50KEBfa25vYi5taWRZKVxuXG5cdF91cGRhdGVWYWx1ZTogPT5cblx0XHRyZXR1cm4gaWYgQF9sYXN0VXBkYXRlZFZhbHVlIGlzIEB2YWx1ZVxuXG5cdFx0QF9sYXN0VXBkYXRlZFZhbHVlID0gQHZhbHVlXG5cdFx0QGVtaXQoXCJjaGFuZ2U6dmFsdWVcIiwgQHZhbHVlKVxuXHRcdEBlbWl0KEV2ZW50cy5TbGlkZXJWYWx1ZUNoYW5nZSwgQHZhbHVlKVxuXG5cdHBvaW50Rm9yVmFsdWU6ICh2YWx1ZSkgLT5cblx0XHRpZiBAX2JhY2tncm91bmQud2lkdGggPiBAX2JhY2tncm91bmQuaGVpZ2h0XG5cdFx0XHRpZiBAY29uc3RyYWluZWRcblx0XHRcdFx0cmV0dXJuIFV0aWxzLm1vZHVsYXRlKHZhbHVlLCBbQG1pbiwgQG1heF0sIFswICsgKEBfa25vYi53aWR0aCAvIDIpLCBAX2JhY2tncm91bmQud2lkdGggLSAoQF9rbm9iLndpZHRoIC8gMildLCB0cnVlKVxuXHRcdFx0ZWxzZVxuXHRcdFx0XHRyZXR1cm4gVXRpbHMubW9kdWxhdGUodmFsdWUsIFtAbWluLCBAbWF4XSwgWzAsIEBfYmFja2dyb3VuZC53aWR0aF0sIHRydWUpXG5cdFx0ZWxzZVxuXHRcdFx0aWYgQGNvbnN0cmFpbmVkXG5cdFx0XHRcdHJldHVybiBVdGlscy5tb2R1bGF0ZSh2YWx1ZSwgW0BtaW4sIEBtYXhdLCBbMCArIChAX2tub2IuaGVpZ2h0IC8gMiksIEBfYmFja2dyb3VuZC5oZWlnaHQgLSAoQF9rbm9iLmhlaWdodCAvIDIpXSwgdHJ1ZSlcblx0XHRcdGVsc2Vcblx0XHRcdFx0cmV0dXJuIFV0aWxzLm1vZHVsYXRlKHZhbHVlLCBbQG1pbiwgQG1heF0sIFswLCBAX2JhY2tncm91bmQuaGVpZ2h0XSwgdHJ1ZSlcblxuXHR2YWx1ZUZvclBvaW50OiAodmFsdWUpIC0+XG5cdFx0aWYgQF9iYWNrZ3JvdW5kLndpZHRoID4gQF9iYWNrZ3JvdW5kLmhlaWdodFxuXHRcdFx0aWYgQGNvbnN0cmFpbmVkXG5cdFx0XHRcdHJldHVybiBVdGlscy5tb2R1bGF0ZSh2YWx1ZSwgWzAgKyAoQF9rbm9iLndpZHRoIC8gMiksIEBfYmFja2dyb3VuZC53aWR0aCAtIChAX2tub2Iud2lkdGggLyAyKV0sIFtAbWluLCBAbWF4XSwgdHJ1ZSlcblx0XHRcdGVsc2Vcblx0XHRcdFx0cmV0dXJuIFV0aWxzLm1vZHVsYXRlKHZhbHVlLCBbMCwgQF9iYWNrZ3JvdW5kLndpZHRoXSwgW0BtaW4sIEBtYXhdLCB0cnVlKVxuXHRcdGVsc2Vcblx0XHRcdGlmIEBjb25zdHJhaW5lZFxuXHRcdFx0XHRyZXR1cm4gVXRpbHMubW9kdWxhdGUodmFsdWUsIFswICsgKEBfa25vYi5oZWlnaHQgLyAyKSwgQF9iYWNrZ3JvdW5kLmhlaWdodCAtIChAX2tub2IuaGVpZ2h0IC8gMildLCBbQG1pbiwgQG1heF0sIHRydWUpXG5cdFx0XHRlbHNlXG5cdFx0XHRcdHJldHVybiBVdGlscy5tb2R1bGF0ZSh2YWx1ZSwgWzAsIEBfYmFja2dyb3VuZC5oZWlnaHRdLCBbQG1pbiwgQG1heF0sIHRydWUpXG5cblx0IyBOZXcgQ29uc3RydWN0b3Jcblx0QHdyYXAgPSAoYmFja2dyb3VuZCwgZmlsbCwga25vYiwgb3B0aW9ucykgLT5cblx0XHRyZXR1cm4gd3JhcFNsaWRlcihuZXcgQChvcHRpb25zKSwgYmFja2dyb3VuZCwgZmlsbCwga25vYiwgb3B0aW9ucylcblxuXHRvblZhbHVlQ2hhbmdlOiAoY2IpIC0+IEBvbihFdmVudHMuU2xpZGVyVmFsdWVDaGFuZ2UsIGNiKVxuXG53cmFwU2xpZGVyID0gKGluc3RhbmNlLCBiYWNrZ3JvdW5kLCBmaWxsLCBrbm9iKSAtPlxuXG5cdGlmIG5vdCAoYmFja2dyb3VuZCBpbnN0YW5jZW9mIExheWVyKVxuXHRcdHRocm93IG5ldyBFcnJvcihcIkF1ZGlvTGF5ZXIgZXhwZWN0cyBhIGJhY2tncm91bmQgbGF5ZXIuXCIpXG5cblx0aWYgbm90IChmaWxsIGluc3RhbmNlb2YgTGF5ZXIpXG5cdFx0dGhyb3cgbmV3IEVycm9yKFwiQXVkaW9MYXllciBleHBlY3RzIGEgZmlsbCBsYXllci5cIilcblxuXHRpZiBub3QgKGtub2IgaW5zdGFuY2VvZiBMYXllcilcblx0XHR0aHJvdyBuZXcgRXJyb3IoXCJBdWRpb0xheWVyIGV4cGVjdHMgYSBrbm9iIGxheWVyLlwiKVxuXG5cdHNsaWRlciA9IGluc3RhbmNlXG5cblx0c2xpZGVyLmNsaXAgPSBmYWxzZVxuXHRzbGlkZXIuYmFja2dyb3VuZENvbG9yID0gXCJ0cmFuc3BhcmVudFwiXG5cdHNsaWRlci5mcmFtZSA9IGJhY2tncm91bmQuZnJhbWVcblx0c2xpZGVyLnBhcmVudCA9IGJhY2tncm91bmQucGFyZW50XG5cdHNsaWRlci5pbmRleCA9IGJhY2tncm91bmQuaW5kZXhcblxuXHRzbGlkZXIuYWRkQmFja2dyb3VuZExheWVyKGJhY2tncm91bmQpXG5cdHNsaWRlci5hZGRGaWxsTGF5ZXIoZmlsbClcblx0c2xpZGVyLmFkZEtub2JMYXllcihrbm9iKVxuXG5cdHNsaWRlci5fdXBkYXRlRnJhbWUoKVxuXHRzbGlkZXIuX3VwZGF0ZUtub2IoKVxuXHRzbGlkZXIuX3VwZGF0ZUZpbGwoKVxuXHRzbGlkZXIuX2tub2JEaWRNb3ZlKClcblxuXHRiYWNrZ3JvdW5kLm9uVGFwU3RhcnQgLT5cblx0XHRzbGlkZXIuX3RvdWNoU3RhcnQoZXZlbnQpXG5cblx0c2xpZGVyLm9uIFwiY2hhbmdlOmZyYW1lXCIsIC0+XG5cdFx0c2xpZGVyLl91cGRhdGVGcmFtZSgpXG5cblx0a25vYi5vbiBcImNoYW5nZTpzaXplXCIsIC0+XG5cdFx0c2xpZGVyLl91cGRhdGVLbm9iKClcblxuXHRrbm9iLm9uIFwiY2hhbmdlOmZyYW1lXCIsIC0+XG5cdFx0c2xpZGVyLl91cGRhdGVGaWxsKClcblx0XHRzbGlkZXIuX2tub2JEaWRNb3ZlKClcblxuXHRzbGlkZXIub24gXCJjaGFuZ2U6bWF4XCIsIC0+XG5cdFx0c2xpZGVyLl91cGRhdGVGcmFtZSgpXG5cdFx0c2xpZGVyLl91cGRhdGVLbm9iKClcblx0XHRzbGlkZXIuX3VwZGF0ZUZpbGwoKVxuXHRcdHNsaWRlci5fa25vYkRpZE1vdmUoKVxuXG5cdHJldHVybiBzbGlkZXJcblxuY2xhc3MgZXhwb3J0cy5BdWRpbyBleHRlbmRzIExheWVyXG5cblx0Y29uc3RydWN0b3I6IChvcHRpb25zPXt9KSAtPlxuXHRcdG9wdGlvbnMuYmFja2dyb3VuZENvbG9yID89IFwidHJhbnNwYXJlbnRcIlxuXG5cdFx0IyBEZWZpbmUgcGxheWVyXG5cdFx0QHBsYXllciA9IGRvY3VtZW50LmNyZWF0ZUVsZW1lbnQoXCJhdWRpb1wiKVxuXHRcdEBwbGF5ZXIuc2V0QXR0cmlidXRlKFwid2Via2l0LXBsYXlzaW5saW5lXCIsIFwidHJ1ZVwiKVxuXHRcdEBwbGF5ZXIuc2V0QXR0cmlidXRlKFwicHJlbG9hZFwiLCBcImF1dG9cIilcblxuXHRcdEBwbGF5ZXIub24gPSBAcGxheWVyLmFkZEV2ZW50TGlzdGVuZXJcblx0XHRAcGxheWVyLm9mZiA9IEBwbGF5ZXIucmVtb3ZlRXZlbnRMaXN0ZW5lclxuXG5cdFx0QF90aW1lID0gZmFsc2VcblxuXHRcdHN1cGVyIG9wdGlvbnNcblxuXHRcdCMgT24gY2xpY2tcblx0XHRAb25DbGljayAtPlxuXHRcdFx0Y3VycmVudFRpbWUgPSBNYXRoLnJvdW5kKEBwbGF5ZXIuY3VycmVudFRpbWUpXG5cdFx0XHRkdXJhdGlvbiA9IE1hdGgucm91bmQoQHBsYXllci5kdXJhdGlvbilcblxuXHRcdFx0aWYgQHBsYXllci5wYXVzZWRcblx0XHRcdFx0QHBsYXllci5wbGF5KClcblx0XHRcdFx0aWYgQF9wYXVzZUNvbnRyb2wgdGhlbiBAX3BsYXlDb250cm9sLnZpc2libGUgPSBmYWxzZVxuXHRcdFx0XHRAX3BhdXNlQ29udHJvbD8udmlzaWJsZSA9IHRydWVcblxuXHRcdFx0XHRpZiBjdXJyZW50VGltZSBpcyBkdXJhdGlvblxuXHRcdFx0XHRcdEBwbGF5ZXIuY3VycmVudFRpbWUgPSAwXG5cdFx0XHRcdFx0QHBsYXllci5wbGF5KClcblx0XHRcdGVsc2Vcblx0XHRcdFx0QHBsYXllci5wYXVzZSgpXG5cdFx0XHRcdEBfcGxheUNvbnRyb2wudmlzaWJsZSA9IHRydWVcblx0XHRcdFx0QF9wYXVzZUNvbnRyb2w/LnZpc2libGUgPSBmYWxzZVxuXG5cdFx0QHBsYXllci5vbnBsYXlpbmcgPSA9PlxuXHRcdFx0aWYgQF9wYXVzZUNvbnRyb2wgdGhlbiBAX3BsYXlDb250cm9sLnZpc2libGUgPSBmYWxzZVxuXHRcdFx0QF9wYXVzZUNvbnRyb2w/LnZpc2libGUgPSB0cnVlXG5cblx0XHRAcGxheWVyLm9uZW5kZWQgPSA9PlxuXHRcdFx0QF9wbGF5Q29udHJvbC52aXNpYmxlID0gdHJ1ZVxuXHRcdFx0QF9wYXVzZUNvbnRyb2w/LnZpc2libGUgPSBmYWxzZVxuXG5cblx0XHQjIFV0aWxzXG5cdFx0QHBsYXllci5mb3JtYXRUaW1lID0gLT5cblx0XHRcdHNlYyA9IE1hdGguZmxvb3IoQGN1cnJlbnRUaW1lKVxuXHRcdFx0bWluID0gTWF0aC5mbG9vcihzZWMgLyA2MClcblx0XHRcdHNlYyA9IE1hdGguZmxvb3Ioc2VjICUgNjApXG5cdFx0XHRtaW4gPSBpZiBtaW4gPj0gMTAgdGhlbiBtaW4gZWxzZSAnMCcgKyBtaW5cblx0XHRcdHNlYyA9IGlmIHNlYyA+PSAxMCB0aGVuIHNlYyBlbHNlICcwJyArIHNlY1xuXHRcdFx0cmV0dXJuIFwiI3ttaW59OiN7c2VjfVwiXG5cblx0XHRAcGxheWVyLmZvcm1hdFRpbWVMZWZ0ID0gLT5cblx0XHRcdHNlYyA9IE1hdGguZmxvb3IoQGR1cmF0aW9uKSAtIE1hdGguZmxvb3IoQGN1cnJlbnRUaW1lKVxuXHRcdFx0bWluID0gTWF0aC5mbG9vcihzZWMgLyA2MClcblx0XHRcdHNlYyA9IE1hdGguZmxvb3Ioc2VjICUgNjApXG5cdFx0XHRtaW4gPSBpZiBtaW4gPj0gMTAgdGhlbiBtaW4gZWxzZSAnMCcgKyBtaW5cblx0XHRcdHNlYyA9IGlmIHNlYyA+PSAxMCB0aGVuIHNlYyBlbHNlICcwJyArIHNlY1xuXHRcdFx0cmV0dXJuIFwiI3ttaW59OiN7c2VjfVwiXG5cblx0XHRAYXVkaW8gPSBvcHRpb25zLmF1ZGlvXG5cdFx0QF9lbGVtZW50LmFwcGVuZENoaWxkKEBwbGF5ZXIpXG5cblx0QGRlZmluZSBcImF1ZGlvXCIsXG5cdFx0Z2V0OiAtPiBAcGxheWVyLnNyY1xuXHRcdHNldDogKGF1ZGlvKSAtPlxuXHRcdFx0QHBsYXllci5zcmMgPSBhdWRpb1xuXHRcdFx0aWYgQHBsYXllci5jYW5QbGF5VHlwZShcImF1ZGlvL21wM1wiKSA9PSBcIlwiXG5cdFx0XHRcdHRocm93IEVycm9yIFwiTm8gc3VwcG9ydGVkIGF1ZGlvIGZpbGUgaW5jbHVkZWQuXCJcblxuXHQjIEF0dGFjaCBhIGxheWVyIHRvIHRoZSBBdWRpbyBvYmplY3Rcblx0YWRkUGxheUxheWVyOiAobGF5ZXIpIC0+XG5cdFx0QF9wbGF5Q29udHJvbCA9IGxheWVyXG5cdFx0QF9wbGF5Q29udHJvbC5wYXJlbnQgPSBAXG5cdFx0QF9wbGF5Q29udHJvbC5uYW1lID0gXCJwbGF5XCJcblx0XHRAX3BsYXlDb250cm9sLmNsaXAgPSB0cnVlXG5cblx0XHRyZXR1cm4gQF9wbGF5Q29udHJvbFxuXG5cdGFkZFBhdXNlTGF5ZXI6IChsYXllcikgLT5cblx0XHRAX3BhdXNlQ29udHJvbCA9IGxheWVyXG5cdFx0QF9wYXVzZUNvbnRyb2wucGFyZW50ID0gQFxuXHRcdEBfcGF1c2VDb250cm9sLm5hbWUgPSBcInBhdXNlXCJcblx0XHRAX3BhdXNlQ29udHJvbC5jbGlwID0gdHJ1ZVxuXHRcdEBfcGF1c2VDb250cm9sLnZpc2libGUgPSBmYWxzZVxuXG5cdFx0cmV0dXJuIEBfcGF1c2VDb250cm9sXG5cblx0Z2V0VGltZTogKGxheWVyKSAtPlxuXHRcdGlmIG5vdCAobGF5ZXIgaW5zdGFuY2VvZiBUZXh0TGF5ZXIpXG5cdFx0XHR0aHJvdyBuZXcgRXJyb3IoXCJBdWRpb0xheWVyIGV4cGVjdHMgYSB0ZXh0IGxheWVyLlwiKVxuXG5cdFx0bGF5ZXIudGV4dCA9IFwiMDA6MDBcIlxuXG5cdFx0QF90aW1lID0gbGF5ZXJcblxuXHRnZXRUaW1lTGVmdDogKGxheWVyKSA9PlxuXHRcdCMgU2V0IHRpbWVMZWZ0XG5cdFx0bGF5ZXIudGV4dCA9IFwiLTAwOjAwXCJcblxuXHRcdEBfdGltZUxlZnQgPSBsYXllclxuXG5cdFx0QHBsYXllci5vbiBcImxvYWRlZG1ldGFkYXRhXCIsID0+XG5cdFx0XHRAX3RpbWVMZWZ0LnRleHQgPSBcIi1cIiArIEBwbGF5ZXIuZm9ybWF0VGltZUxlZnQoKVxuXG5cdHNldFByb2dyZXNzOiAobGF5ZXIpIC0+XG5cblx0XHRAcGxheWVyLm9uY2FucGxheSA9ID0+XG5cdFx0XHRsYXllci5tYXggPSBNYXRoLnJvdW5kKEBwbGF5ZXIuZHVyYXRpb24pXG5cblx0XHQjIERlc2lnbiBsYXllciBrbm9iIG9yIGNvZGUgbGF5ZXIga25vYlxuXHRcdGlmIGxheWVyLl9rbm9iXG5cdFx0XHRjdXJyZW50S25vYiA9IGxheWVyLl9rbm9iXG5cdFx0ZWxzZVxuXHRcdFx0Y3VycmVudEtub2IgPSBsYXllci5rbm9iXG5cblx0XHRjdXJyZW50S25vYi5kcmFnZ2FibGUubW9tZW50dW0gPSBmYWxzZVxuXG5cdFx0IyBDaGVjayBpZiB0aGUgcGxheWVyIHdhcyBwbGF5aW5nXG5cdFx0d2FzUGxheWluZyA9IGlzTW92aW5nID0gZmFsc2Vcblx0XHR1bmxlc3MgQHBsYXllci5wYXVzZWQgdGhlbiB3YXNQbGF5aW5nID0gdHJ1ZVxuXG5cdFx0bGF5ZXIub24gXCJjaGFuZ2U6dmFsdWVcIiwgPT5cblx0XHRcdGlmIGlzTW92aW5nXG5cdFx0XHRcdEBwbGF5ZXIuY3VycmVudFRpbWUgPSBsYXllci52YWx1ZVxuXG5cdFx0XHRpZiBAX3RpbWVcblx0XHRcdFx0QF90aW1lLnRleHQgPSBAcGxheWVyLmZvcm1hdFRpbWUoKVxuXHRcdFx0aWYgQF90aW1lTGVmdFxuXHRcdFx0XHRAX3RpbWVMZWZ0LnRleHQgPSBcIi1cIiArIEBwbGF5ZXIuZm9ybWF0VGltZUxlZnQoKVxuXG5cdFx0bGF5ZXIub25UYXBTdGFydCA9PlxuXHRcdFx0QHBsYXllci5jdXJyZW50VGltZSA9IGxheWVyLnZhbHVlXG5cdFx0Y3VycmVudEtub2Iub25EcmFnTW92ZSA9PlxuXHRcdFx0aXNNb3ZpbmcgPSB0cnVlXG5cblx0XHRjdXJyZW50S25vYi5vbkRyYWdFbmQgKGV2ZW50KSA9PlxuXHRcdFx0Y3VycmVudFRpbWUgPSBNYXRoLnJvdW5kKEBwbGF5ZXIuY3VycmVudFRpbWUpXG5cdFx0XHRkdXJhdGlvbiA9IE1hdGgucm91bmQoQHBsYXllci5kdXJhdGlvbilcblxuXHRcdFx0aWYgd2FzUGxheWluZyBhbmQgY3VycmVudFRpbWUgaXNudCBkdXJhdGlvblxuXHRcdFx0XHRAcGxheWVyLnBsYXkoKVxuXG5cdFx0XHRpZiBjdXJyZW50VGltZSBpcyBkdXJhdGlvblxuXHRcdFx0XHRAcGxheWVyLnBhdXNlKClcblx0XHRcdFx0QF9wbGF5Q29udHJvbC52aXNpYmxlID0gdHJ1ZVxuXHRcdFx0XHRAX3BhdXNlQ29udHJvbD8udmlzaWJsZSA9IGZhbHNlXG5cblx0XHRcdHJldHVybiBpc01vdmluZyA9IGZhbHNlXG5cblx0XHQjIFVwZGF0ZSBQcm9ncmVzc1xuXHRcdEBwbGF5ZXIub250aW1ldXBkYXRlID0gPT5cblxuXHRcdFx0dW5sZXNzIGlzTW92aW5nXG5cdFx0XHRcdGN1cnJlbnRLbm9iLm1pZFggPSBsYXllci5wb2ludEZvclZhbHVlKEBwbGF5ZXIuY3VycmVudFRpbWUpXG5cdFx0XHRcdGlzTW92aW5nID0gZmFsc2VcblxuXHRcdFx0aWYgQF90aW1lXG5cdFx0XHRcdEBfdGltZS50ZXh0ID0gQHBsYXllci5mb3JtYXRUaW1lKClcblx0XHRcdGlmIEBfdGltZUxlZnRcblx0XHRcdFx0QF90aW1lTGVmdC50ZXh0ID0gXCItXCIgKyBAcGxheWVyLmZvcm1hdFRpbWVMZWZ0KClcblxuXHRzZXRWb2x1bWU6IChsYXllcikgLT5cblxuXHRcdCMgU2V0IGRlZmF1bHQgdG8gNzUlXG5cdFx0QHBsYXllci52b2x1bWUgPz0gMC43NVxuXG5cdFx0IyBEZXNpZ24gbGF5ZXIga25vYiBvciBjb2RlIGxheWVyIGtub2Jcblx0XHRpZiBsYXllci5fa25vYlxuXHRcdFx0Y3VycmVudEtub2IgPSBsYXllci5fa25vYlxuXHRcdGVsc2Vcblx0XHRcdGN1cnJlbnRLbm9iID0gbGF5ZXIua25vYlxuXG5cdFx0bGF5ZXIubWluID0gMFxuXHRcdGxheWVyLm1heCA9IDFcblx0XHRsYXllci52YWx1ZSA9IEBwbGF5ZXIudm9sdW1lXG5cblx0XHRjdXJyZW50S25vYi5kcmFnZ2FibGUubW9tZW50dW0gPSBmYWxzZVxuXG5cdFx0bGF5ZXIub24gXCJjaGFuZ2U6dmFsdWVcIiwgPT5cblx0XHRcdEBwbGF5ZXIudm9sdW1lID0gbGF5ZXIudmFsdWVcblxuXHRzaG93UHJvZ3Jlc3M6IChsYXllcikgLT5cblx0XHRyZXR1cm4gQHNldFByb2dyZXNzKGxheWVyKVxuXG5cdHNob3dWb2x1bWU6IChsYXllcikgLT5cblx0XHRyZXR1cm4gQHNldFZvbHVtZShsYXllcilcblxuXHRzaG93VGltZTogKGxheWVyKSAtPlxuXHRcdHJldHVybiBAZ2V0VGltZShsYXllcilcblxuXHRzaG93VGltZUxlZnQ6IChsYXllcikgLT5cblx0XHRyZXR1cm4gQGdldFRpbWVMZWZ0KGxheWVyKVxuXG5cdEB3cmFwID0gKGxheWVyQSwgbGF5ZXJCLCBvcHRpb25zKSAtPlxuXHRcdHJldHVybiB3cmFwTGF5ZXIobmV3IEAob3B0aW9ucyksIGxheWVyQSwgbGF5ZXJCLCBvcHRpb25zKVxuXG53cmFwTGF5ZXIgPSAoaW5zdGFuY2UsIGxheWVyQSwgbGF5ZXJCKSAtPlxuXG5cdGlmIG5vdCAobGF5ZXJBIGluc3RhbmNlb2YgTGF5ZXIpXG5cdFx0dGhyb3cgbmV3IEVycm9yKFwiQXVkaW9MYXllciBleHBlY3RzIGEgbGF5ZXIsIG5vdCAje2xheWVyQX0uIEFyZSB5b3Ugc3VyZSB0aGUgbGF5ZXIgZXhpc3RzP1wiKVxuXG5cdHBsYXkgPSBpbnN0YW5jZVxuXHRwbGF5LmZyYW1lID0gbGF5ZXJBLmZyYW1lXG5cdHBsYXkucGFyZW50ID0gbGF5ZXJBLnBhcmVudFxuXHRwbGF5LmluZGV4ID0gbGF5ZXJBLmluZGV4XG5cdGxheWVyQS54ID0gbGF5ZXJBLnkgPSAwXG5cblx0aWYgbGF5ZXJCXG5cdFx0bGF5ZXJCLnggPSBsYXllckIueSA9IDBcblx0XHRwbGF5LmFkZFBhdXNlTGF5ZXIobGF5ZXJCKVxuXG5cdHBsYXkuYWRkUGxheUxheWVyKGxheWVyQSlcblxuXHRyZXR1cm4gcGxheSIsIihmdW5jdGlvbiBlKHQsbixyKXtmdW5jdGlvbiBzKG8sdSl7aWYoIW5bb10pe2lmKCF0W29dKXt2YXIgYT10eXBlb2YgcmVxdWlyZT09XCJmdW5jdGlvblwiJiZyZXF1aXJlO2lmKCF1JiZhKXJldHVybiBhKG8sITApO2lmKGkpcmV0dXJuIGkobywhMCk7dmFyIGY9bmV3IEVycm9yKFwiQ2Fubm90IGZpbmQgbW9kdWxlICdcIitvK1wiJ1wiKTt0aHJvdyBmLmNvZGU9XCJNT0RVTEVfTk9UX0ZPVU5EXCIsZn12YXIgbD1uW29dPXtleHBvcnRzOnt9fTt0W29dWzBdLmNhbGwobC5leHBvcnRzLGZ1bmN0aW9uKGUpe3ZhciBuPXRbb11bMV1bZV07cmV0dXJuIHMobj9uOmUpfSxsLGwuZXhwb3J0cyxlLHQsbixyKX1yZXR1cm4gbltvXS5leHBvcnRzfXZhciBpPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7Zm9yKHZhciBvPTA7bzxyLmxlbmd0aDtvKyspcyhyW29dKTtyZXR1cm4gc30pIl0sIm5hbWVzIjpbXSwibWFwcGluZ3MiOiJBRUFBO0FETUEsSUFBQSxxQkFBQTtFQUFBOzs7O0FBQUEsTUFBTSxDQUFDLGlCQUFQLEdBQTRCOztBQUV0QixPQUFPLENBQUM7OztFQUVBLGdCQUFDLE9BQUQ7O01BQUMsVUFBUTs7Ozs7Ozs7O0lBQ3JCLHdDQUFNLE9BQU47RUFEWTs7RUFHYixNQUFDLENBQUEsS0FBRCxHQUFTOztFQUNULE1BQUMsQ0FBQSxLQUFELEdBQVM7O0VBQ1QsTUFBQyxDQUFBLFdBQUQsR0FBZTs7bUJBRWYsV0FBQSxHQUFhLFNBQUMsS0FBRDtBQUNaLFFBQUE7SUFBQSxLQUFLLENBQUMsY0FBTixDQUFBO0lBRUEsSUFBRyxJQUFDLENBQUEsV0FBVyxD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
