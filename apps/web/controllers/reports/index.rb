module Web::Controllers::Reports
  class Index
    include Web::Action

    expose :reports

    def call(params)
      @reports = SolutionCollector.new.report(42)
    end
  end
end
