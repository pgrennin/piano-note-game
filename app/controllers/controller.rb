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


# Actions when user takes a guess
get "/game/guess" do

  # the letter the user chose
  letter_chosen = params[:letter].to_s
  # the actual position of the note when user clicked
  current_position =  params[:currentPosition]
  # the actual correct answer
  actual_answer = $possible_positions_hash[current_position].to_s
  # check whether the user's answer was correct
  correct = correct?(actual_answer, letter_chosen)
  # selects a random position for note to send back
  random_position = $possible_positions_hash.keys.sample

  # record guess in database for stats purposes
  @game = Game.find(session[:game_id])
  @game.guesses.create(correct: correct, user_guess: letter_chosen, correct_answer: actual_answer)
  puts @game.guesses.inspect

  # Stats
  num_guesses = @game.guesses.count
  num_correct = @game.guesses.where(correct: true).count
  num_wrong = num_guesses - num_correct
  puts percent_correct = ((num_correct.to_f / num_guesses.to_f).to_f * 100).to_i
  percent_correct = "Percent correct: #{percent_correct}%"


  #returns a randomize number (e.g. "100px") as a response
  content_type :json
  response_obj = {
    correct: correct,
    bottom: random_position,
    wrongResponse: wrong_answer_response,
    percentCorrect: percent_correct
    }.to_json
end