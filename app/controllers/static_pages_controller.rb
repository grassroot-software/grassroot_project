class StaticPagesController < ApplicationController
  def home
    @landing_page = true
    @success_stories = SuccessStory.all.reverse
    @courses = Course.badges
  end

  def about; end

  def orientation; end

  def blog; end
  def job_placement; end
  def outcomes; end


  def blog1; end
  def blog2; end
  # def blog3; end
  def blog4; end

  def job1; end
  def job2; end
  def job3; end
  def job4; end


  def musa; end
  def ceci; end
  def carlos; end
  def baraka; end
  def elizabeth; end
  def kelvin; end

  
  def faq; end

  def terms_of_use; end

  def success_stories
    @success_stories = SuccessStory.all.reverse
  end
end
