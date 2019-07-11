module ActiveAdmin
  class ElasticStats < Arbre::Component
    builder_method :active_admin_elastic_stats

    CONTAINER_STYLE = 'display: flex; justify-content: center; align-items: center;'
    VALUE_STYLE = 'display: flex; flex:1; justify-content: center; align-items: center; flex-direction: column; align-self: baseline; text-align: center;'

    def build(model, attributes = {})
      super(attributes)

      index_name = model.index_name
      panel("Elastic #{index_name.titleize} Stats") do
        div(style: CONTAINER_STYLE) do
          begin
            if Elasticsearch::Model.client.indices.exists(index: index_name)
              build_fields(index_name)
            else
              show_error(index_name)
            end
          rescue Faraday::ConnectionFailed => e
            h2 e.message
          end
        end
      end
    end

    private

    def build_fields(index_name)
      stats = JSON.parse(Elasticsearch::Model.client.indices.stats(index: index_name).to_json)

      primaries = stats.dig('_all', 'primaries')

      {
        document_count: primaries.dig('docs', 'count'),
        size: number_to_human_size(primaries.dig('store', 'size_in_bytes')),
        index_time: primaries.dig('indexing', 'index_time_in_millis').to_s + ' ms',
        search_time: average_search_time(primaries),
        fetch_time: average_fetch_time(primaries)
      }.each do |name, value|
        div style: VALUE_STYLE do
          h1 value
          span name.to_s.titleize
        end
      end
    rescue => e
      div { h3 e.message }
    end

    def average_search_time(primaries)
      total = primaries.dig('search', 'query_total')
      return 'N/A' if total.zero?
      average = primaries.dig('search', 'query_time_in_millis').to_f / total
      "#{average.round(2)} ms"
    end

    def average_fetch_time(primaries)
      total = primaries.dig('search', 'fetch_total')
      return 'N/A' if total.zero?
      average = primaries.dig('search', 'fetch_time_in_millis').to_f / total
      "#{average.round(2)} ms"
    end

    def show_error(index_name)
      h2 "Index #{index_name} does not exist"
    end
  end
end
