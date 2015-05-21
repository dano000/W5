# Define what a light state is and it's associated time, add it to all states stack.

class State
  attr_reader :north_south,:east_west,:time, :all_states, :name

  @@all_states = []
  def initialize(ns,ew,time)
    @name = 'State' + (@@all_states.length+1).to_s
    @north_south = ns
    @east_west = ew
    @time = time
    @@all_states.push(self)
  end
  def self.all_states
    @@all_states
  end
end

# Run the simulation with a virtual global clock for simulation_time amount of seconds.
# sim_to_real_time = (real life seconds)/(simulated seconds)
# (ie. a value of sim_to_real_time = 1, means 1 real second per simulated second)

class Simulation
  def initialize(simulation_time,sim_to_real_time)
    @st1 = State.new('Red','Green',40)
    @st2 = State.new('Red','Amber',5)
    @st3 = State.new('Green','Red',70)
    @st4 = State.new('Amber','Red',5)

    @time = 1
    @cur_pos = 0
    @cur = State.all_states[@cur_pos]

    @simulation_time = simulation_time
    @sim_to_real_time = sim_to_real_time

  end

  def run
    (1..@simulation_time).each do |i|
      if @time > @cur.time
        @cur_pos = (@cur_pos +1) % State.all_states.length
        @cur = State.all_states[@cur_pos]
        @time = 1
      end
      puts 'NS: ' + @cur.north_south + ' EW: ' + @cur.east_west + ' internal time: ' + @time.to_s + ' global time: ' + i.to_s + " State Name: " + @cur.name
      @time += 1
      sleep(@sim_to_real_time)
    end
  end
end

sim = Simulation.new(240,0)

sim.run
