class UserMovie < ActiveRecord::Base
  belongs_to :user
  belongs_to :movie
  def seen?
    if self.seen==true
      "https://i.imgur.com/9ksHnF9.png"
    else
      "https://i.imgur.com/25r8sQK.png"
    end
  end
end
