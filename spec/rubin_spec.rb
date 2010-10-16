require 'spec_helper'

describe "Rubin#each_matchup" do
  it "should yields home, away, and round number" do
    teams = Rubin.new(['England', 'France'])
    teams.each_matchup do |home, away, round|
      home.should == 'England'
      away.should == 'France'
      round.should == 1
    end
  end
end

describe "Rubin#output" do
  it "should display all matchups" do
    teams = Rubin.new(['England', 'France'])
    teams.output.should == "Round 1\nEngland v France\n\n"
  end
end
