module Rubin
  def each_pair
    members = self.dup
    members << nil if members.size.odd?
    rounds = members.size - 1
    1.upto(rounds) do |round|
      members._pairing do |left, right|
        yield [left, right, round]
      end
      members._spin
    end
  end

  def _spin
    # 1 4      2 1
    # 2 5  =>  3 4
    # 3 6      5 6
    # 6 is fixed
    self.insert(self.size/2-1, self.delete_at(-2), self.shift)
  end

  def _pairing
    members = self.dup
    count = members.size/2
    0.upto(count-1) do |i|
      yield [members[i], members[i+count]]
    end
  end

  def compete
    current = 0
    each_pair do |left, right, round|
      if current < round
        puts "\nRound #{round}"
        current = round
      end
      puts "#{left} v #{right}" if left && right
    end
  end
end

class Array
  include Rubin
end
