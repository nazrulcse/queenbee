module WidgetsHelper

  def widget_graph(title, metric, &block)
    page_actions = block_given? ? capture(&block) : ''
    content_tag :div, class: "widget-graph" do
      content_tag :div, class: "widget" do
        concat content_tag :span, title
        concat content_tag :h2, (metric + page_actions).html_safe
      end
      # <canvas id="sparkline1" width="318" height="79" class="apu" data-chart="spark-line" data-value="[{strokeColor: '#1ca8dd', fillColor:'rgba(28,168,221,.03)', data:[28,68,41,43,96,45,100]}]" data-labels="['a', 'b','c','d','e','f','g']" style="width: 318px; height: 79px;"></canvas>
    end
  end

end
