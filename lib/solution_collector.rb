require 'octokit'
require 'net/http'

class SolutionCollector
  REPO_PATH = 'ruby-vietnam/hardcore-rule'
  def report(current_week)
    current_week_texts = [
      "week#{current_week}",
      "week #{current_week}"
    ]
    current_week_regex = Regexp.union(current_week_texts)

    client = Octokit::Client.new(access_token: ENV['GITHUB_TOKEN'])

    participants_file = client.contents(REPO_PATH, path: 'algorithms/PARTICIPANTS.md')
    response = Net::HTTP.get(URI.parse(participants_file['download_url']))

    participants = {}
    rows = response.split("\n")
    rows.each do |row|
      _, github_account, slack_account = row.split('-').map(&:strip)
      participants.merge!(github_account => slack_account)
    end

    pull_requests = client.pull_requests(REPO_PATH, state: 'open')
    submitted_prs = []

    pull_requests.each do |pr|
      if pr['title'].match(current_week_regex)
        body = pr['body']
        score = 0

        if body.match(/\[x\] Problem 1/)
          score += 1
        end

        if body.match(/\[x\] Problem 2/)
          score += 2
        end

        if body.match(/\[x\] Problem 3/)
          score += 4
        end

        if body.match(/\[x\] Problem 4/)
          score += 8
        end

        submitted_prs << {
          account: pr['user']['login'],
          score: score
        }
      end
    end

    not_submitted_prs = participants.keys - submitted_prs.map { |pr| pr[:account] }

    {
      submitted: submitted_prs.sort_by { |pr| -pr[:score] },
      not_submitted: not_submitted_prs
    }
  end
end
