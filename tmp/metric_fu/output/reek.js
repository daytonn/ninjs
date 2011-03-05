              var g = new Bluff.Line('graph', "1000x600");
      g.theme_37signals();
      g.tooltips = true;
      g.title_font_size = "24px"
      g.legend_font_size = "12px"
      g.marker_font_size = "10px"

        g.title = 'Reek: code smells';
        g.data('ControlCouple', [8])
g.data('Duplication', [9])
g.data('IrresponsibleModule', [2])
g.data('LargeClass', [1])
g.data('LongMethod', [9])
g.data('LongParameterList', [1])
g.data('LowCohesion', [18])
g.data('NestedIterators', [2])
g.data('UncommunicativeName', [1])

        g.labels = {"0":"3/5"};
        g.draw();
