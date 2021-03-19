#!/usr/bin/env ruby

def gen_fortune
  max_word_count = 35 # verified with lorem_ipsum_amet word generator
  saying = `fortune`
  num_words_in_fortune = saying.scan(/[[:alpha:]]+/).count
  puts "num_words_in_fortune = #{num_words_in_fortune}"
  if num_words_in_fortune > max_word_count
    return gen_fortune
  end
  return saying
end

#
# Mind: Function names should b unique across all jobs
#
def run_fortune()
  saying = gen_fortune
  send_event('fortune', {text: saying})
  return
end

SCHEDULER.every '5m', :first_in => 0 do
  run_fortune()
end

