get '/'  do
  erb :"login"
end

get '/users/new' do
  erb :"new_user"
end

post '/users' do
  @user = User.new(params[:user])
  if @user.save
    session[:user_id] = @user.id
    redirect '/index'
  else
    @error = "username or password invalid"
    erb :"new_user"
  end
end

get '/index' do
  erb :"index"
end

post '/sessions' do
  # authenticate user

  if @user = User.authenticate(params[:user][:username], params[:user][:password])
    session[:user_id] = @user.id
    # go to page that displays their reviews.
    redirect '/index'
  else
    @error = "Invalid email or password"
    erb :'index'
  end
end

get '/games/new' do
  @game = Game.create(user: current_user)
  session[:game_id] = @game.id
  erb :'new_game'
end

get "/game/guess" do

  possible_positions_hash = {
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

  # the letter the user chose
  puts letter_chosen = params[:letter].to_s
  # the actual position of the note when user clicked
  puts current_position =  params[:currentPosition]
  # the actual correct answer
  puts actual_answer = possible_positions_hash[current_position].to_s
  # check whether the user's answer was correct
  def correct?(correct_answer, user_answer)
    correct_answer == user_answer
  end

  correct = correct?(actual_answer, letter_chosen)



  # selects a random position for note to send back
  random_position = possible_positions_hash.keys.sample

  #returns a randomize number (e.g. "100px") as a response
  content_type :json
  response_obj = {correct: correct, bottom: random_position}.to_json


end