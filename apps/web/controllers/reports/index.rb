module Web::Controllers::Reports
  class Index
    include Web::Action

    expose :reports

    def call(params)
      @reports = SolutionCollector.new.report(41)
    end
  end
end
