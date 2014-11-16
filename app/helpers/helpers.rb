$possible_positions_hash = {
    "-6px" => "G",
    "4px" => "A",
    "15px" => "B",
    "24px" => "C",
    "33px" => "D",
    "44px" => "E",
    "54px" => "F",
    "65px" => "G",
    "75px" => "A",
    "86px" => "B",
    "120px" => "C",
    "141px" => "D",
    "159px" => "E",
    "169px" => "F",
    "180px" => "G",
    "190px" => "A",
    "201px" => "B",
    "211px" => "C",
    "222px" => "D",
    "232px" => "E",
    "242px" => "F"
  }

def current_user
  @user = User.find(session[:user_id])
end

def correct?(correct_answer, user_answer)
  correct_answer == user_answer
end

def wrong_answer_response
  shakespeare_insults  = [
    "Thou subtle, perjur’d, false, disloyal man!", "Thou art like a toad; ugly and venomous.",
    "Thine forward voice, now, is to speak well of thine friend; thine backward voice is to utter foul speeches and to detract.",
    "Thou art a flesh-monger, a fool and a coward.",
    "A most notable coward, an infinite and endless liar, an hourly promise breaker, the owner of no one good quality.",
    "You scullion! You rampallian! You fustilarian! I’ll tickle your catastrophe!",
    "Methink’st thou art a general offence and every man should beat thee."
  ]

return "Wrong answer, #{shakespeare_insults.sample}"

end
