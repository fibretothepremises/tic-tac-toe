module Print
  def slow_print(msg, time)
    msg.each_char do |c|
      print c
      sleep(time)
    end
  end
end