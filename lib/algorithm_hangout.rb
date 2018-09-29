require 'sinatra'
require 'dotenv/load'
require 'json'
require_relative 'solution_collector'

get '/' do
  result = SolutionCollector.new.report(41)
  JSON.generate(result)
end
