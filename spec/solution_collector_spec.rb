require_relative '../lib/solution_collector'
require 'spec_helper'

RSpec.describe SolutionCollector do
  describe '#report' do
    let(:collector) { described_class.new }
    let(:current_week) { 41 }
    subject { collector.report(current_week) }

    it 'returns correct result' do
      VCR.use_cassette('solution_collector') do
        expect(subject[:submitted]).to include({ account: 'hieuk09', score: 1 })
        expect(subject[:not_submitted]).to include('huytd')
      end
    end
  end
end
