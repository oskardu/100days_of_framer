require=(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({"input":[function(require,module,exports){
var wrapInput,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

Events.EnterKey = "EnterKey";

Events.SpaceKey = "SpaceKey";

Events.BackspaceKey = "BackspaceKey";

Events.CapsLockKey = "CapsLockKey";

Events.ShiftKey = "ShiftKey";

Events.ValueChange = "ValueChange";

Events.InputFocus = "InputFocus";

Events.InputBlur = "InputBlur";

exports.InputLayer = (function(superClass) {
  extend(InputLayer, superClass);

  function InputLayer(options) {
    var base, currentValue, property, textProperties, value;
    if (options == null) {
      options = {};
    }
    this._setTextProperties = bind(this._setTextProperties, this);
    this._setPlaceholder = bind(this._setPlaceholder, this);
    _.defaults(options, {
      backgroundColor: "#FFF",
      width: 375,
      height: 60,
      padding: {
        left: 20
      },
      text: "Type something...",
      fontSize: 40,
      fontWeight: 300
    });
    if (options.multiLine) {
      if ((base = options.padding).top == null) {
        base.top = 20;
      }
    }
    this._inputElement = document.createElement("input");
    this._inputElement.style.position = "absolute";
    InputLayer.__super__.constructor.call(this, options);
    this._background = void 0;
    this._placeholder = void 0;
    this._isDesignLayer = false;
    this.input = new Layer({
      backgroundColor: "transparent",
      name: "input",
      width: this.width,
      height: this.height,
      parent: this
    });
    if (this.multiLine) {
      this._inputElement = document.createElement("textarea");
    }
    this.input._element.appendChild(this._inputElement);
    this._setTextProperties(this);
    this._inputElement.autocomplete = "off";
    this._inputElement.autocorrect = "off";
    this._inputElement.spellcheck = false;
    this._inputElement.className = "input" + this.id;
    textProperties = {
      text: this.text,
      fontFamily: this.fontFamily,
      fontSize: this.fontSize,
      lineHeight: this.lineHeight,
      fontWeight: this.fontWeight,
      color: this.color,
      backgroundColor: this.backgroundColor,
      width: this.width,
      height: this.height,
      padding: this.padding,
      parent: this.parent
    };
    for (property in textProperties) {
      value = textProperties[property];
      this.on("change:" + property, (function(_this) {
        return function(value) {
          _this._elementHTML.children[0].textContent = "";
          if (_this._isDesignLayer) {
            return;
          }
          _this._setTextProperties(_this);
          return _this._setPlaceholderColor(_this._id, _this.color);
        };
      })(this));
    }
    this._setPlaceholder(this.text);
    this._setPlaceholderColor(this._id, this.color);
    this._elementHTML.children[0].textContent = "";
    this._isFocused = false;
    this._inputElement.onfocus = (function(_this) {
      return function(e) {
        if (_this.focusColor == null) {
          _this.focusColor = "#000";
        }
        _this.emit(Events.InputFocus, event);
        return _this._isFocused = true;
      };
    })(this);
    this._inputElement.onblur = (function(_this) {
      return function(e) {
        _this.emit(Events.InputBlur, event);
        return _this._isFocused = false;
      };
    })(this);
    currentValue = void 0;
    this._inputElement.onkeydown = (function(_this) {
      return function(e) {
        currentValue = _this.value;
        if (e.which === 20) {
          _this.emit(Events.CapsLockKey, event);
        }
        if (e.which === 16) {
          return _this.emit(Events.ShiftKey, event);
        }
      };
    })(this);
    this._inputElement.onkeyup = (function(_this) {
      return function(e) {
        if (currentValue !== _this.value) {
          _this.emit("change:value", _this.value);
          _this.emit(Events.ValueChange, _this.value);
        }
        if (e.which === 13) {
          _this.emit(Events.EnterKey, event);
        }
        if (e.which === 8) {
          _this.emit(Events.BackspaceKey, event);
        }
        if (e.which === 32) {
          _this.emit(Events.SpaceKey, event);
        }
        if (e.which === 20) {
          return _this.emit(Events.CapsLockKey, event);
        }
      };
    })(this);
  }

  InputLayer.prototype._setPlaceholder = function(text) {
    return this._inputElement.placeholder = text;
  };

  InputLayer.prototype._setPlaceholderColor = function(id, color) {
    return document.styleSheets[0].addRule(".input" + id + "::-webkit-input-placeholder", "color: " + color);
  };

  InputLayer.prototype._checkDevicePixelRatio = function() {
    var dpr, ratio;
    ratio = Screen.width / Framer.Device.screen.width;
    if (Utils.isDesktop()) {
      if (ratio < 0.5 && ratio > 0.25) {
        dpr = 1 - ratio;
      } else if (ratio === 0.25) {
        dpr = 1 - (ratio * 2);
      } else {
        dpr = Utils.devicePixelRatio();
      }
      if (Framer.Device.deviceType === "fullscreen") {
        dpr = 2;
      }
    } else {
      if (ratio < 0.5 && ratio > 0.25) {
        dpr = 1 - ratio;
      } else if (ratio === 0.25) {
        dpr = 1 - (ratio * 2);
      } else if (ratio === 0.5) {
        dpr = 1;
      }
    }
    return dpr;
  };

  InputLayer.prototype._setTextProperties = function(layer) {
    var dpr, ref;
    dpr = this._checkDevicePixelRatio();
    if (!this._isDesignLayer) {
      this._inputElement.style.fontFamily = layer.fontFamily;
      this._inputElement.style.fontSize = (layer.fontSize / dpr) + "px";
      this._inputElement.style.fontWeight = (ref = layer.fontWeight) != null ? ref : "normal";
      this._inputElement.style.paddingTop = (layer.padding.top * 2 / dpr) + "px";
      this._inputElement.style.paddingRight = (layer.padding.bottom * 2 / dpr) + "px";
      this._inputElement.style.paddingBottom = (layer.padding.right * 2 / dpr) + "px";
      this._inputElement.style.paddingLeft = (layer.padding.left * 2 / dpr) + "px";
    }
    this._inputElement.style.width = ((layer.width - layer.padding.left * 2) * 2 / dpr) + "px";
    this._inputElement.style.height = (layer.height * 2 / dpr) + "px";
    this._inputElement.style.outline = "none";
    this._inputElement.style.backgroundColor = "transparent";
    this._inputElement.style.cursor = "auto";
    this._inputElement.style.webkitAppearance = "none";
    this._inputElement.style.resize = "none";
    this._inputElement.style.overflow = "hidden";
    return this._inputElement.style.webkitFontSmoothing = "antialiased";
  };

  InputLayer.prototype.addBackgroundLayer = function(layer) {
    this._background = layer;
    this._background.parent = this;
    this._background.name = "background";
    this._background.x = this._background.y = 0;
    this._background._element.appendChild(this._inputElement);
    return this._background;
  };

  InputLayer.prototype.addPlaceHolderLayer = function(layer) {
    var dpr;
    this._isDesignLayer = true;
    this._inputElement.className = "input" + layer.id;
    this.padding = {
      left: 0,
      top: 0
    };
    this._setPlaceholder(layer.text);
    this._setTextProperties(layer);
    this._setPlaceholderColor(layer.id, layer.color);
    this.on("change:color", (function(_this) {
      return function() {
        return _this._setPlaceholderColor(layer.id, _this.color);
      };
    })(this));
    layer.visible = false;
    this._elementHTML.children[0].textContent = "";
    dpr = this._checkDevicePixelRatio();
    this._inputElement.style.fontSize = (layer.fontSize * 2 / dpr) + "px";
    this._inputElement.style.paddingTop = (layer.y * 2 / dpr) + "px";
    this._inputElement.style.paddingLeft = (layer.x * 2 / dpr) + "px";
    this._inputElement.style.width = ((this._background.width - layer.x * 2) * 2 / dpr) + "px";
    if (this.multiLine) {
      this._inputElement.style.height = (this._background.height * 2 / dpr) + "px";
    }
    this.on("change:padding", (function(_this) {
      return function() {
        _this._inputElement.style.paddingTop = (_this.padding.top * 2 / dpr) + "px";
        return _this._inputElement.style.paddingLeft = (_this.padding.left * 2 / dpr) + "px";
      };
    })(this));
    return this._placeholder;
  };

  InputLayer.prototype.focus = function() {
    return this._inputElement.focus();
  };

  InputLayer.define("value", {
    get: function() {
      return this._inputElement.value;
    },
    set: function(value) {
      return this._inputElement.value = value;
    }
  });

  InputLayer.define("focusColor", {
    get: function() {
      return this._inputElement.style.color;
    },
    set: function(value) {
      return this._inputElement.style.color = value;
    }
  });

  InputLayer.define("multiLine", InputLayer.simpleProperty("multiLine", false));

  InputLayer.wrap = function(background, placeholder, options) {
    return wrapInput(new this(options), background, placeholder, options);
  };

  InputLayer.prototype.onEnterKey = function(cb) {
    return this.on(Events.EnterKey, cb);
  };

  InputLayer.prototype.onSpaceKey = function(cb) {
    return this.on(Events.SpaceKey, cb);
  };

  InputLayer.prototype.onBackspaceKey = function(cb) {
    return this.on(Events.BackspaceKey, cb);
  };

  InputLayer.prototype.onCapsLockKey = function(cb) {
    return this.on(Events.CapsLockKey, cb);
  };

  InputLayer.prototype.onShiftKey = function(cb) {
    return this.on(Events.ShiftKey, cb);
  };

  InputLayer.prototype.onValueChange = function(cb) {
    return this.on(Events.ValueChange, cb);
  };

  InputLayer.prototype.onInputFocus = function(cb) {
    return this.on(Events.InputFocus, cb);
  };

  InputLayer.prototype.onInputBlur = function(cb) {
    return this.on(Events.InputBlur, cb);
  };

  return InputLayer;

})(TextLayer);

wrapInput = function(instance, background, placeholder) {
  var input, ref;
  if (!(background instanceof Layer)) {
    throw new Error("InputLayer expects a background layer.");
  }
  if (!(placeholder instanceof TextLayer)) {
    throw new Error("InputLayer expects a text layer.");
  }
  input = instance;
  if (input.__framerInstanceInfo == null) {
    input.__framerInstanceInfo = {};
  }
  if ((ref = input.__framerInstanceInfo) != null) {
    ref.name = instance.constructor.name;
  }
  input.frame = background.frame;
  input.parent = background.parent;
  input.index = background.index;
  input.addBackgroundLayer(background);
  input.addPlaceHolderLayer(placeholder);
  return input;
};


},{}],"myModule":[function(require,module,exports){
exports.myVar = "myVariable";

exports.myFunction = function() {
  return print("myFunction is running");
};

exports.myArray = [1, 2, 3];


},{}]},{},[])
//# sourceMappingURL=data:application/json;charset=utf-8;base64,eyJ2ZXJzaW9uIjozLCJmaWxlIjoiZnJhbWVyLm1vZHVsZXMuanMiLCJzb3VyY2VzIjpbIi4uLy4uLy4uLy4uLy4uL1VzZXJzL2R1Y2h1YW5odS/kur/mlrnkupEvRmFuZ0Nsb3VkVjIv5Liq5Lq65paH5Lu2LzAwMiBGcmFtZXIvMTAwIERheXMgb2YgRnJhbWVyL2RheTAyMF9sb2dpbi5mcmFtZXIvbW9kdWxlcy9teU1vZHVsZS5jb2ZmZWUiLCIuLi8uLi8uLi8uLi8uLi9Vc2Vycy9kdWNodWFuaHUv5Lq/5pa55LqRL0ZhbmdDbG91ZFYyL+S4quS6uuaWh+S7ti8wMDIgRnJhbWVyLzEwMCBEYXlzIG9mIEZyYW1lci9kYXkwMjBfbG9naW4uZnJhbWVyL21vZHVsZXMvaW5wdXQuY29mZmVlIiwibm9kZV9tb2R1bGVzL2Jyb3dzZXItcGFjay9fcHJlbHVkZS5qcyJdLCJzb3VyY2VzQ29udGVudCI6WyIjIEFkZCB0aGUgZm9sbG93aW5nIGxpbmUgdG8geW91ciBwcm9qZWN0IGluIEZyYW1lciBTdHVkaW8uIFxuIyBteU1vZHVsZSA9IHJlcXVpcmUgXCJteU1vZHVsZVwiXG4jIFJlZmVyZW5jZSB0aGUgY29udGVudHMgYnkgbmFtZSwgbGlrZSBteU1vZHVsZS5teUZ1bmN0aW9uKCkgb3IgbXlNb2R1bGUubXlWYXJcblxuZXhwb3J0cy5teVZhciA9IFwibXlWYXJpYWJsZVwiXG5cbmV4cG9ydHMubXlGdW5jdGlvbiA9IC0+XG5cdHByaW50IFwibXlGdW5jdGlvbiBpcyBydW5uaW5nXCJcblxuZXhwb3J0cy5teUFycmF5ID0gWzEsIDIsIDNdIiwiRXZlbnRzLkVudGVyS2V5ID0gXCJFbnRlcktleVwiXG5FdmVudHMuU3BhY2VLZXkgPSBcIlNwYWNlS2V5XCJcbkV2ZW50cy5CYWNrc3BhY2VLZXkgPSBcIkJhY2tzcGFjZUtleVwiXG5FdmVudHMuQ2Fwc0xvY2tLZXkgPSBcIkNhcHNMb2NrS2V5XCJcbkV2ZW50cy5TaGlmdEtleSA9IFwiU2hpZnRLZXlcIlxuRXZlbnRzLlZhbHVlQ2hhbmdlID0gXCJWYWx1ZUNoYW5nZVwiXG5FdmVudHMuSW5wdXRGb2N1cyA9IFwiSW5wdXRGb2N1c1wiXG5FdmVudHMuSW5wdXRCbHVyID0gXCJJbnB1dEJsdXJcIlxuXG5jbGFzcyBleHBvcnRzLklucHV0TGF5ZXIgZXh0ZW5kcyBUZXh0TGF5ZXJcblxuXHRjb25zdHJ1Y3RvcjogKG9wdGlvbnM9e30pIC0+XG5cblx0XHRfLmRlZmF1bHRzIG9wdGlvbnMsXG5cdFx0XHRiYWNrZ3JvdW5kQ29sb3I6IFwiI0ZGRlwiXG5cdFx0XHR3aWR0aDogMzc1XG5cdFx0XHRoZWlnaHQ6IDYwXG5cdFx0XHRwYWRkaW5nOlxuXHRcdFx0XHRsZWZ0OiAyMFxuXHRcdFx0dGV4dDogXCJUeXBlIHNvbWV0aGluZy4uLlwiXG5cdFx0XHRmb250U2l6ZTogNDBcblx0XHRcdGZvbnRXZWlnaHQ6IDMwMFxuXG5cdFx0aWYgb3B0aW9ucy5tdWx0aUxpbmVcblx0XHRcdG9wdGlvbnMucGFkZGluZy50b3AgPz0gMjBcblxuXHRcdEBfaW5wdXRFbGVtZW50ID0gZG9jdW1lbnQuY3JlYXRlRWxlbWVudChcImlucHV0XCIpXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUucG9zaXRpb24gPSBcImFic29sdXRlXCJcblxuXHRcdHN1cGVyIG9wdGlvbnNcblxuXHRcdCMgR2xvYmFsc1xuXHRcdEBfYmFja2dyb3VuZCA9IHVuZGVmaW5lZFxuXHRcdEBfcGxhY2Vob2xkZXIgPSB1bmRlZmluZWRcblx0XHRAX2lzRGVzaWduTGF5ZXIgPSBmYWxzZVxuXG5cdFx0IyBMYXllciBjb250YWluaW5nIGlucHV0IGVsZW1lbnRcblx0XHRAaW5wdXQgPSBuZXcgTGF5ZXJcblx0XHRcdGJhY2tncm91bmRDb2xvcjogXCJ0cmFuc3BhcmVudFwiXG5cdFx0XHRuYW1lOiBcImlucHV0XCJcblx0XHRcdHdpZHRoOiBAd2lkdGhcblx0XHRcdGhlaWdodDogQGhlaWdodFxuXHRcdFx0cGFyZW50OiBAXG5cblx0XHQjIFRleHQgYXJlYVxuXHRcdGlmIEBtdWx0aUxpbmVcblx0XHRcdEBfaW5wdXRFbGVtZW50ID0gZG9jdW1lbnQuY3JlYXRlRWxlbWVudChcInRleHRhcmVhXCIpXG5cblx0XHQjIEFwcGVuZCBlbGVtZW50XG5cdFx0QGlucHV0Ll9lbGVtZW50LmFwcGVuZENoaWxkKEBfaW5wdXRFbGVtZW50KVxuXG5cdFx0IyBNYXRjaCBUZXh0TGF5ZXIgZGVmYXVsdHMgYW5kIHR5cGUgcHJvcGVydGllc1xuXHRcdEBfc2V0VGV4dFByb3BlcnRpZXMoQClcblxuXHRcdCMgU2V0IGF0dHJpYnV0ZXNcblx0XHRAX2lucHV0RWxlbWVudC5hdXRvY29tcGxldGUgPSBcIm9mZlwiXG5cdFx0QF9pbnB1dEVsZW1lbnQuYXV0b2NvcnJlY3QgPSBcIm9mZlwiXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3BlbGxjaGVjayA9IGZhbHNlXG5cblx0XHQjIFRoZSBpZCBzZXJ2ZXMgdG8gZGlmZmVyZW50aWF0ZSBtdWx0aXBsZSBpbnB1dCBlbGVtZW50cyBmcm9tIG9uZSBhbm90aGVyLlxuXHRcdCMgVG8gYWxsb3cgc3R5bGluZyB0aGUgcGxhY2Vob2xkZXIgY29sb3JzIG9mIHNlcGVyYXRlIGVsZW1lbnRzLlxuXHRcdEBfaW5wdXRFbGVtZW50LmNsYXNzTmFtZSA9IFwiaW5wdXRcIiArIEBpZFxuXG5cdFx0IyBBbGwgaW5oZXJpdGVkIHByb3BlcnRpZXNcblx0XHR0ZXh0UHJvcGVydGllcyA9XG5cdFx0XHR7QHRleHQsIEBmb250RmFtaWx5LCBAZm9udFNpemUsIEBsaW5lSGVpZ2h0LCBAZm9udFdlaWdodCwgQGNvbG9yLCBAYmFja2dyb3VuZENvbG9yLCBAd2lkdGgsIEBoZWlnaHQsIEBwYWRkaW5nLCBAcGFyZW50fVxuXG5cdFx0Zm9yIHByb3BlcnR5LCB2YWx1ZSBvZiB0ZXh0UHJvcGVydGllc1xuXG5cdFx0XHRAb24gXCJjaGFuZ2U6I3twcm9wZXJ0eX1cIiwgKHZhbHVlKSA9PlxuXHRcdFx0XHQjIFJlc2V0IHRleHRMYXllciBjb250ZW50c1xuXHRcdFx0XHRAX2VsZW1lbnRIVE1MLmNoaWxkcmVuWzBdLnRleHRDb250ZW50ID0gXCJcIlxuXG5cdFx0XHRcdHJldHVybiBpZiBAX2lzRGVzaWduTGF5ZXJcblx0XHRcdFx0QF9zZXRUZXh0UHJvcGVydGllcyhAKVxuXHRcdFx0XHRAX3NldFBsYWNlaG9sZGVyQ29sb3IoQF9pZCwgQGNvbG9yKVxuXG5cblx0XHQjIFNldCBkZWZhdWx0IHBsYWNlaG9sZGVyXG5cdFx0QF9zZXRQbGFjZWhvbGRlcihAdGV4dClcblx0XHRAX3NldFBsYWNlaG9sZGVyQ29sb3IoQF9pZCwgQGNvbG9yKVxuXG5cdFx0IyBSZXNldCB0ZXh0TGF5ZXIgY29udGVudHNcblx0XHRAX2VsZW1lbnRIVE1MLmNoaWxkcmVuWzBdLnRleHRDb250ZW50ID0gXCJcIlxuXG5cdFx0IyBDaGVjayBpZiBpbiBmb2N1c1xuXHRcdEBfaXNGb2N1c2VkID0gZmFsc2VcblxuXHRcdCMgRGVmYXVsdCBmb2N1cyBpbnRlcmFjdGlvblxuXHRcdEBfaW5wdXRFbGVtZW50Lm9uZm9jdXMgPSAoZSkgPT5cblxuXHRcdFx0QGZvY3VzQ29sb3IgPz0gXCIjMDAwXCJcblxuXHRcdFx0IyBFbWl0IGZvY3VzIGV2ZW50XG5cdFx0XHRAZW1pdChFdmVudHMuSW5wdXRGb2N1cywgZXZlbnQpXG5cblx0XHRcdEBfaXNGb2N1c2VkID0gdHJ1ZVxuXG5cdFx0IyBFbWl0IGJsdXIgZXZlbnRcblx0XHRAX2lucHV0RWxlbWVudC5vbmJsdXIgPSAoZSkgPT5cblx0XHRcdEBlbWl0KEV2ZW50cy5JbnB1dEJsdXIsIGV2ZW50KVxuXG5cdFx0XHRAX2lzRm9jdXNlZCA9IGZhbHNlXG5cblx0XHQjIFRvIGZpbHRlciBpZiB2YWx1ZSBjaGFuZ2VkIGxhdGVyXG5cdFx0Y3VycmVudFZhbHVlID0gdW5kZWZpbmVkXG5cblx0XHQjIFN0b3JlIGN1cnJlbnQgdmFsdWVcblx0XHRAX2lucHV0RWxlbWVudC5vbmtleWRvd24gPSAoZSkgPT5cblx0XHRcdGN1cnJlbnRWYWx1ZSA9IEB2YWx1ZVxuXG5cdFx0XHQjIElmIGNhcHMgbG9jayBrZXkgaXMgcHJlc3NlZCBkb3duXG5cdFx0XHRpZiBlLndoaWNoIGlzIDIwXG5cdFx0XHRcdEBlbWl0KEV2ZW50cy5DYXBzTG9ja0tleSwgZXZlbnQpXG5cblx0XHRcdCMgSWYgc2hpZnQga2V5IGlzIHByZXNzZWRcblx0XHRcdGlmIGUud2hpY2ggaXMgMTZcblx0XHRcdFx0QGVtaXQoRXZlbnRzLlNoaWZ0S2V5LCBldmVudClcblxuXHRcdEBfaW5wdXRFbGVtZW50Lm9ua2V5dXAgPSAoZSkgPT5cblxuXHRcdFx0aWYgY3VycmVudFZhbHVlIGlzbnQgQHZhbHVlXG5cdFx0XHRcdEBlbWl0KFwiY2hhbmdlOnZhbHVlXCIsIEB2YWx1ZSlcblx0XHRcdFx0QGVtaXQoRXZlbnRzLlZhbHVlQ2hhbmdlLCBAdmFsdWUpXG5cblx0XHRcdCMgSWYgZW50ZXIga2V5IGlzIHByZXNzZWRcblx0XHRcdGlmIGUud2hpY2ggaXMgMTNcblx0XHRcdFx0QGVtaXQoRXZlbnRzLkVudGVyS2V5LCBldmVudClcblxuXHRcdFx0IyBJZiBiYWNrc3BhY2Uga2V5IGlzIHByZXNzZWRcblx0XHRcdGlmIGUud2hpY2ggaXMgOFxuXHRcdFx0XHRAZW1pdChFdmVudHMuQmFja3NwYWNlS2V5LCBldmVudClcblxuXHRcdFx0IyBJZiBzcGFjZSBrZXkgaXMgcHJlc3NlZFxuXHRcdFx0aWYgZS53aGljaCBpcyAzMlxuXHRcdFx0XHRAZW1pdChFdmVudHMuU3BhY2VLZXksIGV2ZW50KVxuXG5cdFx0XHQjIElmIGNhcHMgbG9jayBrZXkgaXMgcHJlc3NlZCB1cFxuXHRcdFx0aWYgZS53aGljaCBpcyAyMFxuXHRcdFx0XHRAZW1pdChFdmVudHMuQ2Fwc0xvY2tLZXksIGV2ZW50KVxuXG5cdF9zZXRQbGFjZWhvbGRlcjogKHRleHQpID0+XG5cdFx0QF9pbnB1dEVsZW1lbnQucGxhY2Vob2xkZXIgPSB0ZXh0XG5cblx0X3NldFBsYWNlaG9sZGVyQ29sb3I6IChpZCwgY29sb3IpIC0+XG5cdFx0ZG9jdW1lbnQuc3R5bGVTaGVldHNbMF0uYWRkUnVsZShcIi5pbnB1dCN7aWR9Ojotd2Via2l0LWlucHV0LXBsYWNlaG9sZGVyXCIsIFwiY29sb3I6ICN7Y29sb3J9XCIpXG5cblx0X2NoZWNrRGV2aWNlUGl4ZWxSYXRpbzogLT5cblx0XHRyYXRpbyA9IChTY3JlZW4ud2lkdGggLyBGcmFtZXIuRGV2aWNlLnNjcmVlbi53aWR0aClcblx0XHRpZiBVdGlscy5pc0Rlc2t0b3AoKVxuXHRcdFx0IyBAM3hcblx0XHRcdGlmIHJhdGlvIDwgMC41IGFuZCByYXRpbyA+IDAuMjVcblx0XHRcdFx0ZHByID0gMSAtIHJhdGlvXG5cdFx0XHQjIEA0eFxuXHRcdFx0ZWxzZSBpZiByYXRpbyBpcyAwLjI1XG5cdFx0XHRcdGRwciA9IDEgLSAocmF0aW8gKiAyKVxuXHRcdFx0IyBAMXgsIEAyeFxuXHRcdFx0ZWxzZVxuXHRcdFx0XHRkcHIgPSBVdGlscy5kZXZpY2VQaXhlbFJhdGlvKClcblx0XHRcdGlmIEZyYW1lci5EZXZpY2UuZGV2aWNlVHlwZSBpcyBcImZ1bGxzY3JlZW5cIlxuXHRcdFx0XHRkcHIgPSAyXG5cdFx0ZWxzZVxuXHRcdFx0IyBAM3hcblx0XHRcdGlmIHJhdGlvIDwgMC41IGFuZCByYXRpbyA+IDAuMjVcblx0XHRcdFx0ZHByID0gMSAtIHJhdGlvXG5cdFx0XHQjIEA0eFxuXHRcdFx0ZWxzZSBpZiByYXRpbyBpcyAwLjI1XG5cdFx0XHRcdGRwciA9IDEgLSAocmF0aW8gKiAyKVxuXHRcdFx0IyBAMXgsIEAyeFxuXHRcdFx0ZWxzZSBpZiByYXRpbyBpcyAwLjVcblx0XHRcdFx0ZHByID0gMVxuXG5cdFx0cmV0dXJuIGRwclxuXG5cdF9zZXRUZXh0UHJvcGVydGllczogKGxheWVyKSA9PlxuXG5cdFx0ZHByID0gQF9jaGVja0RldmljZVBpeGVsUmF0aW8oKVxuXG5cdFx0aWYgbm90IEBfaXNEZXNpZ25MYXllclxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUuZm9udEZhbWlseSA9IGxheWVyLmZvbnRGYW1pbHlcblx0XHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLmZvbnRTaXplID0gXCIje2xheWVyLmZvbnRTaXplIC8gZHByfXB4XCJcblx0XHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLmZvbnRXZWlnaHQgPSBsYXllci5mb250V2VpZ2h0ID8gXCJub3JtYWxcIlxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUucGFkZGluZ1RvcCA9IFwiI3tsYXllci5wYWRkaW5nLnRvcCAqIDIgLyBkcHJ9cHhcIlxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUucGFkZGluZ1JpZ2h0ID0gXCIje2xheWVyLnBhZGRpbmcuYm90dG9tICogMiAvIGRwcn1weFwiXG5cdFx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5wYWRkaW5nQm90dG9tID0gXCIje2xheWVyLnBhZGRpbmcucmlnaHQgKiAyIC8gZHByfXB4XCJcblx0XHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLnBhZGRpbmdMZWZ0ID0gXCIje2xheWVyLnBhZGRpbmcubGVmdCAqIDIgLyBkcHJ9cHhcIlxuXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUud2lkdGggPSBcIiN7KChsYXllci53aWR0aCAtIGxheWVyLnBhZGRpbmcubGVmdCAqIDIpICogMiAvIGRwcil9cHhcIlxuXHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLmhlaWdodCA9IFwiI3tsYXllci5oZWlnaHQgKiAyIC8gZHByfXB4XCJcblx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5vdXRsaW5lID0gXCJub25lXCJcblx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5iYWNrZ3JvdW5kQ29sb3IgPSBcInRyYW5zcGFyZW50XCJcblx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5jdXJzb3IgPSBcImF1dG9cIlxuXHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLndlYmtpdEFwcGVhcmFuY2UgPSBcIm5vbmVcIlxuXHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLnJlc2l6ZSA9IFwibm9uZVwiXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUub3ZlcmZsb3cgPSBcImhpZGRlblwiXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUud2Via2l0Rm9udFNtb290aGluZyA9IFwiYW50aWFsaWFzZWRcIlxuXG5cdGFkZEJhY2tncm91bmRMYXllcjogKGxheWVyKSAtPlxuXHRcdEBfYmFja2dyb3VuZCA9IGxheWVyXG5cdFx0QF9iYWNrZ3JvdW5kLnBhcmVudCA9IEBcblx0XHRAX2JhY2tncm91bmQubmFtZSA9IFwiYmFja2dyb3VuZFwiXG5cdFx0QF9iYWNrZ3JvdW5kLnggPSBAX2JhY2tncm91bmQueSA9IDBcblx0XHRAX2JhY2tncm91bmQuX2VsZW1lbnQuYXBwZW5kQ2hpbGQoQF9pbnB1dEVsZW1lbnQpXG5cblx0XHRyZXR1cm4gQF9iYWNrZ3JvdW5kXG5cblx0YWRkUGxhY2VIb2xkZXJMYXllcjogKGxheWVyKSAtPlxuXG5cdFx0QF9pc0Rlc2lnbkxheWVyID0gdHJ1ZVxuXHRcdEBfaW5wdXRFbGVtZW50LmNsYXNzTmFtZSA9IFwiaW5wdXRcIiArIGxheWVyLmlkXG5cdFx0QHBhZGRpbmcgPSBsZWZ0OiAwLCB0b3A6IDBcblxuXHRcdEBfc2V0UGxhY2Vob2xkZXIobGF5ZXIudGV4dClcblx0XHRAX3NldFRleHRQcm9wZXJ0aWVzKGxheWVyKVxuXHRcdEBfc2V0UGxhY2Vob2xkZXJDb2xvcihsYXllci5pZCwgbGF5ZXIuY29sb3IpXG5cblx0XHRAb24gXCJjaGFuZ2U6Y29sb3JcIiwgPT5cblx0XHRcdEBfc2V0UGxhY2Vob2xkZXJDb2xvcihsYXllci5pZCwgQGNvbG9yKVxuXG5cdFx0IyBSZW1vdmUgb3JpZ2luYWwgbGF5ZXJcblx0XHRsYXllci52aXNpYmxlID0gZmFsc2Vcblx0XHRAX2VsZW1lbnRIVE1MLmNoaWxkcmVuWzBdLnRleHRDb250ZW50ID0gXCJcIlxuXG5cdFx0IyBDb252ZXJ0IHBvc2l0aW9uIHRvIHBhZGRpbmdcblx0XHRkcHIgPSBAX2NoZWNrRGV2aWNlUGl4ZWxSYXRpbygpXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUuZm9udFNpemUgPSBcIiN7bGF5ZXIuZm9udFNpemUgKiAyIC8gZHByfXB4XCJcblx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5wYWRkaW5nVG9wID0gXCIje2xheWVyLnkgKiAyIC8gZHByfXB4XCJcblx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5wYWRkaW5nTGVmdCA9IFwiI3tsYXllci54ICogMiAvIGRwcn1weFwiXG5cdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUud2lkdGggPSBcIiN7KEBfYmFja2dyb3VuZC53aWR0aCAtIGxheWVyLnggKiAyKSAqIDIgLyBkcHJ9cHhcIlxuXG5cdFx0aWYgQG11bHRpTGluZVxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUuaGVpZ2h0ID0gXCIje0BfYmFja2dyb3VuZC5oZWlnaHQgKiAyIC8gZHByfXB4XCJcblxuXHRcdEBvbiBcImNoYW5nZTpwYWRkaW5nXCIsID0+XG5cdFx0XHRAX2lucHV0RWxlbWVudC5zdHlsZS5wYWRkaW5nVG9wID0gXCIje0BwYWRkaW5nLnRvcCAqIDIgLyBkcHJ9cHhcIlxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUucGFkZGluZ0xlZnQgPSBcIiN7QHBhZGRpbmcubGVmdCAqIDIgLyBkcHJ9cHhcIlxuXG5cdFx0cmV0dXJuIEBfcGxhY2Vob2xkZXJcblxuXHRmb2N1czogLT5cblx0XHRAX2lucHV0RWxlbWVudC5mb2N1cygpXG5cblx0QGRlZmluZSBcInZhbHVlXCIsXG5cdFx0Z2V0OiAtPiBAX2lucHV0RWxlbWVudC52YWx1ZVxuXHRcdHNldDogKHZhbHVlKSAtPlxuXHRcdFx0QF9pbnB1dEVsZW1lbnQudmFsdWUgPSB2YWx1ZVxuXG5cdEBkZWZpbmUgXCJmb2N1c0NvbG9yXCIsXG5cdFx0Z2V0OiAtPlxuXHRcdFx0QF9pbnB1dEVsZW1lbnQuc3R5bGUuY29sb3Jcblx0XHRzZXQ6ICh2YWx1ZSkgLT5cblx0XHRcdEBfaW5wdXRFbGVtZW50LnN0eWxlLmNvbG9yID0gdmFsdWVcblxuXHRAZGVmaW5lIFwibXVsdGlMaW5lXCIsIEBzaW1wbGVQcm9wZXJ0eShcIm11bHRpTGluZVwiLCBmYWxzZSlcblxuXHQjIE5ldyBDb25zdHJ1Y3RvclxuXHRAd3JhcCA9IChiYWNrZ3JvdW5kLCBwbGFjZWhvbGRlciwgb3B0aW9ucykgLT5cblx0XHRyZXR1cm4gd3JhcElucHV0KG5ldyBAKG9wdGlvbnMpLCBiYWNrZ3JvdW5kLCBwbGFjZWhvbGRlciwgb3B0aW9ucylcblxuXHRvbkVudGVyS2V5OiAoY2IpIC0+IEBvbihFdmVudHMuRW50ZXJLZXksIGNiKVxuXHRvblNwYWNlS2V5OiAoY2IpIC0+IEBvbihFdmVudHMuU3BhY2VLZXksIGNiKVxuXHRvbkJhY2tzcGFjZUtleTogKGNiKSAtPiBAb24oRXZlbnRzLkJhY2tzcGFjZUtleSwgY2IpXG5cdG9uQ2Fwc0xvY2tLZXk6IChjYikgLT4gQG9uKEV2ZW50cy5DYXBzTG9ja0tleSwgY2IpXG5cdG9uU2hpZnRLZXk6IChjYikgLT4gQG9uKEV2ZW50cy5TaGlmdEtleSwgY2IpXG5cdG9uVmFsdWVDaGFuZ2U6IChjYikgLT4gQG9uKEV2ZW50cy5WYWx1ZUNoYW5nZSwgY2IpXG5cdG9uSW5wdXRGb2N1czogKGNiKSAtPiBAb24oRXZlbnRzLklucHV0Rm9jdXMsIGNiKVxuXHRvbklucHV0Qmx1cjogKGNiKSAtPiBAb24oRXZlbnRzLklucHV0Qmx1ciwgY2IpXG5cbndyYXBJbnB1dCA9IChpbnN0YW5jZSwgYmFja2dyb3VuZCwgcGxhY2Vob2xkZXIpIC0+XG5cdGlmIG5vdCAoYmFja2dyb3VuZCBpbnN0YW5jZW9mIExheWVyKVxuXHRcdHRocm93IG5ldyBFcnJvcihcIklucHV0TGF5ZXIgZXhwZWN0cyBhIGJhY2tncm91bmQgbGF5ZXIuXCIpXG5cblx0aWYgbm90IChwbGFjZWhvbGRlciBpbnN0YW5jZW9mIFRleHRMYXllcilcblx0XHR0aHJvdyBuZXcgRXJyb3IoXCJJbnB1dExheWVyIGV4cGVjdHMgYSB0ZXh0IGxheWVyLlwiKVxuXG5cdGlucHV0ID0gaW5zdGFuY2VcblxuXHRpbnB1dC5fX2ZyYW1lckluc3RhbmNlSW5mbyA/PSB7fVxuXHRpbnB1dC5fX2ZyYW1lckluc3RhbmNlSW5mbz8ubmFtZSA9IGluc3RhbmNlLmNvbnN0cnVjdG9yLm5hbWVcblxuXHRpbnB1dC5mcmFtZSA9IGJhY2tncm91bmQuZnJhbWVcblx0aW5wdXQucGFyZW50ID0gYmFja2dyb3VuZC5wYXJlbnRcblx0aW5wdXQuaW5kZXggPSBiYWNrZ3JvdW5kLmluZGV4XG5cblx0aW5wdXQuYWRkQmFja2dyb3VuZExheWVyKGJhY2tncm91bmQpXG5cdGlucHV0LmFkZFBsYWNlSG9sZGVyTGF5ZXIocGxhY2Vob2xkZXIpXG5cblx0cmV0dXJuIGlucHV0IiwiKGZ1bmN0aW9uIGUodCxuLHIpe2Z1bmN0aW9uIHMobyx1KXtpZighbltvXSl7aWYoIXRbb10pe3ZhciBhPXR5cGVvZiByZXF1aXJlPT1cImZ1bmN0aW9uXCImJnJlcXVpcmU7aWYoIXUmJmEpcmV0dXJuIGEobywhMCk7aWYoaSlyZXR1cm4gaShvLCEwKTt2YXIgZj1uZXcgRXJyb3IoXCJDYW5ub3QgZmluZCBtb2R1bGUgJ1wiK28rXCInXCIpO3Rocm93IGYuY29kZT1cIk1PRFVMRV9OT1RfRk9VTkRcIixmfXZhciBsPW5bb109e2V4cG9ydHM6e319O3Rbb11bMF0uY2FsbChsLmV4cG9ydHMsZnVuY3Rpb24oZSl7dmFyIG49dFtvXVsxXVtlXTtyZXR1cm4gcyhuP246ZSl9LGwsbC5leHBvcnRzLGUsdCxuLHIpfXJldHVybiBuW29dLmV4cG9ydHN9dmFyIGk9dHlwZW9mIHJlcXVpcmU9PVwiZnVuY3Rpb25cIiYmcmVxdWlyZTtmb3IodmFyIG89MDtvPHIubGVuZ3RoO28rKylzKHJbb10pO3JldHVybiBzfSkiXSwibmFtZXMiOltdLCJtYXBwaW5ncyI6IkFFQUE7QURBQSxJQUFBLFNBQUE7RUFBQTs7OztBQUFBLE1BQU0sQ0FBQyxRQUFQLEdBQWtCOztBQUNsQixNQUFNLENBQUMsUUFBUCxHQUFrQjs7QUFDbEIsTUFBTSxDQUFDLFlBQVAsR0FBc0I7O0FBQ3RCLE1BQU0sQ0FBQyxXQUFQLEdBQXFCOztBQUNyQixNQUFNLENBQUMsUUFBUCxHQUFr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
