require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "li", count: 10
  end

  test "You can fill the form with a random word, click the play button, and get a message that the word is not in the grid." do
    visit new_url
    fill_in "word", with: "random"
    click_on "Play"
    assert_text "not in the grid"
  end

  test "You can fill the form with a one-letter consonant word, click play, and get a message that the word is not a valid English word." do
    visit new_url
    fill_in "word", with: "b"
    click_on "Play"
    assert_text "not an english word"
  end
end
