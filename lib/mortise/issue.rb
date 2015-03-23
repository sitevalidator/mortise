module Mortise
  class Issue
    attr_reader :bp_id, :certainty, :error_description, :error_snippet,
                :error_title, :position, :priority, :result_title, :signature,
                :standards, :t_id, :xpath

    def initialize(data)
      @bp_id             = data['bpID']
      @certainty         = data['certainty']
      @error_description = data['errorDescription']
      @error_snippet     = data['errorSnippet']
      @error_title       = data['errorTitle']
      @position          = data['position']
      @priority          = data['priority']
      @result_title      = data['resultTitle']
      @signature         = data['signature']
      @standards         = data['standards']
      @t_id              = data['tID']
      @xpath             = data['xpath']
    end

  end
end
