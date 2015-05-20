class State

  attr_reader :position, :next_state
  @@all_states = []

  attr_accessor :condition

  def initialize
    puts @@all_states.length

    @next_states = []

    @condition = nil

    if @@all_states.length == 0
      @position = 0
    else
      @position = 1 + @@all_states[@@all_states.length - 1].position
    end

    @@all_states.push(self)
  end

  def self.all_states
    @@all_states
  end

  def add_next_state(state)

    if state.class == State.class
      @next_states += state
    else
      puts "Please provide a valid state"
    end


  end

end





class Light
  def initialize(state= 'Red')

    @state =%w(Red Amber Green)

    @cur

    case state
      when "Red"
        @cur = 0
      when "Amber"
        @cur = 1
      when "Green"
        @cur = 2
    end

  end
  def cycle
    @cur = (@cur + 1) % @states.length
    @states[@cur]
  end

  def current
    @states[@cur]
  end

end

class LightSystem
  def initialize


    st0 = State.new
    st1 = State.new
    st2 = State.new
    st3 = State.new

    st0.next_state = st1
    st1.next_state = st2
    st2.next_state = st3
    st3.next_state = st1

    st0.condition = [light_ns,light_ew]
    st1.condition = [light_ns,light_ew]
    st2.condition = [light_ns,light_ew]
    st3.condition = [light_ns,light_ew]

  end



end