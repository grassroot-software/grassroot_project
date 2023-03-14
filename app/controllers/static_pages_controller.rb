class StaticPagesController < ApplicationController
  def home
    @landing_page = true
    @success_stories = SuccessStory.limit(4)
    @courses = Course.badges
  end

  def about; end

  def orientation; end

  def blog; end

  def blog1; end
  def blog2; end
  def blog3; end

  def faq; end

  def terms_of_use; end

  def success_stories
    @success_stories = SuccessStory.all
  end
end
