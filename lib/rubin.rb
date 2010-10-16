class Rubin < Array
  def each_matchup
    members = self.dup
    members << nil if members.size.odd?
    rounds = members.size - 1
    1.upto(rounds) do |round|
      pairing(members) do |home, away|
        yield [home, away, round]
      end
      members = spin(members)
    end
  end

  def output(v='v')
    rounds = Hash.new { |hash, key| hash[key] = [] }
    each_matchup do |home, away, round|
      if home && away
        rounds[round] << "#{home} #{v} #{away}"
      end
    end

    output = []
    rounds = rounds.sort_by { |round, v| round }
    rounds.each do |round, pairs|
      output << "Round #{round}"
      pairs.each do |pair|
        output << pair
      end
      output << "\n"
    end
    output.join("\n")
  end

  private
    def spin(members)
      # 1 4      2 1
      # 2 5  =>  3 4
      # 3 6      5 6
      #
      # 6 is fixed
      members.insert(members.size/2-1, members.delete_at(-2), members.shift)
    end

    def pairing(members)
      count = members.size/2
      0.upto(count-1) do |i|
        yield [members[i], members[i+count]]
      end
    end
end
