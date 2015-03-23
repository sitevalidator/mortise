require 'spec_helper'
require 'json'

describe Mortise::Issue do
  it "sets attributes from data" do
    issue = Mortise::Issue.new(issues[0])

    expect(issue.bp_id).to             eq issues[0]['bpID']
    expect(issue.certainty).to         eq issues[0]['certainty']
    expect(issue.error_description).to eq issues[0]['errorDescription']
    expect(issue.error_snippet).to     eq issues[0]['errorSnippet']
    expect(issue.error_title).to       eq issues[0]['errorTitle']
    expect(issue.position).to          eq issues[0]['position']
    expect(issue.priority).to          eq issues[0]['priority']
    expect(issue.result_title).to      eq issues[0]['resultTitle']
    expect(issue.signature).to         eq issues[0]['signature']
    expect(issue.standards).to         eq issues[0]['standards']
    expect(issue.t_id).to              eq issues[0]['tID']
    expect(issue.xpath).to             eq issues[0]['xpath']
  end

  private

  def issues
    JSON.parse(fixture_file('validationhell.json'))['resultSet']
  end
end
